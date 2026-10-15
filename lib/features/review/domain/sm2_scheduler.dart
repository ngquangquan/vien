import 'dart:math';

class Sm2Result {
  final String status;
  final int repetitionCount;
  final double intervalDays;
  final double easeFactor;
  final int lapses;
  final int dueAtMs;
  final int totalCorrect;
  final int totalIncorrect;

  const Sm2Result({
    required this.status,
    required this.repetitionCount,
    required this.intervalDays,
    required this.easeFactor,
    required this.lapses,
    required this.dueAtMs,
    required this.totalCorrect,
    required this.totalIncorrect,
  });
}

class Sm2Scheduler {
  static const double minEaseFactor = 1.3;
  static const int msPerDay = 86400000;

  static Sm2Result calculateNextSchedule({
    required int quality, // 0 to 5
    required int currentRepetition,
    required double currentIntervalDays,
    required double currentEaseFactor,
    required int currentLapses,
    required int currentTotalCorrect,
    required int currentTotalIncorrect,
    required int nowMs,
  }) {
    final clampedQuality = quality.clamp(0, 5);
    final isSuccess = clampedQuality >= 3;

    int nextRepetition;
    double nextInterval;
    int nextLapses = currentLapses;
    int nextCorrect = currentTotalCorrect;
    int nextIncorrect = currentTotalIncorrect;

    if (!isSuccess) {
      nextRepetition = 0;
      nextInterval = 1.0;
      nextLapses += 1;
      nextIncorrect += 1;
    } else {
      nextCorrect += 1;
      if (currentRepetition == 0) {
        nextInterval = 1.0;
        nextRepetition = 1;
      } else if (currentRepetition == 1) {
        nextInterval = 6.0;
        nextRepetition = 2;
      } else {
        nextInterval = max(
          1.0,
          (currentIntervalDays * currentEaseFactor).roundToDouble(),
        );
        nextRepetition = currentRepetition + 1;
      }
    }

    // Update Ease Factor (EF)
    // EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    final qDiff = 5 - clampedQuality;
    final deltaEf = 0.1 - qDiff * (0.08 + qDiff * 0.02);
    final nextEf = max(minEaseFactor, currentEaseFactor + deltaEf);

    String nextStatus;
    if (nextRepetition >= 5) {
      nextStatus = 'mastered';
    } else if (nextRepetition > 0) {
      nextStatus = 'review';
    } else {
      nextStatus = 'learning';
    }

    final nextDueMs = nowMs + (nextInterval * msPerDay).round();

    return Sm2Result(
      status: nextStatus,
      repetitionCount: nextRepetition,
      intervalDays: nextInterval,
      easeFactor: nextEf,
      lapses: nextLapses,
      dueAtMs: nextDueMs,
      totalCorrect: nextCorrect,
      totalIncorrect: nextIncorrect,
    );
  }

  static double calculatePriorityScore({
    required int? dueAtMs,
    required int totalCorrect,
    required int totalIncorrect,
    required int lapses,
    required int nowMs,
    bool isUserPreference = false,
  }) {
    double overdueFactor = 0.0;
    if (dueAtMs == null) {
      overdueFactor = 2.0; // New items have high priority
    } else if (nowMs >= dueAtMs) {
      final daysOverdue = (nowMs - dueAtMs) / msPerDay;
      overdueFactor = 1.0 + min(5.0, daysOverdue);
    } else {
      overdueFactor = 0.0; // Not due yet
    }

    final totalAttempts = totalCorrect + totalIncorrect;
    final errorRate = totalAttempts == 0
        ? 0.5
        : (totalIncorrect / totalAttempts);
    final lapseCapped = min(5, lapses);
    final preferenceBoost = isUserPreference ? 1.5 : 0.0;

    return overdueFactor +
        (2.0 * errorRate) +
        (0.5 * lapseCapped) +
        preferenceBoost;
  }
}
