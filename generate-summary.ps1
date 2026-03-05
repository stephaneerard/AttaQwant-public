# generate-summary.ps1
# Generates SOMMAIRE.md with working links based on directory structure and file headings

param(
    [string]$OutputPath = (Join-Path $PSScriptRoot 'SOMMAIRE.md'),
    [string]$MatrixPath = ''
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

# --- Parse matrix.md → ordered list of published entries ---
function Get-MatrixPublished([string]$Path) {
    $entries = @()
    if (-not $Path -or -not (Test-Path $Path)) { return $entries }
    $lines = Get-Content $Path -Encoding UTF8
    foreach ($line in $lines) {
        if ($line -match '^\|\s*(\S+)\s*\|\s*(.*?)\s*\|\s*(.+?\.\w+)\s*\|\s*(.*?)\s*\|$') {
            $orderRaw = $Matches[1].Trim()
            $publish  = $Matches[2].Trim()
            $newName  = $Matches[4].Trim()
            if ($orderRaw -ieq 'X') { continue }
            if (-not ($publish -ieq 'x')) { continue }
            $prefix   = "$orderRaw".PadLeft(3, '0')
            $nameOnly = [System.IO.Path]::GetFileNameWithoutExtension($newName)
            $entries += [PSCustomObject]@{
                Order   = [int]$orderRaw
                PdfName = "$prefix - $nameOnly.pdf"
                Label   = "$prefix - " + (Get-Culture).TextInfo.ToTitleCase($nameOnly.ToLower())
            }
        }
    }
    return $entries | Sort-Object Order
}

# --- Main ---
$Content = "# SOMMAIRE - Qwant Analyse`n`n"

# Parse matrix if provided
$matrixEntries = Get-MatrixPublished $MatrixPath

$Dirs = Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+ - .+$' } | Sort-Object { [int]($_.Name -split ' - ')[0] }

foreach ($Dir in $Dirs) {
    $Parts = $Dir.Name -split ' - ', 2
    $Number = $Parts[0]
    $Title = $Parts[1]
    $Content += "## $Number - $Title`n"

    # If this is an inventaire folder and we have matrix data, use the matrix
    if ($matrixEntries.Count -gt 0 -and $Dir.Name -match '^\d+\s*-\s*Inventaire$') {
        foreach ($me in $matrixEntries) {
            $EncodedPath = "$($Dir.Name)/$($me.PdfName)" -replace ' ', '%20'
            $Content += "- [$($me.Label)]($EncodedPath)`n"
        }
    } else {
        $MdFiles = Get-ChildItem -Path $Dir.FullName | Where-Object { $_.Extension -in '.md', '.pdf' } | Sort-Object Name

        foreach ($File in $MdFiles) {
            if ($File.Extension -eq '.md') {
                $Headings = Get-MarkdownHeadings $File.FullName
                $MainHeading = $Headings | Where-Object { $_.Level -eq 1 } | Select-Object -First 1
                if ($MainHeading) {
                    $DisplayName = $MainHeading.Name
                } else {
                    $FileName = $File.BaseName -replace '^\d+_', ''
                    $DisplayName = $FileName -replace '_', ' '
                    $DisplayName = (Get-Culture).TextInfo.ToTitleCase($DisplayName.ToLower())
                }
            } else {
                $FileName = $File.BaseName -replace '^\d+_', ''
                $DisplayName = $FileName -replace '_', ' '
                $DisplayName = (Get-Culture).TextInfo.ToTitleCase($DisplayName.ToLower())
            }

            $EncodedPath = "$($Dir.Name)/$($File.Name)" -replace ' ', '%20'
            $Content += "- [$DisplayName]($EncodedPath)`n"
        }
    }

    $Content += "`n"
}

$Content | Out-File -FilePath $OutputPath -Encoding UTF8

Write-Host "SOMMAIRE.md generated successfully."