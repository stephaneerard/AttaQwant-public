# generate_manifest.ps1
# Scans .md and .pdf files recursively, extracts H1 titles from .md files,
# and produces manifest.json with folder-based grouping.
# Usage: .\generate_manifest.ps1 [-RootDir .] [-OutputPath manifest.json] [-Name "Dossier ..."]

param(
    [string]$RootDir    = $PSScriptRoot,
    [string]$OutputPath = (Join-Path $PSScriptRoot 'manifest.json'),
    [string]$Name       = "Dossier d'Analyse - Qwant SAS",
    [string]$MatrixPath = ''
)

$ErrorActionPreference = 'Stop'

# --- Extract H1 title from a .md file (first line matching ^# ) ---
function Get-MdTitle([string]$FilePath) {
    $lines = Get-Content $FilePath -Encoding UTF8 -TotalCount 20
    foreach ($line in $lines) {
        if ($line -match '^#\s+(.+)$') {
            $title = $Matches[1].Trim()
            # Strip trailing # and markdown formatting
            $title = $title -replace '\s*#+\s*$', ''
            $title = $title -replace '\*\*', ''
            $title = $title -replace '[`_]', ''
            return $title
        }
    }
    return $null
}

# --- Derive a human-readable label from filename ---
function Get-LabelFromFilename([string]$FileName) {
    $base = [IO.Path]::GetFileNameWithoutExtension($FileName)
    # Strip leading number prefix: "00_", "01_", etc.
    $base = $base -replace '^\d+_', ''
    # Replace underscores with spaces
    $base = $base -replace '_', ' '
    # Title case
    $base = (Get-Culture).TextInfo.ToTitleCase($base.ToLower())
    return $base
}

# --- Derive a group label from folder name ---
function Get-GroupLabel([string]$FolderName) {
    $label = $FolderName -replace '_', ' '
    $label = (Get-Culture).TextInfo.ToTitleCase($label.ToLower())
    return $label
}

# --- Custom JSON serializer (handles ArrayLists, ordered dicts) ---
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

# --- Parse matrix.md → ordered list of published entries with New Name ---
function Get-MatrixEntries([string]$Path) {
    $entries = @()
    if (-not (Test-Path $Path)) { return $entries }
    $lines = Get-Content $Path -Encoding UTF8
    foreach ($line in $lines) {
        # 4-column: Order | Publish | File | New Name
        if ($line -match '^\|\s*(\S+)\s*\|\s*(.*?)\s*\|\s*(.+?\.\w+)\s*\|\s*(.*?)\s*\|$') {
            $orderRaw = $Matches[1].Trim()
            $publish  = $Matches[2].Trim()
            $newName  = $Matches[4].Trim()
            if ($orderRaw -ieq 'X') { continue }
            if (-not ($publish -ieq 'x')) { continue }
            $padWidth = if ([int]$orderRaw -gt 99) { 3 } else { 3 }
            $prefix   = "$orderRaw".PadLeft($padWidth, '0')
            $baseName = $newName
            $nameOnly = [System.IO.Path]::GetFileNameWithoutExtension($baseName)
            $entries += [PSCustomObject]@{
                Order    = [int]$orderRaw
                FileName = "$prefix - $baseName"
                PdfName  = "$prefix - $nameOnly.pdf"
                Label    = "$prefix - " + (Get-Culture).TextInfo.ToTitleCase($nameOnly.ToLower())
            }
        }
    }
    return $entries | Sort-Object Order
}

# --- Main ---
Write-Host "Scanning: $RootDir"

# Collect all .md and .pdf files (exclude generate-*, index.html, etc.)
$allFiles = Get-ChildItem -Path $RootDir -Recurse -Include '*.md','*.pdf' |
    Where-Object { $_.Name -notmatch '^(generate|index|README|SOMMAIRE)' } |
    Sort-Object FullName

# Separate root-level files and subfolder files
$rootFiles = @()
$folderGroups = [ordered]@{}

foreach ($f in $allFiles) {
    $relativePath = $f.FullName.Substring($RootDir.TrimEnd('\','/').Length + 1).Replace('\', '/')

    $parts = $relativePath.Split('/')
    if ($parts.Count -eq 1) {
        # Root-level file
        $rootFiles += @{ File = $f; Path = $relativePath }
    } else {
        # Subfolder file
        $folder = $parts[0]
        if (-not $folderGroups.Contains($folder)) {
            $folderGroups[$folder] = @()
        }
        $folderGroups[$folder] += @{ File = $f; Path = $relativePath }
    }
}

# Build the toc ordered dict
$toc = [ordered]@{}

# Root-level files first (sorted by filename)
foreach ($entry in ($rootFiles | Sort-Object { $_.File.Name })) {
    $f = $entry.File
    $path = $entry.Path

    # Try to extract H1 title from .md files
    $label = $null
    if ($f.Extension -eq '.md') {
        $label = Get-MdTitle $f.FullName
    }
    if (-not $label) {
        $label = Get-LabelFromFilename $f.Name
    }

    $toc[$label] = $path
}

# Parse matrix if provided
$matrixEntries = @()
if ($MatrixPath -and (Test-Path $MatrixPath)) {
    $matrixEntries = Get-MatrixEntries $MatrixPath
    Write-Host "  Matrix entries (published): $($matrixEntries.Count)"
}

# Subfolder groups
foreach ($folder in $folderGroups.Keys) {
    $groupLabel = Get-GroupLabel $folder
    $groupEntries = [ordered]@{}

    # If this is an inventaire folder and we have matrix data, use the matrix
    if ($matrixEntries.Count -gt 0 -and $folder -match '^\d+\s*-\s*Inventaire$') {
        Write-Host "  Using matrix for folder: $folder"
        foreach ($me in $matrixEntries) {
            # Try PDF first (from Doc2Pdf), then original filename
            $pdfPath = "$folder/$($me.PdfName)"
            $origPath = "$folder/$($me.FileName)"
            $fullPdfPath = Join-Path $RootDir $pdfPath.Replace('/', '\')
            $fullOrigPath = Join-Path $RootDir $origPath.Replace('/', '\')

            if (Test-Path $fullPdfPath) {
                $groupEntries[$me.Label] = $pdfPath
            } elseif (Test-Path $fullOrigPath) {
                $groupEntries[$me.Label] = $origPath
            } else {
                Write-Warning "  Matrix entry not found on disk: $($me.PdfName)"
            }
        }
    } else {
        foreach ($entry in ($folderGroups[$folder] | Sort-Object { $_.File.Name })) {
            $f = $entry.File
            $path = $entry.Path

            $label = $null
            if ($f.Extension -eq '.md') {
                $label = Get-MdTitle $f.FullName
            }
            if (-not $label) {
                $label = Get-LabelFromFilename $f.Name
            }

            $groupEntries[$label] = $path
        }
    }

    $toc[$groupLabel] = $groupEntries
}

# Build final manifest
$manifest = [ordered]@{
    name = $Name
    toc  = $toc
}

# Serialize and write
$json = ConvertTo-SafeJson $manifest 0
$json | Out-File $OutputPath -Encoding UTF8 -NoNewline

Write-Host "Manifest generated: $OutputPath"
Write-Host "  Root entries: $($rootFiles.Count)"
Write-Host "  Groups: $($folderGroups.Count)"
$total = $rootFiles.Count
foreach ($k in $folderGroups.Keys) { $total += $folderGroups[$k].Count }
Write-Host "  Total files: $total"
