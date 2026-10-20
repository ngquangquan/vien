# VIEN — English Learning App

> **Ứng dụng học từ vựng tiếng Anh offline** với từ điển CEFR, hệ thống ôn tập thích nghi SM-2, quiz nhiều lựa chọn, và quản lý cụm từ / thành ngữ.

---

## Tính năng chính

| Tính năng | Mô tả |
|-----------|-------|
| 📖 Từ điển CEFR | Headwords với nhiều nghĩa (senses), phát âm IPA, biến thể hình thái |
| 🔄 Ôn tập SM-2 | Lịch ôn thích nghi theo thuật toán SuperMemo 2 |
| 🧠 Quiz | Câu hỏi trắc nghiệm nhiều dạng: meaning\_choice, cloze, definition |
| 🏷️ Tags | Phân loại từ theo chủ đề, cấp độ, văn phong |
| 💾 Backup / Restore | Xuất JSON offline, merge hoặc replace |
| 🌙 Dark mode | Hỗ trợ Material 3 light/dark theo system |

---

## Kiến trúc

```
lib/
├── app/                    # App widget, routing, theme
├── core/
│   ├── database/           # Drift schema + SeedService
│   ├── backup/             # BackupService (export / restore)
│   └── notifications/      # NotificationService
└── features/
    ├── vocabulary/         # Headwords, senses
    ├── phrases/            # Phrases, phrase senses
    ├── review/             # SM-2 review session
    ├── quiz/               # Multiple-choice quiz
    ├── tags/               # Tag management
    └── settings/           # User preferences
```

- **Pattern:** MVVM + Repository (Drift reactive streams `.watch()`)
- **Database:** SQLite via Drift, `PRAGMA foreign_keys = ON`, cascade triggers
- **State:** `StreamBuilder` + `setState` (không dùng Provider/Bloc)

---

## Cài đặt & Chạy

```bash
flutter pub get
flutter run
```

### Build APK Android
Xem hướng dẫn chi tiết tại [HUONG_DAN_BUILD_APK.md](HUONG_DAN_BUILD_APK.md) hoặc chạy nhanh:
```bash
flutter build apk --release
```

### Yêu cầu

- Flutter ≥ 3.x, Dart SDK ^3.13.5
- `sqlite3_flutter_libs` (bundled, không cần cài ngoài)

---

## Cấu trúc Seed Data

Dữ liệu từ vựng mặc định được quản lý bởi **manifest-based seed system** — chỉ load file thay đổi, không load lại toàn bộ.

```
assets/seed/
├── manifest.json              ← Index + version từng file
├── tags/
│   └── tags.json              ← Tất cả tags
├── headwords/
│   ├── a1.json                ← Từ vựng A1
│   ├── a2.json                ← Từ vựng A2
│   ├── b1.json                ← Từ vựng B1
│   ├── b2.json                ← Từ vựng B2
│   ├── c1.json                ← Từ vựng C1
│   └── c2.json                ← Từ vựng C2
├── phrases/
│   ├── idioms.json            ← Thành ngữ
│   └── collocations.json      ← Cụm từ cố định
└── questions/
    └── general.json           ← Câu hỏi quiz
```

### Cách thêm từ mới

**Bước 1 — Chỉnh sửa file seed phù hợp**

Mỗi headword có cấu trúc:

```jsonc
// assets/seed/headwords/b1.json
{
  "headwords": [
    {
      "id": "hw-<word>",               // ← unique, dạng hw-<word>
      "spelling": "achieve",
      "normalizedSpelling": "achieve",
      "homographNo": 1,
      "cefrLevel": "B1",
      "notes": null,
      "isArchived": 0,
      "createdAtMs": 1792000000000,
      "updatedAtMs": 1792000000000,
      "pronunciations": [
        { "id": "pron-achieve-uk", "accent": "uk", "ipa": "/əˈtʃiːv/", "audioAssetKey": null }
      ],
      "inflections": [
        { "id": "inf-achieve-1", "form": "achieves",  "formType": "third_person_singular" },
        { "id": "inf-achieve-2", "form": "achieved",  "formType": "past" },
        { "id": "inf-achieve-3", "form": "achieving", "formType": "ing" }
      ],
      "senses": [
        {
          "id": "sense-achieve-v1",        // ← unique, dạng sense-<word>-<pos><n>
          "senseNumber": 1,
          "partOfSpeech": "verb",
          "definitionEn": "To succeed in doing something after a lot of effort.",
          "meaningVi": "Đạt được, hoàn thành sau nhiều nỗ lực.",
          "cefrLevel": "B1",
          "registerLabel": "neutral",      // neutral | formal | informal
          "domainLabel": "general",
          "grammarNote": "transitive",
          "usageNote": null,
          "isActive": 1,
          "tags": ["tag-business"],        // ← phải tồn tại trong tags.json
          "examples": [
            {
              "id": "ex-achieve-1",
              "englishText": "She worked hard to achieve her goals.",
              "vietnameseText": "Cô ấy làm việc chăm chỉ để đạt được mục tiêu.",
              "note": null,
              "sortOrder": 1
            }
          ]
        }
      ]
    }
  ]
}
```

**Bước 2 — Tăng version file đó trong `manifest.json`**

```jsonc
// assets/seed/manifest.json
{
  "manifest_version": 1,
  "files": [
    { "path": "headwords/b1.json", "version": 2 }  // ← 1 → 2
    // ...
  ]
}
```

Khi app khởi động lần tiếp theo, chỉ file `b1.json` được re-seed (idempotent — không mất progress học của người dùng).

### Thêm file level mới

1. Tạo file, ví dụ `assets/seed/headwords/b2.json`
2. Thêm entry vào `manifest.json`:
   ```json
   { "path": "headwords/b2.json", "version": 1 }
   ```
3. Khai báo thư mục trong `pubspec.yaml` nếu chưa có:
   ```yaml
   flutter:
     assets:
       - assets/seed/headwords/
   ```

### Quy ước đặt ID (bắt buộc unique)

| Loại | Pattern | Ví dụ |
|------|---------|-------|
| headword | `hw-<word>` | `hw-achieve` |
| sense | `sense-<word>-<pos><n>` | `sense-achieve-v1` |
| phrase | `phr-<slug>` | `phr-keep-in-mind` |
| phrase sense | `sense-phr-<slug>-<n>` | `sense-phr-keep-in-mind-1` |
| pronunciation | `pron-<word>-<accent>` | `pron-achieve-uk` |
| inflection | `inf-<word>-<n>` | `inf-achieve-1` |
| example | `ex-<word>-<n>` | `ex-achieve-1` |
| question | `q-<word>-<n>` | `q-achieve-1` |
| option | `opt-<abbr>-<n>` | `opt-ach-1` |

---

## Test

```bash
flutter test
```

Tests bao gồm:
- **Phase 1** — Database schema & idempotent seeding
- **Phase 2** — Repositories, SM-2 scheduling, quiz, settings
- **Phase 6** — Backup export / restore

---

## Database Schema

Xem [`lib/core/database/app_database.dart`](lib/core/database/app_database.dart) để biết đầy đủ schema.

Các bảng chính:

| Bảng | Mô tả |
|------|-------|
| `headwords` | Từ đầu mục với CEFR level |
| `senses` | Nghĩa của từ (1 từ có nhiều nghĩa) |
| `phrases` | Cụm từ, thành ngữ |
| `phrase_senses` | Nghĩa của cụm từ |
| `study_items` | Parent table cho senses + phrase\_senses |
| `learning_progress` | Tiến độ SM-2 mỗi study item |
| `review_events` | Lịch sử mỗi lần ôn |
| `questions` | Câu hỏi quiz |
| `question_options` | Lựa chọn cho câu hỏi |
| `tags` / `item_tags` | Tags và quan hệ nhiều-nhiều |
| `user_settings` | Cài đặt người dùng + seed version tracking |

---

## License

MIT
