import 'package:flutter/material.dart';

import '../core/backup/backup_service.dart';
import '../core/notifications/notification_service.dart';
import '../core/utils/responsive.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/phrases/data/phrases_repository.dart';
import '../features/phrases/presentation/phrases_list_screen.dart';
import '../features/quiz/data/quiz_repository.dart';
import '../features/review/data/review_repository.dart';
import '../features/review/presentation/review_screen.dart';
import '../features/settings/data/settings_repository.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/tags/data/tags_repository.dart';
import '../features/vocabulary/data/vocabulary_repository.dart';
import '../features/vocabulary/presentation/vocabulary_list_screen.dart';
import 'theme.dart';

class MainScaffold extends StatefulWidget {
  final VocabularyRepository vocabRepo;
  final PhrasesRepository phrasesRepo;
  final ReviewRepository reviewRepo;
  final QuizRepository quizRepo;
  final TagsRepository tagsRepo;
  final SettingsRepository settingsRepo;
  final BackupService backupService;
  final NotificationService notifService;

  const MainScaffold({
    super.key,
    required this.vocabRepo,
    required this.phrasesRepo,
    required this.reviewRepo,
    required this.quizRepo,
    required this.tagsRepo,
    required this.settingsRepo,
    required this.backupService,
    required this.notifService,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        vocabRepo: widget.vocabRepo,
        phrasesRepo: widget.phrasesRepo,
        reviewRepo: widget.reviewRepo,
        quizRepo: widget.quizRepo,
        settingsRepo: widget.settingsRepo,
      ),
      VocabularyListScreen(vocabRepo: widget.vocabRepo),
      PhrasesListScreen(phrasesRepo: widget.phrasesRepo),
      ReviewScreen(reviewRepo: widget.reviewRepo),
      SettingsScreen(
        settingsRepo: widget.settingsRepo,
        tagsRepo: widget.tagsRepo,
        backupService: widget.backupService,
        notifService: widget.notifService,
      ),
    ];

    final isWide = Responsive.isWide(context);

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              right: false,
              child: NavigationRail(
                selectedIndex: _currentIndex,
                onDestinationSelected: (idx) =>
                    setState(() => _currentIndex = idx),
                labelType: NavigationRailLabelType.all,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_stories,
                          color: AppTheme.primaryColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Vien',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Trang chủ'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.menu_book_outlined),
                    selectedIcon: Icon(Icons.menu_book),
                    label: Text('Từ vựng'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.format_quote_outlined),
                    selectedIcon: Icon(Icons.format_quote),
                    label: Text('Cụm từ'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.psychology_outlined),
                    selectedIcon: Icon(Icons.psychology),
                    label: Text('Ôn tập'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Cài đặt'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(index: _currentIndex, children: pages),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Từ vựng',
          ),
          NavigationDestination(
            icon: Icon(Icons.format_quote_outlined),
            selectedIcon: Icon(Icons.format_quote),
            label: 'Cụm từ',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology_outlined),
            selectedIcon: Icon(Icons.psychology),
            label: 'Ôn tập',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
