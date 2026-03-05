# generate-summary.ps1
# Generates SOMMAIRE.md with working links based on directory structure and file headings

param(
    [string]$OutputPath = (Join-Path $PSScriptRoot 'SOMMAIRE.md')
)

$ErrorActionPreference = 'Stop'

# --- Extract headings from a .md file -> flat list of { level, name } ---
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
            }
        }
    }
    return $headings
}

# --- Main ---
$Content = "# SOMMAIRE - Qwant Analyse`n`n"

$Dirs = Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+ - .+$' } | Sort-Object { [int]($_.Name -split ' - ')[0] }

foreach ($Dir in $Dirs) {
    $Parts = $Dir.Name -split ' - ', 2
    $Number = $Parts[0]
    $Title = $Parts[1]
    $Content += "## $Number - $Title`n"
    
    $MdFiles = Get-ChildItem -Path $Dir.FullName | Where-Object { $_.Extension -in '.md', '.pdf' } | Sort-Object Name
    
    foreach ($File in $MdFiles) {
        if ($File.Extension -eq '.md') {
            $Headings = Get-MarkdownHeadings $File.FullName
            $MainHeading = $Headings | Where-Object { $_.Level -eq 1 } | Select-Object -First 1
            if ($MainHeading) {
                $DisplayName = $MainHeading.Name
            } else {
                # Fallback: derive from filename
                $FileName = $File.BaseName -replace '^\d+_', ''
                $DisplayName = $FileName -replace '_', ' '
                $DisplayName = (Get-Culture).TextInfo.ToTitleCase($DisplayName.ToLower())
            }
        } else {
            # For PDFs and other files, derive from filename
            $FileName = $File.BaseName -replace '^\d+_', ''
            $DisplayName = $FileName -replace '_', ' '
            $DisplayName = (Get-Culture).TextInfo.ToTitleCase($DisplayName.ToLower())
        }
        
        $EncodedPath = "$($Dir.Name)/$($File.Name)" -replace ' ', '%20'
        $Link = "($EncodedPath)"
        $Content += "- [$DisplayName]$Link`n"
    }
    
    $Content += "`n"
}

$Content | Out-File -FilePath $OutputPath -Encoding UTF8

Write-Host "SOMMAIRE.md generated successfully."