import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../review/data/review_repository.dart';
import '../../review/presentation/review_screen.dart';
import '../../vocabulary/data/vocabulary_repository.dart';
import '../../vocabulary/presentation/vocabulary_list_screen.dart';
import '../../phrases/data/phrases_repository.dart';
import '../../phrases/presentation/phrases_list_screen.dart';
import '../../quiz/data/quiz_repository.dart';
import '../../quiz/presentation/quiz_screen.dart';
import '../../settings/data/settings_repository.dart';

class HomeScreen extends StatefulWidget {
  final VocabularyRepository vocabRepo;
  final PhrasesRepository phrasesRepo;
  final ReviewRepository reviewRepo;
  final QuizRepository quizRepo;
  final SettingsRepository settingsRepo;

  const HomeScreen({
    super.key,
    required this.vocabRepo,
    required this.phrasesRepo,
    required this.reviewRepo,
    required this.quizRepo,
    required this.settingsRepo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> _stats = {};
  UserPreferences _prefs = const UserPreferences();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final stats = await widget.reviewRepo.getLearningStats();
    final prefs = await widget.settingsRepo.getPreferences();
    if (mounted) {
      setState(() {
        _stats = stats;
        _prefs = prefs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_stories, color: AppTheme.primaryColor),
            SizedBox(width: 8),
            Text('English Learning'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            StreamBuilder<int>(
              stream: widget.reviewRepo.watchDueCount(),
              builder: (context, snapshot) {
                final dueCount = snapshot.data ?? 0;

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ôn tập hôm nay (SM-2)',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              dueCount > 0
                                  ? '$dueCount mục đến hạn'
                                  : 'Đã hoàn thành',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        dueCount > 0
                            ? '$dueCount từ vựng cần củng cố'
                            : 'Bạn đã ôn hết từ vựng!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1E40AF),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  ReviewScreen(reviewRepo: widget.reviewRepo),
                            ),
                          );
                          _loadData();
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(
                          'Bắt đầu ôn tập',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mục tiêu hàng ngày',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${_prefs.dailyGoal} từ/ngày',
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value:
                            (_stats['review'] ?? 0) /
                            (_prefs.dailyGoal > 0 ? _prefs.dailyGoal : 10),
                        minHeight: 8,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Khám phá & Học tập',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildActionCard(
                  context,
                  title: 'Từ vựng (CEFR)',
                  subtitle: '${_stats['total'] ?? 0} mục từ',
                  icon: Icons.menu_book,
                  color: const Color(0xFF3B82F6),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          VocabularyListScreen(vocabRepo: widget.vocabRepo),
                    ),
                  ),
                ),
                _buildActionCard(
                  context,
                  title: 'Thành ngữ & Cụm từ',
                  subtitle: 'Idioms & Collocations',
                  icon: Icons.format_quote,
                  color: const Color(0xFF0D9488),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          PhrasesListScreen(phrasesRepo: widget.phrasesRepo),
                    ),
                  ),
                ),
                _buildActionCard(
                  context,
                  title: 'Trắc nghiệm (Quiz)',
                  subtitle: 'Kiểm tra phản xạ',
                  icon: Icons.quiz_outlined,
                  color: const Color(0xFF8B5CF6),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => QuizScreen(quizRepo: widget.quizRepo),
                    ),
                  ),
                ),
                _buildActionCard(
                  context,
                  title: 'Ôn tập thích ứng',
                  subtitle: 'Khoảng cách SM-2',
                  icon: Icons.psychology_outlined,
                  color: const Color(0xFFF59E0B),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          ReviewScreen(reviewRepo: widget.reviewRepo),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Thống kê tiến trình',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildStatPill(
                  'Mới',
                  _stats['new'] ?? 0,
                  const Color(0xFF64748B),
                ),
                const SizedBox(width: 8),
                _buildStatPill(
                  'Đang học',
                  _stats['learning'] ?? 0,
                  AppTheme.amberColor,
                ),
                const SizedBox(width: 8),
                _buildStatPill(
                  'Ôn tập',
                  _stats['review'] ?? 0,
                  AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                _buildStatPill(
                  'Thuần thục',
                  _stats['mastered'] ?? 0,
                  AppTheme.greenColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color, size: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatPill(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
