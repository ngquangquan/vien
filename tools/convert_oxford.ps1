Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# UTF-8 khong BOM (tranh loi font tieng Viet tren Windows PowerShell 5.1)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding           = [System.Text.Encoding]::UTF8
$UTF8NoBom = [System.Text.UTF8Encoding]::new($false)

$OXFORD_JSON  = "D:\oxford-5000-vocabulary-audio-definition-main\data\oxford_5000.json"
$PROJECT_ROOT = "D:\Projects\other\vien"
$OUTPUT_DIR   = "$PROJECT_ROOT\assets\seed\headwords"
$AUDIO_UK_DIR = "$PROJECT_ROOT\assets\audio\uk"
$AUDIO_US_DIR = "$PROJECT_ROOT\assets\audio\us"
$MANIFEST     = "$PROJECT_ROOT\assets\seed\manifest.json"

$CEFR_ORDER = @("a1","a2","b1","b2","c1","c2")
$NOW_MS     = [long](([DateTimeOffset]::UtcNow).ToUnixTimeMilliseconds())

$POS_MAP = @{
    "indefinite article" = "article"
    "definite article"   = "article"
    "modal verb"         = "modal"
    "auxiliary verb"     = "auxiliary"
    "number"             = "numeral"
    "ordinal number"     = "ordinal"
    "predeterminer"      = "predeterminer"
}

function Normalize-Pos([string]$raw) {
    $lower = $raw.ToLower()
    if ($POS_MAP.ContainsKey($lower)) { return $POS_MAP[$lower] }
    return $lower
}

function Normalize-Word([string]$word) {
    $s = $word.ToLower() -replace "'", "" -replace "\.", "" -replace "\s+", "-"
    $s = $s -replace "[^a-z0-9\-]", ""
    return $s
}

function Min-Cefr([string[]]$levels) {
    $arr = @($levels | Sort-Object { $CEFR_ORDER.IndexOf($_.ToLower()) })
    if ($arr.Length -eq 0) { return "A1" }
    return $arr[0].ToUpper()
}

function Audio-AssetKey([string]$filename, [string]$accent) {
    if (-not $filename) { return $null }
    $base = [System.IO.Path]::GetFileName($filename)
    if ($accent -eq "uk") { $full = "$AUDIO_UK_DIR\$base" }
    else                  { $full = "$AUDIO_US_DIR\$base" }
    if (Test-Path $full)  { return "assets/audio/$accent/$base" }
    return $null
}

# ---------------------------------------------------------------------------
Write-Host "[1/5] Doc $OXFORD_JSON ..."
$rawText = [System.IO.File]::ReadAllText($OXFORD_JSON, [System.Text.UTF8Encoding]::new($false))
$raw     = $rawText | ConvertFrom-Json
Write-Host "      OK - doc xong"

# ---------------------------------------------------------------------------
Write-Host "[2/5] Group entries theo word..."
$grouped = @{}

foreach ($prop in $raw.PSObject.Properties) {
    if ($prop.Name -eq "definition") { continue }
    $entry = $prop.Value
    $word  = $entry.word.Trim()
    if (-not $word) { continue }
    if (-not $grouped.ContainsKey($word)) {
        $grouped[$word] = [System.Collections.Generic.List[object]]::new()
    }
    $grouped[$word].Add($entry)
}
Write-Host "      $($grouped.Count) tu unique"

# ---------------------------------------------------------------------------
Write-Host "[3/5] Build headword objects..."

$cefrBuckets = @{}
foreach ($c in $CEFR_ORDER) { $cefrBuckets[$c] = [System.Collections.Generic.List[object]]::new() }
$missingAudio = 0

foreach ($word in ($grouped.Keys | Sort-Object)) {
    $sensesRaw = $grouped[$word]
    $norm      = Normalize-Word $word
    $hwId      = "hw-oxford-$norm"

    $first  = $sensesRaw[0]
    $ipaUk  = if ($first.phon_br)   { [string]$first.phon_br }   else { $null }
    $ipaUs  = if ($first.phon_n_am) { [string]$first.phon_n_am } else { $null }
    $ukFile = if ($first.uk)        { [string]$first.uk }         else { "" }
    $usFile = if ($first.us)        { [string]$first.us }         else { "" }
    $ukKey  = Audio-AssetKey $ukFile "uk"
    $usKey  = Audio-AssetKey $usFile "us"

    $pronunciations = [System.Collections.Generic.List[object]]::new()
    if ($ipaUk -or $ukKey) {
        $pronunciations.Add([pscustomobject]@{
            id           = "pron-$norm-uk"
            accent       = "uk"
            ipa          = $ipaUk
            audioAssetKey= $ukKey
        })
    }
    if ($ipaUs -or $usKey) {
        $pronunciations.Add([pscustomobject]@{
            id           = "pron-$norm-us"
            accent       = "us"
            ipa          = $ipaUs
            audioAssetKey= $usKey
        })
    }

    if (-not $ukKey) { $missingAudio++ }

    $typeCounter = @{}
    $senses      = [System.Collections.Generic.List[object]]::new()

    foreach ($entry in $sensesRaw) {
        $pos = Normalize-Pos ([string]$entry.type)
        if (-not $typeCounter.ContainsKey($pos)) { $typeCounter[$pos] = 0 }
        $typeCounter[$pos]++
        $n       = $typeCounter[$pos]
        $senseId = "sense-$norm-$pos-$n"

        $definition  = if ($entry.definition) { ([string]$entry.definition).Trim() } else { "" }
        $exampleText = if ($entry.example)    { ([string]$entry.example).Trim() }    else { "" }
        $cefrRaw     = if ($entry.cefr)       { [string]$entry.cefr }                else { "a1" }

        $examples = [System.Collections.Generic.List[object]]::new()
        if ($exampleText) {
            $examples.Add([pscustomobject]@{
                id             = "ex-$senseId-1"
                englishText    = $exampleText
                vietnameseText = $null
                note           = $null
                sortOrder      = 1
            })
        }

        $senses.Add([pscustomobject]@{
            id            = $senseId
            senseNumber   = $n
            partOfSpeech  = $pos
            definitionEn  = $definition
            meaningVi     = $null
            cefrLevel     = $cefrRaw.ToUpper()
            registerLabel = $null
            domainLabel   = $null
            grammarNote   = $null
            usageNote     = $null
            isActive      = 1
            tags          = @()
            examples      = @($examples)
        })
    }

    $cefrLevels = $sensesRaw | ForEach-Object { if ($_.cefr) { [string]$_.cefr } else { "a1" } }
    $hwCefr     = Min-Cefr @($cefrLevels)

    $hw = [pscustomobject]@{
        id                 = $hwId
        spelling           = $word
        normalizedSpelling = $word.ToLower()
        homographNo        = 1
        cefrLevel          = $hwCefr
        notes              = $null
        isArchived         = 0
        createdAtMs        = $NOW_MS
        updatedAtMs        = $NOW_MS
        pronunciations     = @($pronunciations)
        inflections        = @()
        senses             = @($senses)
    }

    $level = $hwCefr.ToLower()
    if (-not $cefrBuckets.ContainsKey($level)) { $level = "c2" }
    $cefrBuckets[$level].Add($hw)
}

# ---------------------------------------------------------------------------
Write-Host "[4/5] Xuat seed files..."
New-Item -ItemType Directory -Force -Path $OUTPUT_DIR | Out-Null

$SOURCE_DEF = [pscustomobject]@{
    id      = "src-oxford-5000"
    name    = "Oxford 5000 - Oxford University Press"
    licence = "Educational use only"
    url     = "https://www.oxfordlearnersdictionaries.com/wordlists/oxford3000-5000"
}

$generatedFiles = [System.Collections.Generic.List[object]]::new()

foreach ($level in $CEFR_ORDER) {
    $words = $cefrBuckets[$level]
    if ($words.Count -eq 0) { continue }

    $payload = [pscustomobject]@{
        sources   = @($SOURCE_DEF)
        headwords = @($words)
    }

    $filename = "oxford_$level.json"
    $outPath  = "$OUTPUT_DIR\$filename"

    # -EscapeHandling EscapeNonAscii: giu nguyen ky tu Unicode (tieng Viet) thay vi escape thanh \uXXXX
    # Fallback: PS 5.1 khong co -EscapeHandling nen dung replace thu cong neu can
    $jsonStr = $payload | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($outPath, $jsonStr, $UTF8NoBom)

    $sizeKb = [math]::Round((Get-Item $outPath).Length / 1024)
    Write-Host "      $filename  ($($words.Count) words, $sizeKb KB)"
    $generatedFiles.Add([pscustomobject]@{ path = "headwords/$filename"; version = 1 })
}

$total = ($cefrBuckets.Values | ForEach-Object { $_.Count } | Measure-Object -Sum).Sum
Write-Host "      Tong: $total headwords"
if ($missingAudio -gt 0) {
    Write-Host "      WARN: $missingAudio headwords thieu audio UK"
}

# ---------------------------------------------------------------------------
Write-Host "[5/5] Cap nhat manifest.json..."

$manifestText = [System.IO.File]::ReadAllText($MANIFEST, [System.Text.UTF8Encoding]::new($false))
$manifest     = $manifestText | ConvertFrom-Json

$existingPaths = $manifest.files | ForEach-Object { $_.path }

$added = 0
foreach ($f in $generatedFiles) {
    if ($existingPaths -notcontains $f.path) {
        $manifest.files += $f
        $added++
    }
}

$manifestJson = $manifest | ConvertTo-Json -Depth 5
# Dung WriteAllText thay Set-Content de tranh BOM tren PS 5.1
[System.IO.File]::WriteAllText($MANIFEST, $manifestJson, $UTF8NoBom)
Write-Host "      +$added entries moi them vao manifest"

Write-Host ""
Write-Host "XONG! Rebuild app de SeedService import du lieu."
