import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';

/// What word senses and phrase senses have in common: each is a study item
/// owning examples, tags and one learning-progress row.
class StudyItemStore {
  final AppDatabase db;
  static const _uuid = Uuid();

  const StudyItemStore(this.db);

  /// Creates the study item (and its 'new' progress row if missing), then
  /// replaces its tags and examples. Call inside the caller's transaction,
  /// before upserting the sense row — the sense id references study_items.
  Future<void> save(
    String id, {
    required String itemType, // 'sense' | 'phrase_sense'
    required List<Tag> tags,
    required List<Example> examples,
    required int now,
  }) async {
    await db
        .into(db.studyItems)
        .insertOnConflictUpdate(
          StudyItemsCompanion.insert(
            id: id,
            itemType: itemType,
            createdAtMs: now,
          ),
        );

    await db
        .into(db.learningProgress)
        .insert(
          LearningProgressCompanion.insert(
            studyItemId: id,
            status: 'new',
            updatedAtMs: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );

    await (db.delete(db.itemTags)..where((t) => t.studyItemId.equals(id))).go();
    for (final tag in tags) {
      await db
          .into(db.itemTags)
          .insertOnConflictUpdate(
            ItemTagsCompanion.insert(studyItemId: id, tagId: tag.id),
          );
    }

    await (db.delete(db.examples)..where((e) => e.studyItemId.equals(id))).go();
    var sortOrder = 1;
    for (final ex in examples) {
      if (ex.englishText.trim().isEmpty) continue;
      await db
          .into(db.examples)
          .insert(
            ExamplesCompanion.insert(
              id: ex.id.trim().isEmpty ? _uuid.v4() : ex.id,
              studyItemId: id,
              englishText: ex.englishText.trim(),
              vietnameseText: Value(ex.vietnameseText?.trim()),
              note: Value(ex.note?.trim()),
              sortOrder: Value(sortOrder++),
            ),
          );
    }
  }

  Future<({List<Example> examples, List<Tag> tags, LearningProgressData? progress})>
  load(String id) async {
    final examples =
        await (db.select(db.examples)
              ..where((e) => e.studyItemId.equals(id))
              ..orderBy([(e) => OrderingTerm(expression: e.sortOrder)]))
            .get();

    final tagIds = db.selectOnly(db.itemTags)
      ..addColumns([db.itemTags.tagId])
      ..where(db.itemTags.studyItemId.equals(id));
    final tags = await (db.select(
      db.tags,
    )..where((t) => t.id.isInQuery(tagIds))).get();

    final progress = await (db.select(
      db.learningProgress,
    )..where((p) => p.studyItemId.equals(id))).getSingleOrNull();

    return (examples: examples, tags: tags, progress: progress);
  }
}
