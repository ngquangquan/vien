import 'package:flutter/material.dart';

import '../core/database/app_database.dart';
import '../core/database/seed_service.dart';
import '../core/backup/backup_service.dart';
import '../core/notifications/notification_service.dart';
import '../features/vocabulary/data/vocabulary_repository.dart';
import '../features/phrases/data/phrases_repository.dart';
import '../features/tags/data/tags_repository.dart';
import '../features/review/data/review_repository.dart';
import '../features/quiz/data/quiz_repository.dart';
import '../features/settings/data/settings_repository.dart';
import 'main_scaffold.dart';
import 'theme.dart';

class EnglishLearningApp extends StatefulWidget {
  final AppDatabase db;
  final NotificationService notifService;

  const EnglishLearningApp({
    super.key,
    required this.db,
    required this.notifService,
  });

  @override
  State<EnglishLearningApp> createState() => _EnglishLearningAppState();
}

class _EnglishLearningAppState extends State<EnglishLearningApp> {
  late final VocabularyRepository vocabRepo;
  late final PhrasesRepository phrasesRepo;
  late final TagsRepository tagsRepo;
  late final ReviewRepository reviewRepo;
  late final QuizRepository quizRepo;
  late final SettingsRepository settingsRepo;
  late final BackupService backupService;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    vocabRepo = VocabularyRepository(widget.db);
    phrasesRepo = PhrasesRepository(widget.db);
    tagsRepo = TagsRepository(widget.db);
    reviewRepo = ReviewRepository(widget.db);
    quizRepo = QuizRepository(widget.db, reviewRepo);
    settingsRepo = SettingsRepository(widget.db);
    backupService = BackupService(widget.db, vocabRepo, phrasesRepo);

    _initApp();
  }

  Future<void> _initApp() async {
    try {
      // Perform initial seed if first launch
      final seeder = SeedService(widget.db);
      await seeder.seedFromAssets();
    } catch (e, st) {
      debugPrint('Seed initialization error: $e\n$st');
    }

    try {
      // Initialize notification service
      await widget.notifService.initialize();
    } catch (e, st) {
      debugPrint('Notification initialization error: $e\n$st');
    }

    if (mounted) {
      setState(() => _isReady = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Đang khởi tạo từ điển offline...'),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'English Learning',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: MainScaffold(
        vocabRepo: vocabRepo,
        phrasesRepo: phrasesRepo,
        reviewRepo: reviewRepo,
        quizRepo: quizRepo,
        tagsRepo: tagsRepo,
        settingsRepo: settingsRepo,
        backupService: backupService,
        notifService: widget.notifService,
      ),
    );
  }
}
