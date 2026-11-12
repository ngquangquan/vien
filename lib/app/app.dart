import 'dart:async';

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
import '../features/vocabulary/presentation/headword_detail_screen.dart';
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
  final navigatorKey = GlobalKey<NavigatorState>();
  late final VocabularyRepository vocabRepo;
  late final PhrasesRepository phrasesRepo;
  late final TagsRepository tagsRepo;
  late final ReviewRepository reviewRepo;
  late final QuizRepository quizRepo;
  late final SettingsRepository settingsRepo;
  late final BackupService backupService;
  bool _isReady = false;
  double _seedProgress = 0;
  String _seedMessage = 'Đang chuẩn bị dữ liệu...';

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
    final seeded = await _seedAssets();
    if (!seeded) return;

    try {
      // Initialize notification service
      await widget.notifService.initialize(onSelectNotification: _openPayload);
    } catch (e, st) {
      debugPrint('Notification initialization error: $e\n$st');
    }

    unawaited(_rescheduleReminders());

    if (mounted) {
      setState(() => _isReady = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openLaunchNotification();
      });
    }
  }

  /// Only a finite batch of occurrences is ever scheduled (and desktop timers
  /// live in memory), so top the schedule up on every launch — otherwise
  /// reminders silently stop once the batch runs out.
  Future<void> _rescheduleReminders() async {
    try {
      final prefs = await settingsRepo.getPreferences();
      if (!prefs.reminderEnabled) return;
      await widget.notifService.scheduleFromCron(
        cronExpression: prefs.reminderCronExpression,
        title: 'Đã đến giờ học từ vựng!',
        body: 'Dành vài phút ôn tập từ vựng và làm trắc nghiệm hôm nay nhé.',
        payload: '/review',
      );
    } catch (e, st) {
      debugPrint('Reminder reschedule error: $e\n$st');
    }
  }

  Future<bool> _seedAssets() async {
    try {
      final seeder = SeedService(widget.db);
      await seeder.seedFromAssets(
        onProgress: (progress, message) {
          if (!mounted) return;
          setState(() {
            _seedProgress = progress;
            _seedMessage = message;
          });
        },
      );
      return true;
    } catch (e, st) {
      debugPrint('Seed initialization error: $e\n$st');
      if (mounted) {
        setState(() {
          _seedMessage = 'Không thể nạp dữ liệu. $e';
        });
      }
      return false;
    }
  }

  Future<void> _openPayload(String? payload) async {
    if (payload == null || !payload.startsWith('vocabulary:')) return;
    final headwordId = payload.substring('vocabulary:'.length);
    final navigator = navigatorKey.currentState;
    if (navigator == null || headwordId.isEmpty) return;

    navigator.push(
      MaterialPageRoute<void>(
        builder: (_) =>
            HeadwordDetailScreen(headwordId: headwordId, vocabRepo: vocabRepo),
      ),
    );
  }

  Future<void> _openLaunchNotification() async {
    final payload = await widget.notifService.getLaunchPayload();
    if (payload != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openPayload(payload);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      final percent = (_seedProgress * 100).round();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Đang khởi tạo từ điển offline: $percent%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: LinearProgressIndicator(value: _seedProgress),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(_seedMessage, textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
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
