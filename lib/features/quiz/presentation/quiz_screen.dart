import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../shared/widgets/cefr_badge.dart';
import '../data/quiz_repository.dart';

class QuizScreen extends StatefulWidget {
  final QuizRepository quizRepo;

  const QuizScreen({super.key, required this.quizRepo});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestionDetail> _questions = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  String? _selectedOptionId;
  QuizAnswerResult? _lastResult;
  int _score = 0;
  bool _isFinished = false;
  final stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _startSession();
  }

  Future<void> _startSession() async {
    setState(() {
      _isLoading = true;
      _isFinished = false;
      _score = 0;
      _currentIndex = 0;
      _selectedOptionId = null;
      _lastResult = null;
    });

    final list = await widget.quizRepo.getQuizSession(limit: 10);
    setState(() {
      _questions = list;
      _isLoading = false;
      stopwatch.reset();
      stopwatch.start();
    });
  }

  Future<void> _selectOption(String optionId) async {
    if (_selectedOptionId != null) return; // Prevent multiple selection

    final elapsed = stopwatch.elapsedMilliseconds;
    setState(() => _selectedOptionId = optionId);

    final currentQ = _questions[_currentIndex];
    final result = await widget.quizRepo.submitQuizAnswer(
      questionId: currentQ.question.id,
      selectedOptionId: optionId,
      elapsedMs: elapsed,
    );

    setState(() {
      _lastResult = result;
      if (result.isCorrect) _score++;
    });
  }

  void _nextQuestion() {
    if (_currentIndex + 1 >= _questions.length) {
      setState(() => _isFinished = true);
    } else {
      setState(() {
        _currentIndex++;
        _selectedOptionId = null;
        _lastResult = null;
        stopwatch.reset();
        stopwatch.start();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Luyện tập trắc nghiệm')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Luyện tập trắc nghiệm')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz_outlined, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text('Chưa có câu hỏi trắc nghiệm nào.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _startSession,
                child: const Text('Tải lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isFinished) {
      final percentage = ((_score / _questions.length) * 100).round();

      return Scaffold(
        appBar: AppBar(title: const Text('Kết quả trắc nghiệm')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: percentage >= 70
                        ? AppTheme.greenColor.withValues(alpha: 0.12)
                        : AppTheme.amberColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    percentage >= 70
                        ? Icons.emoji_events_outlined
                        : Icons.lightbulb_outline,
                    size: 72,
                    color: percentage >= 70
                        ? AppTheme.greenColor
                        : AppTheme.amberColor,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  percentage >= 70 ? 'Xuất sắc!' : 'Hãy cố gắng hơn!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bạn trả lời đúng $_score / ${_questions.length} câu ($percentage%)',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _startSession,
                  icon: const Icon(Icons.replay),
                  label: const Text('Làm bài mới'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentQ = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Câu ${_currentIndex + 1}/${_questions.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppTheme.primaryColor,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          currentQ.question.questionType
                              .replaceAll('_', ' ')
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                      if (currentQ.question.cefrLevel != null) ...[
                        const SizedBox(width: 8),
                        CefrBadge(level: currentQ.question.cefrLevel),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentQ.question.prompt,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Options list
          ...currentQ.options.map((opt) {
            Color? bgColor;
            Color? borderColor;

            if (_lastResult != null) {
              if (opt.id == _lastResult!.correctOptionId) {
                bgColor = AppTheme.greenColor.withValues(alpha: 0.15);
                borderColor = AppTheme.greenColor;
              } else if (opt.id == _selectedOptionId &&
                  !_lastResult!.isCorrect) {
                bgColor = AppTheme.redColor.withValues(alpha: 0.15);
                borderColor = AppTheme.redColor;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _selectedOptionId == null
                    ? () => _selectOption(opt.id)
                    : null,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: borderColor ?? const Color(0xFFE2E8F0),
                      width: borderColor != null ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          opt.optionText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: borderColor ?? Colors.black87,
                          ),
                        ),
                      ),
                      if (_lastResult != null &&
                          opt.id == _lastResult!.correctOptionId)
                        const Icon(
                          Icons.check_circle,
                          color: AppTheme.greenColor,
                        )
                      else if (_lastResult != null &&
                          opt.id == _selectedOptionId &&
                          !_lastResult!.isCorrect)
                        const Icon(Icons.cancel, color: AppTheme.redColor),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Feedback & Explanation Banner
          if (_lastResult != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _lastResult!.isCorrect
                    ? AppTheme.greenColor.withValues(alpha: 0.1)
                    : AppTheme.amberColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _lastResult!.isCorrect
                      ? AppTheme.greenColor
                      : AppTheme.amberColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _lastResult!.isCorrect
                            ? Icons.check_circle
                            : Icons.info_outline,
                        color: _lastResult!.isCorrect
                            ? AppTheme.greenColor
                            : AppTheme.amberColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _lastResult!.isCorrect
                            ? 'Chính xác!'
                            : 'Giải thích đáp án:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _lastResult!.isCorrect
                              ? AppTheme.greenColor
                              : Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _lastResult!.explanation,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text(
                _currentIndex + 1 >= _questions.length
                    ? 'Xem kết quả'
                    : 'Câu tiếp theo',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
