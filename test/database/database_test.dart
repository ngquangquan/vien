import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:vien/core/database/app_database.dart';
import 'package:vien/core/database/seed_service.dart';

void main() {
  late AppDatabase db;
  late SeedService seedService;
  late Map<String, dynamic> seedData;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    seedService = SeedService(db);

    final seedFile = File('assets/seed/initial_seed.json');
    final content = await seedFile.readAsString();
    seedData = json.decode(content) as Map<String, dynamic>;
  });

  tearDown(() async {
    await db.close();
  });

  group('Phase 1 - Database Schema & Seeding Tests', () {
    test(
      'Fresh database creates successfully and foreign keys are enforced',
      () async {
        final rows = await db.select(db.headwords).get();
        expect(rows, isEmpty);

        // Attempting to insert a sense with invalid headwordId must fail due to foreign key
        expect(() async {
          await db
              .into(db.studyItems)
              .insert(
                StudyItemsCompanion.insert(
                  id: 'invalid-sense-item',
                  itemType: 'sense',
                  createdAtMs: 1000,
                ),
              );

          await db
              .into(db.senses)
              .insert(
                SensesCompanion.insert(
                  id: 'invalid-sense-item',
                  headwordId: 'non-existent-hw',
                  senseNumber: 1,
                  partOfSpeech: 'noun',
                  definitionEn: 'Test',
                ),
              );
        }, throwsA(isA<SqliteException>()));
      },
    );

    test('Seeding from JSON map populates all tables correctly', () async {
      final seeded = await seedService.seedFromJsonMap(seedData);
      expect(seeded, isTrue);

      // Check headwords
      final headwords = await db.select(db.headwords).get();
      expect(headwords.length, 3);

      final runHw = headwords.firstWhere((h) => h.spelling == 'run');
      expect(runHw.normalizedSpelling, 'run');

      // Check that "run" has multiple senses with different POS and CEFR levels
      final runSenses = await (db.select(
        db.senses,
      )..where((s) => s.headwordId.equals(runHw.id))).get();
      expect(runSenses.length, 3);

      final verbSense1 = runSenses.firstWhere((s) => s.senseNumber == 1);
      expect(verbSense1.partOfSpeech, 'verb');
      expect(verbSense1.cefrLevel, 'A1');

      final verbSense2 = runSenses.firstWhere((s) => s.senseNumber == 2);
      expect(verbSense2.partOfSpeech, 'verb');
      expect(verbSense2.cefrLevel, 'B1');

      final nounSense = runSenses.firstWhere((s) => s.senseNumber == 3);
      expect(nounSense.partOfSpeech, 'noun');
      expect(nounSense.cefrLevel, 'A2');

      // Check phrases
      final phrases = await db.select(db.phrases).get();
      expect(phrases.length, 2);

      // Check questions and options
      final questions = await db.select(db.questions).get();
      expect(questions.length, 3);

      final q1Options = await (db.select(
        db.questionOptions,
      )..where((o) => o.questionId.equals('q-run-v1'))).get();
      expect(q1Options.length, 4);
      final correctCount = q1Options.where((o) => o.isCorrect == 1).length;
      expect(correctCount, 1);

      // Check learning progress initialized
      final progressList = await db.select(db.learningProgress).get();
      expect(progressList.length, greaterThanOrEqualTo(5));
      for (final p in progressList) {
        expect(p.status, 'new');
        expect(p.repetitionCount, 0);
        expect(p.easeFactor, 2.5);
      }
    });

    test(
      'Seeding twice is idempotent and does not duplicate content',
      () async {
        final firstRun = await seedService.seedFromJsonMap(seedData);
        expect(firstRun, isTrue);

        final secondRun = await seedService.seedFromJsonMap(seedData);
        expect(secondRun, isFalse);

        final headwords = await db.select(db.headwords).get();
        expect(headwords.length, 3);
      },
    );

    test(
      'Deleting headword cascades to delete associated senses and examples',
      () async {
        await seedService.seedFromJsonMap(seedData);

        // Verify "run" exists
        final runBefore = await (db.select(
          db.headwords,
        )..where((h) => h.id.equals('hw-run'))).getSingleOrNull();
        expect(runBefore, isNotNull);

        // Delete "run"
        final deletedCount = await (db.delete(
          db.headwords,
        )..where((h) => h.id.equals('hw-run'))).go();
        expect(deletedCount, 1);

        // Check that senses of "run" are also deleted by cascade
        final runSenses = await (db.select(
          db.senses,
        )..where((s) => s.headwordId.equals('hw-run'))).get();
        expect(runSenses, isEmpty);

        // Check that examples of sense-run-v1 are deleted by cascade
        final runExamples = await (db.select(
          db.examples,
        )..where((e) => e.studyItemId.equals('sense-run-v1'))).get();
        expect(runExamples, isEmpty);
      },
    );
  });
}
