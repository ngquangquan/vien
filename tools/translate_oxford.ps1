# translate_oxford.ps1
# Dich meaningVi va vietnameseText trong cac file oxford_*.json bang Gemini API
#
# Cach dung:
#   $env:GEMINI_API_KEY = "AIza..."
#   powershell -ExecutionPolicy Bypass -File tools\translate_oxford.ps1
#
# Tuy chon:
#   -CefrLevel a1        chi dich 1 file (a1/a2/b1/b2/c1)
#   -BatchSize 40        so senses moi request (default 40)
#   -DryRun              in prompt ra man hinh, khong goi API
#   -ResumeFrom 500      bat dau tu sense thu 500 (resume khi bi ngat)

param(
    [string]$CefrLevel  = "",
    [int]   $BatchSize  = 40,
    [switch]$DryRun,
    [int]   $ResumeFrom = 0
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------
$OUTPUT_DIR  = "D:\Projects\other\vien\assets\seed\headwords"
$API_KEY     = $env:GEMINI_API_KEY
$API_URL     = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$API_KEY"
$PROGRESS_FILE = "D:\Projects\other\vien\tools\translate_progress.json"

if (-not $DryRun -and -not $API_KEY) {
    Write-Host "ERROR: Set bien moi truong GEMINI_API_KEY truoc khi chay."
    Write-Host "  `$env:GEMINI_API_KEY = 'AIza...'"
    exit 1
}

# ---------------------------------------------------------------------------
# Chon file can dich
# ---------------------------------------------------------------------------
if ($CefrLevel) {
    $files = @(Get-Item "$OUTPUT_DIR\oxford_$($CefrLevel.ToLower()).json")
} else {
    $files = Get-ChildItem "$OUTPUT_DIR\oxford_*.json" | Sort-Object Name
}

if (-not $files) {
    Write-Host "Khong tim thay file oxford_*.json trong $OUTPUT_DIR"
    exit 1
}

Write-Host "=== Gemini Translator for Oxford 5000 ==="
Write-Host "Files: $($files.Count)  |  BatchSize: $BatchSize  |  DryRun: $DryRun"
Write-Host ""

# ---------------------------------------------------------------------------
# Ham goi Gemini API
# ---------------------------------------------------------------------------
function Invoke-GeminiTranslate([object[]]$batch) {
    # Tao danh sach JSON de gui vao prompt
    $inputJson = $batch | ForEach-Object {
        [pscustomobject]@{
            id  = $_.id
            def = $_.definitionEn
            ex  = $_.exampleText
        }
    } | ConvertTo-Json -Compress

    $prompt = @"
Ban la chuyen gia bien soan tu dien Anh-Viet.
Dich nhanh, ngan gon theo phong cach tu dien (khong giai thich dai dong).

Voi moi entry trong mang JSON duoi day:
- "meaningVi": dich "def" sang tieng Viet, 1 dong ngan (~5-15 tu), phong cach tu dien
- "exVi": dich "ex" sang tieng Viet tu nhien (neu "ex" rong thi de "")

Tra ve DUNG mot mang JSON, khong co markdown, khong co chu giai thich:
[{"id":"...","meaningVi":"...","exVi":"..."},...]

Input:
$inputJson
"@

    $body = [pscustomobject]@{
        contents = @(
            [pscustomobject]@{
                parts = @(
                    [pscustomobject]@{ text = $prompt }
                )
            }
        )
        generationConfig = [pscustomobject]@{
            temperature     = 0.1
            maxOutputTokens = 8192
        }
    } | ConvertTo-Json -Depth 10 -Compress

    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)

    try {
        $response = Invoke-RestMethod -Uri $API_URL -Method POST `
            -ContentType "application/json; charset=utf-8" `
            -Body $bodyBytes

        $text = $response.candidates[0].content.parts[0].text

        # Trim markdown code fences neu co
        $text = $text -replace '(?s)^```json\s*', '' -replace '(?s)```\s*$', ''
        $text = $text.Trim()

        return $text | ConvertFrom-Json
    } catch {
        Write-Host "  [WARN] API error: $($_.Exception.Message)" -ForegroundColor Yellow
        return $null
    }
}

# ---------------------------------------------------------------------------
# Load progress (de resume khi bi ngat)
# ---------------------------------------------------------------------------
$progress = @{}
if (Test-Path $PROGRESS_FILE) {
    $progress = Get-Content $PROGRESS_FILE -Raw | ConvertFrom-Json
    # ConvertFrom-Json tra ve PSCustomObject, convert sang hashtable
    $ht = @{}
    $progress.PSObject.Properties | ForEach-Object { $ht[$_.Name] = $_.Value }
    $progress = $ht
}

function Save-Progress {
    $obj = [pscustomobject]$progress
    $obj | ConvertTo-Json | Out-File $PROGRESS_FILE -Encoding utf8
}

# ---------------------------------------------------------------------------
# Xu ly tung file
# ---------------------------------------------------------------------------
$totalSenses     = 0
$translatedCount = 0
$skippedCount    = 0
$errorCount      = 0

foreach ($file in $files) {
    Write-Host "--- $($file.Name) ---" -ForegroundColor Cyan

    $data = Get-Content $file.FullName -Raw | ConvertFrom-Json

    # Thu thap tat ca senses can dich (meaningVi == null)
    $pendingSenses = [System.Collections.Generic.List[object]]::new()

    foreach ($hw in $data.headwords) {
        foreach ($sense in $hw.senses) {
            $exText = if ($sense.examples -and $sense.examples.Count -gt 0) {
                $sense.examples[0].englishText
            } else { "" }

            # Chi dich neu chua co meaningVi
            if ($null -eq $sense.meaningVi -or $sense.meaningVi -eq "") {
                $pendingSenses.Add([pscustomobject]@{
                    id           = $sense.id
                    definitionEn = $sense.definitionEn
                    exampleText  = $exText
                })
            } else {
                $skippedCount++
            }
        }
    }

    Write-Host "  Can dich: $($pendingSenses.Count) senses  |  Da co: $skippedCount"
    $totalSenses += $pendingSenses.Count

    if ($pendingSenses.Count -eq 0) { continue }

    # Build lookup map: senseId -> (hw index, sense index) de update nhanh
    $senseMap = @{}
    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $senseMap[$data.headwords[$hi].senses[$si].id] = @($hi, $si)
        }
    }

    # Batch loop
    $i = [Math]::Max(0, $ResumeFrom)
    while ($i -lt $pendingSenses.Count) {
        $end   = [Math]::Min($i + $BatchSize, $pendingSenses.Count)
        $batch = $pendingSenses[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $BatchSize) + 1
        $totalBatches = [Math]::Ceiling($pendingSenses.Count / $BatchSize)

        Write-Host "  Batch $batchNum/$totalBatches  (senses $i-$($end-1))..." -NoNewline

        if ($DryRun) {
            Write-Host " [DRY RUN - skip API call]"
            $i = $end
            continue
        }

        $results = Invoke-GeminiTranslate $batch

        if ($null -eq $results) {
            Write-Host " FAILED - retry sau 5s..." -ForegroundColor Red
            Start-Sleep -Seconds 5
            $results = Invoke-GeminiTranslate $batch
            if ($null -eq $results) {
                Write-Host " FAILED lan 2 - bo qua batch nay" -ForegroundColor Red
                $errorCount += $batch.Count
                $i = $end
                continue
            }
        }

        # Apply ket qua vao data object
        $applied = 0
        foreach ($r in $results) {
            if (-not $r.id) { continue }
            $pos = $senseMap[$r.id]
            if (-not $pos) { continue }

            $hi = $pos[0]; $si = $pos[1]
            $sense = $data.headwords[$hi].senses[$si]

            $sense.meaningVi = $r.meaningVi

            # Cap nhat example[0].vietnameseText
            if ($r.exVi -and $sense.examples -and $sense.examples.Count -gt 0) {
                $sense.examples[0].vietnameseText = $r.exVi
            }
            $applied++
        }

        $translatedCount += $applied
        Write-Host " OK ($applied applied)" -ForegroundColor Green

        # Throttle: 2 req/s de tranh rate limit
        Start-Sleep -Milliseconds 600

        $i = $end

        # Luu progress theo tung batch (de resume)
        $progress[$file.Name] = $i
        Save-Progress

        # Ghi file sau moi 5 batches (checkpoint)
        if (($batchNum % 5) -eq 0) {
            $jsonOut = $data | ConvertTo-Json -Depth 20
            [System.IO.File]::WriteAllText(
                $file.FullName,
                $jsonOut,
                [System.Text.UTF8Encoding]::new($false)
            )
            Write-Host "  >> Checkpoint saved: $($file.Name)" -ForegroundColor DarkGray
        }
    }

    # Ghi file lan cuoi sau khi hoan thanh 1 file
    Write-Host "  Ghi $($file.Name)..." -NoNewline
    $jsonOut = $data | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText(
        $file.FullName,
        $jsonOut,
        [System.Text.UTF8Encoding]::new($false)
    )
    Write-Host " OK" -ForegroundColor Green
    Write-Host ""
}

# ---------------------------------------------------------------------------
# Tong ket
# ---------------------------------------------------------------------------
Write-Host "=== DONE ===" -ForegroundColor Magenta
Write-Host "Tong senses can dich : $totalSenses"
Write-Host "Da dich thanh cong   : $translatedCount"
Write-Host "Bo qua (da co)       : $skippedCount"
Write-Host "Loi (khong dich duoc): $errorCount"

if (Test-Path $PROGRESS_FILE) {
    Remove-Item $PROGRESS_FILE -Force
    Write-Host "Da xoa file progress."
}
