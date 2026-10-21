#!/usr/bin/env python3
"""
convert_oxford.py
=================
Convert oxford_5000.json → seed JSON files cho app Vien.

Cách dùng:
  python tools/convert_oxford.py

Output:
  assets/seed/headwords/oxford_a1.json
  assets/seed/headwords/oxford_a2.json
  assets/seed/headwords/oxford_b1.json
  assets/seed/headwords/oxford_b2.json
  assets/seed/headwords/oxford_c1.json
  assets/seed/headwords/oxford_c2.json

Sau khi chạy xong, cập nhật assets/seed/manifest.json bằng cách chạy:
  python tools/convert_oxford.py --update-manifest
"""

import argparse
import json
import os
import re
import time
from collections import defaultdict
from pathlib import Path

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
OXFORD_JSON = Path("D:/oxford-5000-vocabulary-audio-definition-main/data/oxford_5000.json")
OUTPUT_DIR = PROJECT_ROOT / "assets" / "seed" / "headwords"
AUDIO_UK_DIR = PROJECT_ROOT / "assets" / "audio" / "uk"
AUDIO_US_DIR = PROJECT_ROOT / "assets" / "audio" / "us"
MANIFEST_PATH = PROJECT_ROOT / "assets" / "seed" / "manifest.json"

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

SOURCE_ID = "src-oxford-5000"
NOW_MS = int(time.time() * 1000)

CEFR_ORDER = ["a1", "a2", "b1", "b2", "c1", "c2"]

SOURCE_DEF = {
    "id": SOURCE_ID,
    "name": "Oxford 5000 – Oxford University Press",
    "licence": "Educational use only",
    "url": "https://www.oxfordlearnersdictionaries.com/wordlists/oxford3000-5000",
}

# Tên loại từ Oxford → chuẩn hóa
POS_MAP = {
    "indefinite article": "article",
    "definite article": "article",
    "modal verb": "modal",
    "auxiliary verb": "auxiliary",
    "number": "numeral",
    "ordinal number": "ordinal",
    "predeterminer": "predeterminer",
}


def normalize_pos(raw: str) -> str:
    return POS_MAP.get(raw.lower(), raw.lower())


def normalize_word(word: str) -> str:
    """Lowercase, bỏ dấu câu đặc biệt để làm ID."""
    return re.sub(r"[^a-z0-9\-]", "", word.lower().replace(" ", "-").replace("'", "").replace(".", ""))


def audio_asset_key(filename: str, accent: str) -> str | None:
    """Trả về asset key tương đối nếu file tồn tại, ngược lại None."""
    if not filename:
        return None
    base = os.path.basename(filename)
    if accent == "uk":
        path = AUDIO_UK_DIR / base
    else:
        path = AUDIO_US_DIR / base
    return f"assets/audio/{accent}/{base}" if path.exists() else None


def min_cefr(levels: list[str]) -> str:
    """Lấy CEFR level thấp nhất trong danh sách."""
    sorted_levels = sorted(levels, key=lambda x: CEFR_ORDER.index(x.lower()) if x.lower() in CEFR_ORDER else 99)
    return sorted_levels[0].upper() if sorted_levels else "A1"


# ---------------------------------------------------------------------------
# Convert logic
# ---------------------------------------------------------------------------

def load_oxford_json(path: Path) -> dict:
    print(f"📖 Đọc {path} ...")
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def group_by_word(raw: dict) -> dict[str, list[dict]]:
    """Group các entry theo word, bỏ entry 'definition' template."""
    grouped: dict[str, list[dict]] = defaultdict(list)
    for key, entry in raw.items():
        if key == "definition":  # template entry, skip
            continue
        word = entry.get("word", "").strip()
        if word:
            grouped[word].append(entry)
    print(f"✅ {len(raw)-1} entries → {len(grouped)} từ unique")
    return dict(grouped)


def build_headword(word: str, senses_raw: list[dict]) -> dict:
    norm = normalize_word(word)
    hw_id = f"hw-oxford-{norm}"

    # Lấy IPA và audio từ entry đầu tiên (các entry cùng word dùng chung phát âm)
    first = senses_raw[0]
    ipa_uk = first.get("phon_br") or None
    ipa_us = first.get("phon_n_am") or None

    pronunciations = []
    uk_key = audio_asset_key(first.get("uk", ""), "uk")
    us_key = audio_asset_key(first.get("us", ""), "us")

    if ipa_uk or uk_key:
        pronunciations.append({
            "id": f"pron-{norm}-uk",
            "accent": "uk",
            "ipa": ipa_uk,
            "audioAssetKey": uk_key,
        })
    if ipa_us or us_key:
        pronunciations.append({
            "id": f"pron-{norm}-us",
            "accent": "us",
            "ipa": ipa_us,
            "audioAssetKey": us_key,
        })

    # Build senses
    # Một số từ xuất hiện nhiều lần với cùng type → dùng counter riêng per type
    type_counter: dict[str, int] = defaultdict(int)
    senses = []
    for entry in senses_raw:
        raw_type = entry.get("type", "unknown")
        pos = normalize_pos(raw_type)
        type_counter[pos] += 1
        n = type_counter[pos]

        sense_id = f"sense-{norm}-{pos}-{n}"
        definition = (entry.get("definition") or "").strip()
        example_text = (entry.get("example") or "").strip()
        # Oxford đôi khi viết "label, Sentence." – tách label ra nếu có
        # Ví dụ: "abandon somebody, The baby had been abandoned."
        # Giữ nguyên để người dùng edit sau
        cefr_raw = entry.get("cefr", "a1")

        sense: dict = {
            "id": sense_id,
            "senseNumber": n,
            "partOfSpeech": pos,
            "definitionEn": definition,
            "meaningVi": None,          # Sẽ fill bằng script dịch riêng
            "cefrLevel": cefr_raw.upper(),
            "registerLabel": None,
            "domainLabel": None,
            "grammarNote": None,
            "usageNote": None,
            "isActive": 1,
            "tags": [],
            "examples": [],
        }

        if example_text:
            sense["examples"] = [{
                "id": f"ex-{sense_id}-1",
                "englishText": example_text,
                "vietnameseText": None,  # Sẽ fill bằng script dịch riêng
                "note": None,
                "sortOrder": 1,
            }]

        senses.append(sense)

    cefr_level = min_cefr([e.get("cefr", "a1") for e in senses_raw])

    return {
        "id": hw_id,
        "spelling": word,
        "normalizedSpelling": word.lower(),
        "homographNo": 1,
        "cefrLevel": cefr_level,
        "notes": None,
        "isArchived": 0,
        "createdAtMs": NOW_MS,
        "updatedAtMs": NOW_MS,
        "pronunciations": pronunciations,
        "inflections": [],
        "senses": senses,
    }


def build_seed_payload(headwords: list[dict]) -> dict:
    return {
        "sources": [SOURCE_DEF],
        "headwords": headwords,
    }


def save_json(data: dict, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    size_kb = path.stat().st_size // 1024
    print(f"  💾 {path.name}  ({len(data['headwords'])} words, {size_kb} KB)")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Convert Oxford 5000 JSON → Vien seed files")
    parser.add_argument("--update-manifest", action="store_true",
                        help="Cập nhật manifest.json sau khi generate xong")
    args = parser.parse_args()

    # 1. Load
    raw = load_oxford_json(OXFORD_JSON)

    # 2. Group
    grouped = group_by_word(raw)

    # 3. Build headwords, phân nhóm theo CEFR của headword
    cefr_buckets: dict[str, list[dict]] = {c: [] for c in CEFR_ORDER}
    missing_audio = 0

    for word, senses_raw in sorted(grouped.items()):
        hw = build_headword(word, senses_raw)
        level = hw["cefrLevel"].lower()
        if level not in cefr_buckets:
            level = "c2"  # fallback
        cefr_buckets[level].append(hw)

        # Check audio
        for pron in hw["pronunciations"]:
            if pron["audioAssetKey"] is None and pron.get("ipa"):
                missing_audio += 1

    # 4. Save theo CEFR
    print(f"\n📦 Xuất seed files vào {OUTPUT_DIR}/")
    generated_files = []
    for level in CEFR_ORDER:
        words = cefr_buckets[level]
        if not words:
            continue
        filename = f"oxford_{level}.json"
        out_path = OUTPUT_DIR / filename
        save_json(build_seed_payload(words), out_path)
        generated_files.append((f"headwords/{filename}", len(words)))

    total = sum(len(v) for v in cefr_buckets.values())
    print(f"\n✅ Tổng: {total} headwords")
    if missing_audio:
        print(f"⚠️  {missing_audio} pronunciations thiếu audio file")

    # 5. Update manifest nếu được yêu cầu
    if args.update_manifest:
        update_manifest(generated_files)


def update_manifest(new_files: list[tuple[str, int]]) -> None:
    """Thêm các file oxford_*.json vào manifest, giữ nguyên entries cũ."""
    if MANIFEST_PATH.exists():
        with open(MANIFEST_PATH, encoding="utf-8") as f:
            manifest = json.load(f)
    else:
        manifest = {"manifest_version": 1, "description": "Seed manifest", "files": []}

    existing_paths = {e["path"] for e in manifest["files"]}
    added = 0
    for rel_path, _ in new_files:
        if rel_path not in existing_paths:
            manifest["files"].append({"path": rel_path, "version": 1})
            added += 1
        # Nếu đã tồn tại, không thay đổi version (người dùng tự bump khi cần)

    with open(MANIFEST_PATH, "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)

    print(f"\n📋 manifest.json cập nhật: +{added} entries mới → {MANIFEST_PATH}")


if __name__ == "__main__":
    main()
