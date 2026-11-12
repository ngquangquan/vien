import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:vien/app/app.dart';
import 'package:vien/core/database/app_database.dart';
import 'package:vien/core/notifications/notification_service.dart';

import 'package:vien/core/backup/backup_service.dart';
import 'package:vien/features/phrases/data/phrases_repository.dart';
import 'package:vien/features/settings/data/settings_repository.dart';
import 'package:vien/features/settings/presentation/reminder_settings_screen.dart';
import 'package:vien/features/settings/presentation/settings_screen.dart';
import 'package:vien/features/tags/data/tags_repository.dart';
import 'package:vien/features/vocabulary/data/vocabulary_repository.dart';
import 'package:vien/features/vocabulary/domain/models/vocabulary_models.dart';
import 'package:vien/features/vocabulary/presentation/vocabulary_list_screen.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final notifService = NotificationService();

    await tester.pumpWidget(EnglishLearningApp(
      db: db,
      notifService: notifService,
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await db.close();
  });

  testWidgets('ReminderSettingsScreen pumps without error', (WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final notifService = NotificationService();
    final settingsRepo = SettingsRepository(db);

    await tester.pumpWidget(MaterialApp(
      home: ReminderSettingsScreen(
        settingsRepo: settingsRepo,
        notifService: notifService,
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Cài đặt nhắc nhở học tập'), findsOneWidget);

    await db.close();
  });

  testWidgets('SettingsScreen taps on reminder config and navigates smoothly', (WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final notifService = NotificationService();
    final settingsRepo = SettingsRepository(db);
    final tagsRepo = TagsRepository(db);
    final vocabRepo = VocabularyRepository(db);
    final phrasesRepo = PhrasesRepository(db);
    final backupService = BackupService(db, vocabRepo, phrasesRepo);

    await tester.pumpWidget(MaterialApp(
      home: SettingsScreen(
        settingsRepo: settingsRepo,
        tagsRepo: tagsRepo,
        backupService: backupService,
        notifService: notifService,
      ),
    ));

    await tester.pumpAndSettle();

    final tileFinder = find.text('Cấu hình lịch & chu kỳ nhắc nhở');
    expect(tileFinder, findsOneWidget);

    await tester.tap(tileFinder);
    await tester.pumpAndSettle();

    expect(find.text('Cài đặt nhắc nhở học tập'), findsOneWidget);

    await db.close();
  });

  testWidgets('Vocabulary search is debounced and keeps the list while loading', (
    WidgetTester tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final repo = _FakeVocabularyRepository(db);

    await tester.pumpWidget(
      MaterialApp(home: VocabularyListScreen(vocabRepo: repo)),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    repo.results.last.add(const [
      Headword(
        id: 'hw-run',
        spelling: 'run',
        normalizedSpelling: 'run',
        homographNo: 1,
        cefrLevel: null,
        notes: null,
        isArchived: 0,
        createdAtMs: 0,
        updatedAtMs: 0,
      ),
    ]);
    await tester.pump();
    expect(find.text('run'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'ru');
    await tester.pump(const Duration(milliseconds: 100));
    expect(repo.queries.last, isEmpty, reason: 'no query while still typing');

    await tester.pump(const Duration(milliseconds: 300));
    expect(repo.queries.last, 'ru');
    // The new query has not answered yet: old list stays, no spinner flash.
    expect(find.text('run'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await db.close();
  });
}

class _FakeVocabularyRepository extends VocabularyRepository {
  _FakeVocabularyRepository(super.db);

  final queries = <String>[];
  final results = <StreamController<List<Headword>>>[];

  @override
  Stream<List<Headword>> watchHeadwords(VocabularyFilter filter) {
    queries.add(filter.query ?? '');
    results.add(StreamController<List<Headword>>());
    return results.last.stream;
  }
}

