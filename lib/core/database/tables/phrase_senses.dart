import 'package:drift/drift.dart';

import 'phrases.dart';
import 'study_items.dart';

@TableIndex(name: 'idx_phrase_senses_phrase', columns: {#phraseId})
@TableIndex(name: 'idx_phrase_senses_cefr', columns: {#cefrLevel})
class PhraseSenses extends Table {
  TextColumn get id =>
      text().references(StudyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get phraseId =>
      text().references(Phrases, #id, onDelete: KeyAction.cascade)();
  IntColumn get senseNumber => integer().withDefault(const Constant(1))();
  TextColumn get partOfSpeech => text().nullable()();
  TextColumn get definitionEn => text()();
  TextColumn get meaningVi => text().nullable()();
  TextColumn get cefrLevel => text().nullable()();
  TextColumn get registerLabel => text().nullable()();
  TextColumn get domainLabel => text().nullable()();
  TextColumn get grammarNote => text().nullable()();
  TextColumn get usageNote => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {phraseId, senseNumber},
  ];
}
