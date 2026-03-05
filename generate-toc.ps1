# generate-toc.ps1
# Reads manifest.json, extracts headings from .md files, produces toc.json
# Usage: .\generate-toc.ps1 [-ManifestPath manifest.json] [-OutputPath toc.json]

param(
    [string]$ManifestPath = (Join-Path $PSScriptRoot 'manifest.json'),
    [string]$OutputPath   = (Join-Path $PSScriptRoot 'toc.json')
)

$ErrorActionPreference = 'Stop'
$BaseDir = Split-Path $ManifestPath -Parent

# --- Slugify (mirrors the JS slugify in index.html) ---
function ConvertTo-Slug([string]$Text) {
    $s = $Text.ToLowerInvariant()
    # Normalize and strip combining diacritical marks
    $s = [Text.Encoding]::ASCII.GetString(
        [Text.Encoding]::GetEncoding('Cyrillic').GetBytes($s)
    )
    $s = $s -replace '[^a-z0-9]+', '-'
    $s = $s.Trim('-')
    return $s
}

# --- Extract headings from a .md file -> flat list of { level, name, slug } ---
function Get-MarkdownHeadings([string]$FilePath) {
    if (-not (Test-Path $FilePath)) {
        Write-Warning "File not found: $FilePath"
        return @()
    }
    $lines = Get-Content $FilePath -Encoding UTF8
    $headings = @()
    foreach ($line in $lines) {
        if ($line -match '^(#{1,6})\s+(.+)$') {
            $level = $Matches[1].Length
            $text  = $Matches[2].Trim()
            # Strip trailing # and inline formatting
            $text = $text -replace '\s*#+\s*$', ''
            $headings += [PSCustomObject]@{
                Level = $level
                Name  = $text
                Slug  = ConvertTo-Slug $text
            }
        }
    }
    return $headings
}

# --- Build nested heading tree from flat list ---
function Build-HeadingTree([array]$Headings, [string]$FilePath) {
    $root = [System.Collections.ArrayList]::new()
    # Stack: each entry is @{ node, level }
    $stack = [System.Collections.ArrayList]::new()

    foreach ($h in $Headings) {
        $node = [ordered]@{
            name = $h.Name
            path = "$FilePath#$($h.Slug)"
        }

        # Pop stack until we find a parent with a lower level
        while ($stack.Count -gt 0 -and $stack[$stack.Count - 1].level -ge $h.Level) {
            $stack.RemoveAt($stack.Count - 1)
        }

        if ($stack.Count -eq 0) {
            # Top level
            [void]$root.Add($node)
        } else {
            # Add as child of the last stack entry
            $parent = $stack[$stack.Count - 1].node
            if (-not $parent.Contains('children')) {
                $parent['children'] = [System.Collections.ArrayList]::new()
            }
            [void]$parent['children'].Add($node)
        }

        [void]$stack.Add(@{ node = $node; level = $h.Level })
    }

    return $root
}

# --- Process a manifest TOC entry (recursive) ---
function Process-TocEntry([string]$Label, $Value) {
    if ($Value -is [string]) {
        # Leaf: file path
        $filePath = $Value
        $entry = [ordered]@{
            name = $Label
            path = $filePath
        }

        $fullPath = Join-Path $BaseDir $filePath

        if ($filePath -match '\.md$') {
            $headings = Get-MarkdownHeadings $fullPath
            if ($headings.Count -gt 0) {
                $entry['children'] = Build-HeadingTree $headings $filePath
            }
        }
        # PDF and other files: leaf with no children

        return $entry
    }
    else {
        # Group node (nested object)
        $entry = [ordered]@{
            name     = $Label
            children = [System.Collections.ArrayList]::new()
        }

        foreach ($prop in $Value.PSObject.Properties) {
            $child = Process-TocEntry $prop.Name $prop.Value
            [void]$entry['children'].Add($child)
        }

        return $entry
    }
}

# --- Main ---
Write-Host "Reading manifest: $ManifestPath"
$manifest = Get-Content $ManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json

$toc = [ordered]@{
    name = $manifest.name
    toc  = [System.Collections.ArrayList]::new()
}

foreach ($prop in $manifest.toc.PSObject.Properties) {
    $entry = Process-TocEntry $prop.Name $prop.Value
    [void]$toc['toc'].Add($entry)
}

$json = $toc | ConvertTo-Json -Depth 20 -Compress:$false
# Fix encoding: ConvertTo-Json escapes unicode, we want readable French
$json = [System.Text.RegularExpressions.Regex]::Unescape($json)

$json | Out-File $OutputPath -Encoding UTF8 -NoNewline
Write-Host "TOC generated: $OutputPath"
Write-Host "  Entries: $($toc['toc'].Count) top-level"
