import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/content_sources.dart';
import 'tables/examples.dart';
import 'tables/headwords.dart';
import 'tables/inflections.dart';
import 'tables/learning_progress.dart';
import 'tables/notification_rules.dart';
import 'tables/phrase_senses.dart';
import 'tables/phrases.dart';
import 'tables/pronunciations.dart';
import 'tables/questions.dart';
import 'tables/senses.dart';
import 'tables/study_items.dart';
import 'tables/tags.dart';
import 'tables/user_settings.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Headwords,
    StudyItems,
    Senses,
    Phrases,
    PhraseSenses,
    Pronunciations,
    Inflections,
    ContentSources,
    SourceAttributions,
    Examples,
    Tags,
    ItemTags,
    Questions,
    QuestionOptions,
    LearningProgress,
    ReviewEvents,
    UserSettings,
    NotificationRules,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement('''
            CREATE TRIGGER IF NOT EXISTS trg_delete_sense_study_item
            AFTER DELETE ON senses
            BEGIN
              DELETE FROM study_items WHERE id = OLD.id;
            END;
          ''');
      await customStatement('''
            CREATE TRIGGER IF NOT EXISTS trg_delete_phrase_sense_study_item
            AFTER DELETE ON phrase_senses
            BEGIN
              DELETE FROM study_items WHERE id = OLD.id;
            END;
          ''');
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'english_learning.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
