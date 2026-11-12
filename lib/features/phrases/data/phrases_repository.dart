import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/study_item_store.dart';
import '../domain/models/phrase_models.dart';

class PhrasesRepository {
  final AppDatabase db;
  final _uuid = const Uuid();
  late final _items = StudyItemStore(db);

  PhrasesRepository(this.db);

  Stream<List<Phrase>> watchPhrases(PhraseFilter filter) {
    return _buildPhrasesQuery(filter).watch();
  }

  Future<List<Phrase>> searchPhrases(PhraseFilter filter) {
    return _buildPhrasesQuery(filter).get();
  }

  SimpleSelectStatement<$PhrasesTable, Phrase> _buildPhrasesQuery(
    PhraseFilter filter,
  ) {
    final query = db.select(db.phrases);

    query.where((tbl) {
      final List<Expression<bool>> predicates = [];

      predicates.add(tbl.isArchived.equals(filter.onlyArchived ? 1 : 0));

      if (filter.phraseTypes.isNotEmpty) {
        predicates.add(tbl.phraseType.isIn(filter.phraseTypes));
      }

      if (filter.query != null && filter.query!.trim().isNotEmpty) {
        final rawTerm = filter.query!.trim().toLowerCase();
        final searchPattern = '%$rawTerm%';

        final matchingSensePhraseIds = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(
            db.phraseSenses.definitionEn.lower().like(searchPattern) |
                db.phraseSenses.meaningVi.lower().like(searchPattern),
          );

        predicates.add(
          tbl.normalizedPhrase.like(searchPattern) |
              tbl.id.isInQuery(matchingSensePhraseIds),
        );
      }

      if (filter.cefrLevels.isNotEmpty) {
        final phraseMatchingCefr = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(db.phraseSenses.cefrLevel.isIn(filter.cefrLevels));

        predicates.add(tbl.id.isInQuery(phraseMatchingCefr));
      }

      if (filter.tagIds.isNotEmpty) {
        final senseIdsWithTags = db.selectOnly(db.itemTags)
          ..addColumns([db.itemTags.studyItemId])
          ..where(db.itemTags.tagId.isIn(filter.tagIds));

        final phrasesWithTags = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(db.phraseSenses.id.isInQuery(senseIdsWithTags));

        predicates.add(tbl.id.isInQuery(phrasesWithTags));
      }

      if (filter.isFavorite != null) {
        final favSenseIds = db.selectOnly(db.learningProgress)
          ..addColumns([db.learningProgress.studyItemId])
          ..where(
            db.learningProgress.isFavorite.equals(filter.isFavorite! ? 1 : 0),
          );

        final phrasesWithFav = db.selectOnly(db.phraseSenses)
          ..addColumns([db.phraseSenses.phraseId])
          ..where(db.phraseSenses.id.isInQuery(favSenseIds));

        predicates.add(tbl.id.isInQuery(phrasesWithFav));
      }

      return Expression.and(predicates);
    });

    query.orderBy([(tbl) => OrderingTerm(expression: tbl.phrase)]);
    return query;
  }

  Future<PhraseDetail?> getPhraseDetail(String id) async {
    final phrase = await (db.select(
      db.phrases,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (phrase == null) return null;

    final sensesRows =
        await (db.select(db.phraseSenses)
              ..where((tbl) => tbl.phraseId.equals(id))
              ..orderBy([(s) => OrderingTerm(expression: s.senseNumber)]))
            .get();

    final List<PhraseSenseDetail> senseDetails = [];

    for (final s in sensesRows) {
      final item = await _items.load(s.id);
      senseDetails.add(
        PhraseSenseDetail(
          sense: s,
          examples: item.examples,
          tags: item.tags,
          progress: item.progress,
        ),
      );
    }

    return PhraseDetail(phrase: phrase, senses: senseDetails);
  }

  Future<String> savePhrase(PhraseDetail detail) async {
    final text = detail.phrase.phrase.trim();
    if (text.isEmpty) {
      throw ArgumentError('Cụm từ / thành ngữ không được để trống.');
    }
    final normalized = text.toLowerCase();
    final now = DateTime.now().millisecondsSinceEpoch;
    final phraseId = detail.phrase.id.trim().isEmpty
        ? _uuid.v4()
        : detail.phrase.id;

    if (detail.senses.isEmpty) {
      throw ArgumentError('Mỗi cụm từ phải có ít nhất một định nghĩa.');
    }

    for (final s in detail.senses) {
      if (s.sense.definitionEn.trim().isEmpty) {
        throw ArgumentError(
          'Định nghĩa tiếng Anh (definition_en) là bắt buộc cho mỗi nghĩa.',
        );
      }
    }

    await db.transaction(() async {
      await db
          .into(db.phrases)
          .insertOnConflictUpdate(
            PhrasesCompanion.insert(
              id: phraseId,
              phrase: text,
              normalizedPhrase: normalized,
              phraseType: detail.phrase.phraseType,
              cefrLevel: Value(detail.phrase.cefrLevel),
              notes: Value(detail.phrase.notes),
              isArchived: Value(detail.phrase.isArchived),
              createdAtMs: detail.phrase.createdAtMs == 0
                  ? now
                  : detail.phrase.createdAtMs,
              updatedAtMs: now,
            ),
          );

      // Senses handling
      final existingSenses = await (db.select(
        db.phraseSenses,
      )..where((s) => s.phraseId.equals(phraseId))).get();
      final existingSenseIds = existingSenses.map((s) => s.id).toSet();
      final newSenseIds = detail.senses
          .map((s) => s.sense.id)
          .where((id) => id.isNotEmpty)
          .toSet();

      final sensesToDelete = existingSenseIds.difference(newSenseIds);
      for (final senseId in sensesToDelete) {
        await (db.delete(
          db.phraseSenses,
        )..where((s) => s.id.equals(senseId))).go();
      }

      int senseNumber = 1;
      for (final s in detail.senses) {
        final senseId = s.sense.id.trim().isEmpty ? _uuid.v4() : s.sense.id;

        await _items.save(
          senseId,
          itemType: 'phrase_sense',
          tags: s.tags,
          examples: s.examples,
          now: now,
        );

        await db
            .into(db.phraseSenses)
            .insertOnConflictUpdate(
              PhraseSensesCompanion.insert(
                id: senseId,
                phraseId: phraseId,
                senseNumber: Value(senseNumber++),
                partOfSpeech: Value(s.sense.partOfSpeech?.trim()),
                definitionEn: s.sense.definitionEn.trim(),
                meaningVi: Value(s.sense.meaningVi?.trim()),
                cefrLevel: Value(s.sense.cefrLevel?.trim()),
                registerLabel: Value(s.sense.registerLabel?.trim()),
                domainLabel: Value(s.sense.domainLabel?.trim()),
                grammarNote: Value(s.sense.grammarNote?.trim()),
                usageNote: Value(s.sense.usageNote?.trim()),
                isActive: Value(s.sense.isActive),
              ),
            );
      }
    });

    return phraseId;
  }

  Future<void> archivePhrase(String id, bool archive) async {
    await (db.update(db.phrases)..where((p) => p.id.equals(id))).write(
      PhrasesCompanion(
        isArchived: Value(archive ? 1 : 0),
        updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<int> deletePhrase(String id) async {
    return (db.delete(db.phrases)..where((p) => p.id.equals(id))).go();
  }
}
