# enrich_oxford.ps1
# Bo sung cac truong con thieu cho cac file oxford_*.json bang Gemini API:
#   - inflections       (cac dang bien doi: past, plural, comparative...)
#   - grammarNote       (ghi chu ngu phap)
#   - usageNote         (ghi chu cach dung)
#   - registerLabel     (nhan van phong: formal/informal/spoken...)
#   - tags              (gan tag ids tu tags.json cho tung sense)
#   - examples them     (bo sung them vi du neu sense khong co example)
#   - vietnameseText    (dich cac example con null)
#   - strip audioAssetKey (xoa truong nay neu khong can)
#
# Cach dung:
#   $env:GEMINI_API_KEY = "AIza..."
#   powershell -ExecutionPolicy Bypass -File tools\enrich_oxford.ps1
#
# Tuy chon:
#   -CefrLevel a1                  chi xu ly 1 file (a1/a2/b1/b2/c1)
#   -Mode inflections              chi chay 1 mode:
#                                    inflections | grammar | tags | examples | translate | strip-audio | all
#   -BatchSize 20                  so items moi request (default 20)
#   -DryRun                        in prompt, khong goi API / ghi file

param(
    [string]$CefrLevel  = "",
    [ValidateSet("all","inflections","grammar","tags","examples","translate","strip-audio")]
    [string]$Mode       = "all",
    [int]   $BatchSize  = 20,
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding           = [System.Text.Encoding]::UTF8
$UTF8NoBom = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8([string]$path) {
    return [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
}
function Write-Utf8([string]$path, [string]$text) {
    [System.IO.File]::WriteAllText($path, $text, $UTF8NoBom)
}

$PROJECT_ROOT  = "D:\Projects\other\vien"
$OUTPUT_DIR    = "$PROJECT_ROOT\assets\seed\headwords"
$TAGS_FILE     = "$PROJECT_ROOT\assets\seed\tags\tags.json"
$API_KEY       = $env:GEMINI_API_KEY
$API_URL       = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$API_KEY"

if (-not $DryRun -and $Mode -ne "strip-audio" -and -not $API_KEY) {
    Write-Host "ERROR: Set bien moi truong GEMINI_API_KEY truoc khi chay."
    exit 1
}

# ---------------------------------------------------------------------------
# Doc danh sach tags (chi lay id va slug de gui vao prompt cho gon)
# ---------------------------------------------------------------------------
$tagsData = Read-Utf8 $TAGS_FILE | ConvertFrom-Json
$TAG_LIST = $tagsData.tags | ForEach-Object {
    [pscustomobject]@{ id = $_.id; slug = $_.slug; name = $_.name }
}
$TAG_IDS = $tagsData.tags | ForEach-Object { $_.id }
$TAG_LIST_JSON = $TAG_LIST | ConvertTo-Json -Compress

# ---------------------------------------------------------------------------
# Chon files
# ---------------------------------------------------------------------------
if ($CefrLevel) {
    $files = @(Get-Item "$OUTPUT_DIR\oxford_$($CefrLevel.ToLower()).json")
} else {
    $files = Get-ChildItem "$OUTPUT_DIR\oxford_*.json" | Sort-Object Name
}

if (-not $files) { Write-Host "Khong tim thay file oxford_*.json"; exit 1 }

Write-Host "=== Oxford Enricher ===" -ForegroundColor Cyan
Write-Host "Mode: $Mode  |  Files: $($files.Count)  |  BatchSize: $BatchSize  |  DryRun: $DryRun"
Write-Host ""

# ---------------------------------------------------------------------------
# Ham goi Gemini API chung
# ---------------------------------------------------------------------------
function Invoke-Gemini([string]$prompt) {
    $body = [pscustomobject]@{
        contents = @(
            [pscustomobject]@{
                parts = @([pscustomobject]@{ text = $prompt })
            }
        )
        generationConfig = [pscustomobject]@{
            temperature     = 0.1
            maxOutputTokens = 8192
        }
    } | ConvertTo-Json -Depth 10 -Compress

    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    try {
        $raw      = Invoke-WebRequest -Uri $API_URL -Method POST `
                        -ContentType "application/json; charset=utf-8" `
                        -Body $bodyBytes -UseBasicParsing
        $ms = $raw.RawContentStream; $ms.Position = 0
        $reader   = New-Object System.IO.StreamReader($ms, [System.Text.Encoding]::UTF8)
        $response = $reader.ReadToEnd() | ConvertFrom-Json
        $text     = $response.candidates[0].content.parts[0].text
        $text     = $text -replace '(?s)^```json\s*', '' -replace '(?s)```\s*$', ''
        return $text.Trim() | ConvertFrom-Json
    } catch {
        Write-Host "  [WARN] API error: $($_.Exception.Message)" -ForegroundColor Yellow
        return $null
    }
}

function Invoke-WithRetry([string]$prompt) {
    $result = Invoke-Gemini $prompt
    if ($null -eq $result) {
        Write-Host "  Retry sau 15s..." -ForegroundColor Yellow
        Start-Sleep -Seconds 15
        $result = Invoke-Gemini $prompt
    }
    return $result
}

function Write-DataFile($data, $file) {
    $ts = Get-Date -Format "HH:mm:ss"
    Write-Utf8 $file.FullName ($data | ConvertTo-Json -Depth 20)
    Write-Host "  [$ts] Saved $($file.Name)" -ForegroundColor DarkGray
}

# ---------------------------------------------------------------------------
# PASS 1: INFLECTIONS + GRAMMAR + REGISTER
# ---------------------------------------------------------------------------
function Run-GrammarPass($data, $file) {
    $pending = [System.Collections.Generic.List[object]]::new()
    $hwMap   = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        $hw = $data.headwords[$hi]
        # Inflections và Grammar được update cùng nhau trong pass này.
        # Nhiều từ không có biến hình (inflections = []), nên chỉ cần kiểm tra xem đã có grammar/usage note hay chưa.
        $hasGrammar = ($hw.senses | Where-Object {
            -not [string]::IsNullOrWhiteSpace($_.grammarNote) -or `
            -not [string]::IsNullOrWhiteSpace($_.usageNote) -or `
            -not [string]::IsNullOrWhiteSpace($_.registerLabel)
        } | Measure-Object).Count -gt 0 -or ($hw.inflections.Count -gt 0)

        if (-not $hasGrammar) {
            $hwMap[$hw.id] = $hi
            $pending.Add([pscustomobject]@{
                id     = $hw.id
                word   = $hw.spelling
                senses = @($hw.senses | ForEach-Object {
                    [pscustomobject]@{ id = $_.id; pos = $_.partOfSpeech; def = $_.definitionEn }
                })
            })
        }
    }

    Write-Host "  [Grammar/Inflections] Pending: $($pending.Count) headwords"
    if ($pending.Count -eq 0) { return }

    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $BatchSize, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $BatchSize) + 1
        $total    = [Math]::Ceiling($pending.Count / $BatchSize)
        Write-Host "  Batch $batchNum/$total (words $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Depth 5 -Compress
        $prompt = @"
Ban la bien tap tu dien Anh-Viet chuyen nghiep. Cho moi headword trong mang JSON duoi day, hay tra ve:

1. "inflections": mang cac dang bien doi chinh (vi du: noun->plural, verb->past/pastParticiple/presentParticiple, adj->comparative/superlative). Bat quy tac thi liet ke. Neu khong bien doi thi de [].
   Moi phan tu: {"form":"ten_dang","value":"gia_tri"}
   Cac form hop le: plural, past, pastParticiple, presentParticiple, thirdPerson, comparative, superlative

2. "senses": mang tuong ung voi senses, moi phan tu:
   - "id": copy y chang tu input
   - "grammarNote": ghi chu ngu phap ngan ([usually before noun], [not used in progressive]...) hoac null
   - "usageNote": ghi chu cach dung ngan bang tieng Viet (1 cau) hoac null
   - "registerLabel": "formal"|"informal"|"spoken"|"written"|"technical"|"literary"|"old-fashioned" hoac null

Tra ve DUNG mot mang JSON, khong markdown:
[{"id":"hw-id","inflections":[...],"senses":[{"id":"...","grammarNote":"...","usageNote":"...","registerLabel":"..."},...]}]

Input: $inputJson
"@

        if ($DryRun) { Write-Host " [DRY RUN]"; $i = $end; continue }

        $results = Invoke-WithRetry $prompt
        if ($null -eq $results) { Write-Host " FAILED" -ForegroundColor Red; $i = $end; continue }

        $applied = 0
        foreach ($r in $results) {
            if (-not $r.id -or -not $hwMap.ContainsKey($r.id)) { continue }
            $hi = $hwMap[$r.id]
            $hw = $data.headwords[$hi]

            if ($r.inflections -and $hw.inflections.Count -eq 0) {
                $hw.inflections = $r.inflections
            }

            if ($r.senses) {
                $sm = @{}
                for ($si = 0; $si -lt $hw.senses.Count; $si++) { $sm[$hw.senses[$si].id] = $si }
                foreach ($rs in $r.senses) {
                    if (-not $rs.id -or -not $sm.ContainsKey($rs.id)) { continue }
                    $sense = $hw.senses[$sm[$rs.id]]
                    if ($null -eq $sense.grammarNote   -and $rs.grammarNote)   { $sense.grammarNote   = $rs.grammarNote   }
                    if ($null -eq $sense.usageNote     -and $rs.usageNote)     { $sense.usageNote     = $rs.usageNote     }
                    if ($null -eq $sense.registerLabel -and $rs.registerLabel) { $sense.registerLabel = $rs.registerLabel }
                }
            }
            $applied++
        }

        Write-Host " OK ($applied applied)" -ForegroundColor Green
        Start-Sleep -Milliseconds 600
        $i = $end
        Write-DataFile $data $file
    }
}

# ---------------------------------------------------------------------------
# PASS 2: TAGS - gan tag ids cho tung sense
# ---------------------------------------------------------------------------
function Run-TagsPass($data, $file) {
    $pending  = [System.Collections.Generic.List[object]]::new()
    $senseMap = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $sense = $data.headwords[$hi].senses[$si]
            # Chi xu ly sense chua co tag nao
            if ($sense.tags.Count -eq 0) {
                $senseMap[$sense.id] = @($hi, $si)
                $pending.Add([pscustomobject]@{
                    id  = $sense.id
                    pos = $sense.partOfSpeech
                    def = $sense.definitionEn
                })
            }
        }
    }

    Write-Host "  [Tags] Pending: $($pending.Count) senses"
    if ($pending.Count -eq 0) { return }

    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $BatchSize, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $BatchSize) + 1
        $total    = [Math]::Ceiling($pending.Count / $BatchSize)
        Write-Host "  Tags Batch $batchNum/$total (senses $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Compress

        $prompt = @"
Ban la bien tap tu dien Anh-Viet. Nhiem vu: gan tag cho tung sense cua tu tieng Anh.

Danh sach tag hop le (chi duoc dung cac id nay):
$TAG_LIST_JSON

Moi sense co the co 0, 1, hoac nhieu tag. Chi gan tag THUC SU phu hop. Neu khong co tag nao phu hop thi de mang rong [].

Tra ve DUNG mot mang JSON (khong markdown, khong giai thich):
[{"id":"sense-id","tags":["tag-id-1","tag-id-2"]}]

Input senses:
$inputJson
"@

        if ($DryRun) { Write-Host " [DRY RUN]"; $i = $end; continue }

        $results = Invoke-WithRetry $prompt
        if ($null -eq $results) { Write-Host " FAILED" -ForegroundColor Red; $i = $end; continue }

        $applied = 0
        foreach ($r in $results) {
            if (-not $r.id -or -not $senseMap.ContainsKey($r.id)) { continue }
            $pos   = $senseMap[$r.id]
            $sense = $data.headwords[$pos[0]].senses[$pos[1]]

            # Loc: chi giu cac tag id hop le
            if ($r.tags) {
                $validTags = @($r.tags | Where-Object { $TAG_IDS -contains $_ })
                $sense.tags = $validTags
                $applied++
            }
        }

        Write-Host " OK ($applied applied)" -ForegroundColor Green
        Start-Sleep -Milliseconds 600
        $i = $end
        Write-DataFile $data $file
    }
}

# ---------------------------------------------------------------------------
# PASS 3: EXAMPLES - bo sung vi du cho sense khong co example
# ---------------------------------------------------------------------------
function Run-ExamplesPass($data, $file) {
    $pending  = [System.Collections.Generic.List[object]]::new()
    $senseMap = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $sense = $data.headwords[$hi].senses[$si]
            if ($sense.examples.Count -eq 0) {
                $senseMap[$sense.id] = @($hi, $si)
                $pending.Add([pscustomobject]@{
                    id  = $sense.id
                    pos = $sense.partOfSpeech
                    def = $sense.definitionEn
                })
            }
        }
    }

    Write-Host "  [Examples] Pending: $($pending.Count) senses"
    if ($pending.Count -eq 0) { return }

    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $BatchSize, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $BatchSize) + 1
        $total    = [Math]::Ceiling($pending.Count / $BatchSize)
        Write-Host "  Examples Batch $batchNum/$total..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Compress
        $prompt = @"
Ban la bien tap tu dien chuyen nghiep. Cho moi sense duoi day, hay tao 1 vi du su dung tieng Anh ngan gon, tu nhien, phu hop cap do A1-B2.

Tra ve DUNG mot mang JSON (khong markdown):
[{"id":"...","en":"vi du tieng Anh","vi":"ban dich tieng Viet ngan gon"}]

Input: $inputJson
"@

        if ($DryRun) { Write-Host " [DRY RUN]"; $i = $end; continue }

        $results = Invoke-WithRetry $prompt
        if ($null -eq $results) { Write-Host " FAILED" -ForegroundColor Red; $i = $end; continue }

        $applied = 0
        foreach ($r in $results) {
            if (-not $r.id -or -not $senseMap.ContainsKey($r.id)) { continue }
            $pos   = $senseMap[$r.id]
            $sense = $data.headwords[$pos[0]].senses[$pos[1]]
            if ($sense.examples.Count -eq 0 -and $r.en) {
                $sense.examples = @([pscustomobject]@{
                    id             = "ex-$($sense.id)-1"
                    englishText    = $r.en
                    vietnameseText = $r.vi
                    note           = $null
                    sortOrder      = 1
                })
                $applied++
            }
        }

        Write-Host " OK ($applied applied)" -ForegroundColor Green
        Start-Sleep -Milliseconds 600
        $i = $end
        Write-DataFile $data $file
    }
}

# ---------------------------------------------------------------------------
# PASS 4: TRANSLATE - dich vietnameseText cua examples con null
# ---------------------------------------------------------------------------
function Run-TranslatePass($data, $file) {
    $pending = [System.Collections.Generic.List[object]]::new()
    $exMap   = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $sense = $data.headwords[$hi].senses[$si]
            for ($ei = 0; $ei -lt $sense.examples.Count; $ei++) {
                $ex = $sense.examples[$ei]
                if ($null -eq $ex.vietnameseText -or $ex.vietnameseText -eq "") {
                    $exMap[$ex.id] = @($hi, $si, $ei)
                    $pending.Add([pscustomobject]@{ id = $ex.id; en = $ex.englishText })
                }
            }
        }
    }

    Write-Host "  [Translate] Pending: $($pending.Count) examples"
    if ($pending.Count -eq 0) { return }

    $batchSz = $BatchSize * 2   # translate nhanh hon, batch lon hon
    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $batchSz, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $batchSz) + 1
        $total    = [Math]::Ceiling($pending.Count / $batchSz)
        Write-Host "  Translate Batch $batchNum/$total (ex $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Compress
        $prompt = @"
Ban la bien tap tu dien Anh-Viet. Dich ngan gon, tu nhien, phong cach tu dien.
Tra ve DUNG mot mang JSON (khong markdown):
[{"id":"...","vi":"ban dich tieng Viet"}]
Input: $inputJson
"@

        if ($DryRun) { Write-Host " [DRY RUN]"; $i = $end; continue }

        $results = Invoke-WithRetry $prompt
        if ($null -eq $results) { Write-Host " FAILED" -ForegroundColor Red; $i = $end; continue }

        $applied = 0
        foreach ($r in $results) {
            if (-not $r.id -or -not $exMap.ContainsKey($r.id)) { continue }
            $pos = $exMap[$r.id]
            $ex  = $data.headwords[$pos[0]].senses[$pos[1]].examples[$pos[2]]
            if ($r.vi) { $ex.vietnameseText = $r.vi; $applied++ }
        }

        Write-Host " OK ($applied applied)" -ForegroundColor Green
        Start-Sleep -Milliseconds 600
        $i = $end
        Write-DataFile $data $file
    }
}

# ---------------------------------------------------------------------------
# PASS 5: STRIP AUDIO - xoa truong audioAssetKey khoi pronunciations
# ---------------------------------------------------------------------------
function Run-StripAudioPass($data) {
    $count = 0
    foreach ($hw in $data.headwords) {
        foreach ($pron in $hw.pronunciations) {
            if ($pron.PSObject.Properties.Name -contains "audioAssetKey") {
                $pron.PSObject.Properties.Remove("audioAssetKey")
                $count++
            }
        }
    }
    Write-Host "  [Strip Audio] Removed audioAssetKey from $count pronunciations" -ForegroundColor Green
}

# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------
foreach ($file in $files) {
    Write-Host "=== $($file.Name) ===" -ForegroundColor Cyan

    $data = Read-Utf8 $file.FullName | ConvertFrom-Json

    if ($Mode -eq "all" -or $Mode -eq "inflections" -or $Mode -eq "grammar") {
        Run-GrammarPass $data $file
    }
    if ($Mode -eq "all" -or $Mode -eq "tags") {
        Run-TagsPass $data $file
    }
    if ($Mode -eq "all" -or $Mode -eq "examples") {
        Run-ExamplesPass $data $file
    }
    if ($Mode -eq "all" -or $Mode -eq "translate") {
        Run-TranslatePass $data $file
    }
    if ($Mode -eq "all" -or $Mode -eq "strip-audio") {
        Run-StripAudioPass $data
    }

    if (-not $DryRun) {
        Write-Host "  Ghi $($file.Name)..." -NoNewline
        Write-Utf8 $file.FullName ($data | ConvertTo-Json -Depth 20)
        Write-Host " OK" -ForegroundColor Green
    }
    Write-Host ""
}

Write-Host "=== DONE ===" -ForegroundColor Magenta
