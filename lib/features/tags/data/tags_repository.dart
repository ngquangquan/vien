import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class TagsRepository {
  final AppDatabase db;
  final _uuid = const Uuid();

  TagsRepository(this.db);

  Stream<List<Tag>> watchAllTags() {
    return (db.select(
      db.tags,
    )..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();
  }

  Future<List<Tag>> getAllTags() {
    return (db.select(
      db.tags,
    )..orderBy([(t) => OrderingTerm(expression: t.name)])).get();
  }

  Future<Tag?> getTagById(String id) {
    return (db.select(
      db.tags,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Tag> createTag({
    required String name,
    required String category,
    String? slug,
    String? description,
  }) async {
    final tagSlug = (slug != null && slug.trim().isNotEmpty)
        ? slug.trim().toLowerCase()
        : name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '-');

    final existing = await (db.select(
      db.tags,
    )..where((t) => t.slug.equals(tagSlug))).getSingleOrNull();
    if (existing != null) {
      throw Exception('Tag với slug "$tagSlug" đã tồn tại.');
    }

    final id = _uuid.v4();
    await db
        .into(db.tags)
        .insert(
          TagsCompanion.insert(
            id: id,
            slug: tagSlug,
            name: name.trim(),
            category: category,
            description: Value(description?.trim()),
          ),
        );

    final created = await getTagById(id);
    return created!;
  }

  Future<void> updateTag(Tag tag) async {
    await db.update(db.tags).replace(tag);
  }

  Future<int> deleteTag(String id) async {
    return (db.delete(db.tags)..where((t) => t.id.equals(id))).go();
  }
}
