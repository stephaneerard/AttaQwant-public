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
# Uses hierarchical compound slugs: parent-slug/child-slug (mirrors JS renderer)
function Build-HeadingTree([array]$Headings, [string]$FilePath) {
    $root = [System.Collections.ArrayList]::new()
    # Stack: each entry is @{ node, level, slug }
    $stack = [System.Collections.ArrayList]::new()

    foreach ($h in $Headings) {
        # Pop stack back to parent level
        while ($stack.Count -gt 0 -and $stack[$stack.Count - 1].level -ge $h.Level) {
            $stack.RemoveAt($stack.Count - 1)
        }

        # Build compound slug from hierarchy
        $slugParts = @()
        foreach ($s in $stack) { $slugParts += $s.slug }
        $slugParts += $h.Slug
        $compoundSlug = $slugParts -join '/'

        $node = [ordered]@{
            name = $h.Name
            path = "$FilePath#$compoundSlug"
        }

        if ($stack.Count -eq 0) {
            [void]$root.Add($node)
        } else {
            $parent = $stack[$stack.Count - 1].node
            if (-not $parent.Contains('children')) {
                $parent['children'] = [System.Collections.ArrayList]::new()
            }
            [void]$parent['children'].Add($node)
        }

        [void]$stack.Add(@{ node = $node; level = $h.Level; slug = $h.Slug })
    }

    return , $root
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
                $tree = Build-HeadingTree $headings $filePath
                # If the tree has a single H1 root that duplicates the manifest label,
                # skip it and promote its children directly
                if ($tree.Count -eq 1 -and $tree[0].Contains('children') -and $tree[0]['children'].Count -gt 0) {
                    $entry['children'] = $tree[0]['children']
                } else {
                    $entry['children'] = $tree
                }
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

# ConvertTo-Json unwraps single-element arrays; use a custom serializer
Add-Type -AssemblyName System.Web.Extensions 2>$null
function ConvertTo-SafeJson($obj, $indent) {
    if ($null -eq $indent) { $indent = 0 }
    $pad = '  ' * $indent
    $pad1 = '  ' * ($indent + 1)

    if ($obj -is [System.Collections.ArrayList] -or $obj -is [System.Collections.IList] -or $obj -is [array]) {
        if ($obj.Count -eq 0) { return '[]' }
        $items = @()
        foreach ($item in $obj) {
            $items += "$pad1$(ConvertTo-SafeJson $item ($indent + 1))"
        }
        return "[$([Environment]::NewLine)$($items -join ",$([Environment]::NewLine)")$([Environment]::NewLine)$pad]"
    }
    elseif ($obj -is [System.Collections.IDictionary]) {
        $entries = @()
        foreach ($key in $obj.Keys) {
            $val = ConvertTo-SafeJson $obj[$key] ($indent + 1)
            $escapedKey = $key.Replace('\','\\').Replace('"','\"')
            $entries += "$pad1""$escapedKey"": $val"
        }
        return "{$([Environment]::NewLine)$($entries -join ",$([Environment]::NewLine)")$([Environment]::NewLine)$pad}"
    }
    elseif ($obj -is [string]) {
        $escaped = $obj.Replace('\','\\').Replace('"','\"').Replace("`n",'\n').Replace("`r",'\r').Replace("`t",'\t')
        return """$escaped"""
    }
    elseif ($obj -is [bool]) {
        return if ($obj) { 'true' } else { 'false' }
    }
    elseif ($null -eq $obj) {
        return 'null'
    }
    else {
        return "$obj"
    }
}

$json = ConvertTo-SafeJson $toc 0

$json | Out-File $OutputPath -Encoding UTF8 -NoNewline
Write-Host "TOC generated: $OutputPath"
Write-Host "  Entries: $($toc['toc'].Count) top-level"
