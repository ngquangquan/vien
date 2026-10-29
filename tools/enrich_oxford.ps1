# enrich_oxford.ps1
# Bo sung cac truong con thieu cho cac file oxford_*.json bang Gemini API:
#   - inflections       (cac dang bien doi: past, plural, comparative...)
#   - grammarNote       (ghi chu ngu phap)
#   - usageNote         (ghi chu cach dung bang tieng Viet)
#   - registerLabel     (nhan van phong: formal/informal/spoken...)
#   - domainLabel       (linh vuc: computing/business/law/medical/sports...)
#   - tags              (gan tag ids tu tags.json cho tung sense)
#   - meaningVi         (dich nghia tieng Viet ngan gon cho tung sense)
#   - examples them     (bo sung them vi du neu sense khong co example)
#   - vietnameseText    (dich cac example con null)
#   - notes             (ghi chu cap headword: tu de nham, collocation, etymology)
#   - example.note      (ghi chu cau truc / idiom rut ra tu vi du)
#   - strip audioAssetKey (xoa truong nay neu khong can)
#
# Cach dung:
#   $env:GEMINI_API_KEY = "AIza..."
#   powershell -ExecutionPolicy Bypass -File tools\enrich_oxford.ps1
#
# Tuy chon:
#   -CefrLevel a1                  chi xu ly 1 file (a1/a2/b1/b2/c1)
#   -Mode grammar                  chi chay 1 mode:
#                                    grammar | tags | meaning | examples | translate | notes | strip-audio | all
#   -BatchSize 20                  so items moi request (default 20)
#   -DryRun                        in thong tin batch, khong goi API / ghi file

param(
    [string]$CefrLevel  = "",
    [ValidateSet("all","grammar","inflections","tags","meaning","examples","translate","notes","strip-audio")]
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

# ---------------------------------------------------------------------------
# Duong dan
# ---------------------------------------------------------------------------
$PROJECT_ROOT  = "D:\Projects\other\vien"
$OUTPUT_DIR    = "$PROJECT_ROOT\assets\seed\headwords"
$TAGS_FILE     = "$PROJECT_ROOT\assets\seed\tags\tags.json"
$API_KEY       = $env:GEMINI_API_KEY
$API_URL       = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=$API_KEY"

if (-not $DryRun -and $Mode -ne "strip-audio" -and -not $API_KEY) {
    Write-Host "ERROR: Set bien moi truong GEMINI_API_KEY truoc khi chay." -ForegroundColor Red
    exit 1
}

# ---------------------------------------------------------------------------
# Doc danh sach tags
# ---------------------------------------------------------------------------
$tagsData      = Read-Utf8 $TAGS_FILE | ConvertFrom-Json
$TAG_LIST      = $tagsData.tags | ForEach-Object {
    [pscustomobject]@{ id = $_.id; slug = $_.slug; name = $_.name }
}
$TAG_IDS       = $tagsData.tags | ForEach-Object { $_.id }
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
# Ham goi Gemini API
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
        $raw    = Invoke-WebRequest -Uri $API_URL -Method POST `
                      -ContentType "application/json; charset=utf-8" `
                      -Body $bodyBytes -UseBasicParsing
        $ms     = $raw.RawContentStream; $ms.Position = 0
        $reader = New-Object System.IO.StreamReader($ms, [System.Text.Encoding]::UTF8)
        $resp   = $reader.ReadToEnd() | ConvertFrom-Json
        $text   = $resp.candidates[0].content.parts[0].text
        $text   = $text -replace '(?s)^```json\s*', '' -replace '(?s)```\s*$', ''
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
# PASS 1: GRAMMAR - inflections + grammarNote + usageNote + registerLabel + domainLabel
# ---------------------------------------------------------------------------
function Run-GrammarPass($data, $file) {
    $pending = [System.Collections.Generic.List[object]]::new()
    $hwMap   = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        $hw = $data.headwords[$hi]

        # Kiem tra xem headword da duoc xu ly chua (co bat ky truong nao da co gia tri)
        $hasGrammar = ($hw.inflections.Count -gt 0) -or (
            ($hw.senses | Where-Object {
                -not [string]::IsNullOrWhiteSpace($_.grammarNote) -or
                -not [string]::IsNullOrWhiteSpace($_.usageNote)   -or
                -not [string]::IsNullOrWhiteSpace($_.registerLabel) -or
                -not [string]::IsNullOrWhiteSpace($_.domainLabel)
            } | Measure-Object).Count -gt 0
        )

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

    Write-Host "  [Grammar] Pending: $($pending.Count) headwords"
    if ($pending.Count -eq 0) { return }

    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $BatchSize, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $BatchSize) + 1
        $total    = [Math]::Ceiling($pending.Count / $BatchSize)
        Write-Host "  Grammar Batch $batchNum/$total (words $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Depth 5 -Compress
        $prompt = @"
You are a professional English-Vietnamese dictionary editor. For each headword in the JSON array below, return:

1. "inflections": array of main inflected forms.
   - noun -> plural (if irregular or non-obvious)
   - verb -> past, pastParticiple, presentParticiple, thirdPerson (only if irregular)
   - adjective/adverb -> comparative, superlative (only if irregular)
   - Regular forms (e.g. +s, +ed, +ing) can be omitted (return []).
   - Each element: {"form":"form_name","value":"form_value"}
   - Valid forms: plural, past, pastParticiple, presentParticiple, thirdPerson, comparative, superlative

2. "senses": array matching input senses, each element:
   - "id": copy exactly from input
   - "grammarNote": short Oxford-style grammar label in brackets, e.g. "[countable]", "[uncountable]", "[transitive]", "[intransitive]", "[usually before noun]", "[not used in progressive]", "[+ to inf]", "[+ that clause]" — or null if none applies
   - "usageNote": one short Vietnamese sentence about typical usage context/pattern — or null
   - "registerLabel": one of "formal"|"informal"|"spoken"|"written"|"technical"|"literary"|"old-fashioned" — or null
   - "domainLabel": subject field if clearly domain-specific, e.g. "computing"|"business"|"law"|"medicine"|"science"|"mathematics"|"music"|"sports"|"architecture"|"history"|"politics"|"economics"|"psychology"|"education"|"military"|"religion"|"art"|"linguistics" — or null for general vocabulary

Return ONLY a JSON array, no markdown, no explanation:
[{"id":"hw-id","inflections":[...],"senses":[{"id":"...","grammarNote":"...","usageNote":"...","registerLabel":"...","domainLabel":"..."},...]}]

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
                    if ($null -eq $sense.grammarNote   -and $rs.grammarNote)   { $sense.grammarNote   = $rs.grammarNote }
                    if ($null -eq $sense.usageNote     -and $rs.usageNote)     { $sense.usageNote     = $rs.usageNote }
                    if ($null -eq $sense.registerLabel -and $rs.registerLabel) { $sense.registerLabel = $rs.registerLabel }
                    if ($null -eq $sense.domainLabel   -and $rs.domainLabel)   { $sense.domainLabel   = $rs.domainLabel }
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
# PASS 2: MEANING - dich meaningVi cho tung sense con null
# ---------------------------------------------------------------------------
function Run-MeaningPass($data, $file) {
    $pending  = [System.Collections.Generic.List[object]]::new()
    $senseMap = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $sense = $data.headwords[$hi].senses[$si]
            if ($null -eq $sense.meaningVi -or $sense.meaningVi -eq "") {
                $senseMap[$sense.id] = @($hi, $si)
                $pending.Add([pscustomobject]@{
                    id  = $sense.id
                    pos = $sense.partOfSpeech
                    def = $sense.definitionEn
                })
            }
        }
    }

    Write-Host "  [MeaningVi] Pending: $($pending.Count) senses"
    if ($pending.Count -eq 0) { return }

    $batchSz = $BatchSize * 2
    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $batchSz, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $batchSz) + 1
        $total    = [Math]::Ceiling($pending.Count / $batchSz)
        Write-Host "  Meaning Batch $batchNum/$total (senses $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Compress
        $prompt = @"
Ban la bien tap tu dien Anh-Viet chuyen nghiep. Cho moi sense duoi day, hay dich "def" (dinh nghia tieng Anh) sang tieng Viet ngan gon theo phong cach tu dien (khong giai thich, chi neu nghia chinh, 3-12 tu, dung chu thuong tru ten rieng).

Tra ve DUNG mot mang JSON (khong markdown, khong giai thich):
[{"id":"...","vi":"ban dich tieng Viet ngan gon"}]

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
            if ($r.vi -and ($null -eq $sense.meaningVi -or $sense.meaningVi -eq "")) {
                $sense.meaningVi = $r.vi
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
# PASS 3: TAGS - gan tag ids cho tung sense
# ---------------------------------------------------------------------------
function Run-TagsPass($data, $file) {
    $pending  = [System.Collections.Generic.List[object]]::new()
    $senseMap = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $sense = $data.headwords[$hi].senses[$si]
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
# PASS 4: EXAMPLES - bo sung vi du cho sense khong co example
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
You are a professional dictionary editor. For each sense below, create one short, natural English example sentence suitable for B1-B2 learners. Also provide a concise Vietnamese translation and, if the example illustrates a notable collocation, structure, or idiom, add a brief Vietnamese note (e.g. "Cau truc: rely on somebody" or "Collocation: take advantage of").

Return ONLY a JSON array (no markdown):
[{"id":"...","en":"English example","vi":"Vietnamese translation","note":"Vietnamese note or null"}]

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
                $noteVal = if ($r.note) { $r.note } else { $null }
                $sense.examples = @([pscustomobject]@{
                    id             = "ex-$($sense.id)-1"
                    englishText    = $r.en
                    vietnameseText = if ($r.vi) { $r.vi } else { $null }
                    note           = $noteVal
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
# PASS 5: TRANSLATE - dich vietnameseText cua examples con null
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

    Write-Host "  [Translate Examples] Pending: $($pending.Count) examples"
    if ($pending.Count -eq 0) { return }

    $batchSz = $BatchSize * 2
    $i = 0
    while ($i -lt $pending.Count) {
        $end      = [Math]::Min($i + $batchSz, $pending.Count)
        $batch    = $pending[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $batchSz) + 1
        $total    = [Math]::Ceiling($pending.Count / $batchSz)
        Write-Host "  Translate Batch $batchNum/$total (ex $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Compress
        $prompt = @"
Ban la bien tap tu dien Anh-Viet. Dich ngan gon, tu nhien, phong cach tu dien (khong giai thich them, chi dich nghia).
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
# PASS 6: NOTES - ghi chu cap headword (notes) va example.note
# ---------------------------------------------------------------------------
function Run-NotesPass($data, $file) {
    # 6a: headword.notes - chi xu ly headword chua co notes
    $pendingHw = [System.Collections.Generic.List[object]]::new()
    $hwMap     = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        $hw = $data.headwords[$hi]
        if ($null -eq $hw.notes -or $hw.notes -eq "") {
            $hwMap[$hw.id] = $hi
            $pendingHw.Add([pscustomobject]@{
                id     = $hw.id
                word   = $hw.spelling
                senses = @($hw.senses | ForEach-Object {
                    [pscustomobject]@{ pos = $_.partOfSpeech; def = $_.definitionEn }
                })
            })
        }
    }

    Write-Host "  [Notes/HW] Pending: $($pendingHw.Count) headwords"

    if ($pendingHw.Count -gt 0) {
        $i = 0
        while ($i -lt $pendingHw.Count) {
            $end      = [Math]::Min($i + $BatchSize, $pendingHw.Count)
            $batch    = $pendingHw[$i..($end-1)]
            $batchNum = [Math]::Floor($i / $BatchSize) + 1
            $total    = [Math]::Ceiling($pendingHw.Count / $BatchSize)
            Write-Host "  HW Notes Batch $batchNum/$total (words $i-$($end-1))..." -NoNewline

            $inputJson = $batch | ConvertTo-Json -Depth 4 -Compress
            $prompt = @"
Ban la bien tap tu dien Anh-Viet. Cho moi headword duoi day, neu co dieu gi DAC BIET can luu y (tu de nham, collocation quan trong, diem ngu phap dac biet, hoac nguon goc thu vi) thi viet 1-2 cau ngan gon bang tieng Viet. Neu tu qua binh thuong thi de null.

Tra ve DUNG mot mang JSON (khong markdown):
[{"id":"hw-id","notes":"ghi chu tieng Viet ngan gon hoac null"}]

Input: $inputJson
"@

            if ($DryRun) { Write-Host " [DRY RUN]"; $i = $end; continue }

            $results = Invoke-WithRetry $prompt
            if ($null -eq $results) { Write-Host " FAILED" -ForegroundColor Red; $i = $end; continue }

            $applied = 0
            foreach ($r in $results) {
                if (-not $r.id -or -not $hwMap.ContainsKey($r.id)) { continue }
                $hw = $data.headwords[$hwMap[$r.id]]
                if ($r.notes -and $r.notes -ne "null") {
                    $hw.notes = $r.notes
                    $applied++
                }
            }

            Write-Host " OK ($applied applied)" -ForegroundColor Green
            Start-Sleep -Milliseconds 600
            $i = $end
            Write-DataFile $data $file
        }
    }

    # 6b: example.note - chi xu ly example co note = null VÀ englishText co dau hieu la cau truc / collocation / idiom
    $pendingEx = [System.Collections.Generic.List[object]]::new()
    $exMap     = @{}

    for ($hi = 0; $hi -lt $data.headwords.Count; $hi++) {
        for ($si = 0; $si -lt $data.headwords[$hi].senses.Count; $si++) {
            $sense = $data.headwords[$hi].senses[$si]
            for ($ei = 0; $ei -lt $sense.examples.Count; $ei++) {
                $ex = $sense.examples[$ei]
                # Chi gui nhung example ma note chua co va englishText co vet cau truc (co something/somebody hoac dau ngoac don)
                if (($null -eq $ex.note -or $ex.note -eq "") -and
                    ($ex.englishText -match "somebody|someone|something|\(=|Idiom:" )) {
                    $exMap[$ex.id] = @($hi, $si, $ei)
                    $pendingEx.Add([pscustomobject]@{
                        id = $ex.id
                        en = $ex.englishText
                    })
                }
            }
        }
    }

    Write-Host "  [Notes/Ex] Pending: $($pendingEx.Count) examples with structure hints"
    if ($pendingEx.Count -eq 0) { return }

    $batchSz = $BatchSize * 2
    $i = 0
    while ($i -lt $pendingEx.Count) {
        $end      = [Math]::Min($i + $batchSz, $pendingEx.Count)
        $batch    = $pendingEx[$i..($end-1)]
        $batchNum = [Math]::Floor($i / $batchSz) + 1
        $total    = [Math]::Ceiling($pendingEx.Count / $batchSz)
        Write-Host "  Ex Notes Batch $batchNum/$total (ex $i-$($end-1))..." -NoNewline

        $inputJson = $batch | ConvertTo-Json -Compress
        $prompt = @"
Ban la bien tap tu dien Anh-Viet. Moi example duoi day co the chua cau truc (pattern), collocation, hoac idiom dac biet. Neu co, viet 1 ghi chu ngan gon bang tieng Viet de giai thich cau truc do (vi du: "Cau truc: rely on somebody" hoac "Idiom: take your pick = tu chon lay"). Neu khong co gi dac biet thi de null.

Tra ve DUNG mot mang JSON (khong markdown):
[{"id":"...","note":"ghi chu tieng Viet hoac null"}]

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
            if ($r.note -and $r.note -ne "null") {
                $ex.note = $r.note
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
# PASS 7: STRIP AUDIO - xoa truong audioAssetKey khoi pronunciations
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

    if ($Mode -eq "all" -or $Mode -eq "grammar" -or $Mode -eq "inflections") {
        Run-GrammarPass $data $file
    }
    if ($Mode -eq "all" -or $Mode -eq "meaning") {
        Run-MeaningPass $data $file
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
    if ($Mode -eq "all" -or $Mode -eq "notes") {
        Run-NotesPass $data $file
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
