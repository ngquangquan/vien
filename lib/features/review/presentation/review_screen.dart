import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/cefr_badge.dart';
import '../../../shared/widgets/speak_button.dart';
import '../data/review_repository.dart';

class ReviewScreen extends StatefulWidget {
  final ReviewRepository reviewRepo;

  const ReviewScreen({super.key, required this.reviewRepo});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<ReviewItemCandidate> _items = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  bool _isAnswerRevealed = false;
  int _sessionReviewedCount = 0;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() => _isLoading = true);
    final items = await widget.reviewRepo.getDueReviewItems(limit: 20);
    setState(() {
      _items = items;
      _isLoading = false;
      _currentIndex = 0;
      _isAnswerRevealed = false;
    });
  }

  Future<void> _answerQuality(int quality) async {
    if (_currentIndex >= _items.length) return;

    final item = _items[_currentIndex];
    await widget.reviewRepo.submitReviewResult(
      studyItemId: item.studyItem.id,
      quality: quality,
      studyMode: 'review',
    );

    setState(() {
      _sessionReviewedCount++;
      _currentIndex++;
      _isAnswerRevealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ôn tập thích ứng (SM-2)')),
        body: const SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_items.isEmpty || _currentIndex >= _items.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ôn tập thích ứng (SM-2)')),
        body: SafeArea(
          child: ResponsiveContainer(
            maxWidth: 600,
            expand: true,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.greenColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        size: 72,
                        color: AppTheme.greenColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Tuyệt vời!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _sessionReviewedCount > 0
                          ? 'Bạn đã hoàn thành phiên ôn tập với $_sessionReviewedCount mục!'
                          : 'Hiện không có từ hoặc cụm từ nào đến hạn ôn tập hôm nay.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _loadItems,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Kiểm tra lại'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    final current = _items[_currentIndex];
    final progressVal = (_currentIndex + 1) / _items.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ôn tập (${_currentIndex + 1}/${_items.length})'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progressVal,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppTheme.primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 680,
          child: Column(
            children: [
              Expanded(
                child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                current.posOrType.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            if (current.cefrLevel != null) ...[
                              const SizedBox(width: 8),
                              CefrBadge(level: current.cefrLevel),
                            ],
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                current.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SpeakButton(
                              text: current.title,
                              iconSize: 28,
                              tooltip: 'Nghe phát âm',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (current.exampleTexts.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Ví dụ: "${current.exampleTexts.first}"',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              SpeakButton(
                                text: current.exampleTexts.first,
                                iconSize: 18,
                                tooltip: 'Nghe câu ví dụ',
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 24),

                        if (!_isAnswerRevealed) ...[
                          OutlinedButton.icon(
                            onPressed: () =>
                                setState(() => _isAnswerRevealed = true),
                            icon: const Icon(Icons.visibility_outlined),
                            label: const Text(
                              'Xem định nghĩa & nghĩa tiếng Việt',
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ] else ...[
                          const Divider(height: 32),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Định nghĩa (Learner Definition):',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  current.definitionEn,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (current.meaningVi != null) ...[
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Nghĩa tiếng Việt:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    current.meaningVi!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.accentColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (_isAnswerRevealed) ...[
              const Text(
                'Mức độ ghi nhớ (SM-2):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.redColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _answerQuality(1),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Quên',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '1 ngày',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.amberColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _answerQuality(3),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Khó',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'vừa sức',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _answerQuality(4),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tốt',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'nhớ rõ',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.greenColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _answerQuality(5),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Dễ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'nhuần nhuyễn',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
      ),
    );
  }
}
