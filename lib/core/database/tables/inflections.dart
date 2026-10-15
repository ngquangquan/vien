import 'package:drift/drift.dart';

import 'headwords.dart';

class Inflections extends Table {
  TextColumn get id => text()();
  TextColumn get headwordId =>
      text().references(Headwords, #id, onDelete: KeyAction.cascade)();
  TextColumn get form => text()();
  TextColumn get formType => text()(); // plural, past, past_participle, third_person_singular, ing, comparative, superlative, alternative_spelling

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {headwordId, form, formType},
  ];
}
