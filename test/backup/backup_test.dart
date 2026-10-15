import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:vien/core/database/app_database.dart';
import 'package:vien/core/database/seed_service.dart';
import 'package:vien/core/backup/backup_service.dart';
import 'package:vien/features/vocabulary/data/vocabulary_repository.dart';
import 'package:vien/features/phrases/data/phrases_repository.dart';

void main() {
  late AppDatabase db;
  late VocabularyRepository vocabRepo;
  late PhrasesRepository phrasesRepo;
  late BackupService backupService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    vocabRepo = VocabularyRepository(db);
    phrasesRepo = PhrasesRepository(db);
    backupService = BackupService(db, vocabRepo, phrasesRepo);

    final seedService = SeedService(db);
    final seedFile = File('assets/seed/initial_seed.json');
    final content = await seedFile.readAsString();
    final seedData = json.decode(content) as Map<String, dynamic>;
    await seedService.seedFromJsonMap(seedData);
  });

  tearDown(() async {
    await db.close();
  });

  group('Phase 6 - Backup & Restore Tests', () {
    test('Export produces valid JSON with correct counts', () async {
      final jsonStr = await backupService.exportToJsonString();
      expect(jsonStr, isNotEmpty);

      final preview = backupService.previewBackup(jsonStr);
      expect(preview.headwordsCount, 3);
      expect(preview.phrasesCount, 2);
      expect(preview.tagsCount, 4);
      expect(preview.questionsCount, 3);
      expect(preview.schemaVersion, 1);
    });

    test(
      'Restore in replace mode successfully restores database content',
      () async {
        final jsonStr = await backupService.exportToJsonString();

        // Clear by restoring in replace mode
        await backupService.restoreFromJsonString(jsonStr, replaceMode: true);

        final headwords = await db.select(db.headwords).get();
        expect(headwords.length, 3);

        final phrases = await db.select(db.phrases).get();
        expect(phrases.length, 2);
      },
    );
  });
}
