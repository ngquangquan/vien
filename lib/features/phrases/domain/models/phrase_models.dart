import '../../../../core/database/app_database.dart';

class PhraseSenseDetail {
  final PhraseSense sense;
  final List<Example> examples;
  final List<Tag> tags;
  final LearningProgressData? progress;

  const PhraseSenseDetail({
    required this.sense,
    this.examples = const [],
    this.tags = const [],
    this.progress,
  });
}

class PhraseDetail {
  final Phrase phrase;
  final List<PhraseSenseDetail> senses;

  const PhraseDetail({required this.phrase, this.senses = const []});
}

class PhraseFilter {
  final String? query;
  final List<String> phraseTypes;
  final List<String> cefrLevels;
  final List<String> tagIds;
  final bool? isFavorite;
  final bool onlyArchived;

  const PhraseFilter({
    this.query,
    this.phraseTypes = const [],
    this.cefrLevels = const [],
    this.tagIds = const [],
    this.isFavorite,
    this.onlyArchived = false,
  });

  bool get hasActiveFilter =>
      (query != null && query!.trim().isNotEmpty) ||
      phraseTypes.isNotEmpty ||
      cefrLevels.isNotEmpty ||
      tagIds.isNotEmpty ||
      isFavorite != null ||
      onlyArchived;
}
