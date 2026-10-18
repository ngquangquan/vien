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
}

