import 'package:flutter/material.dart';

/// A pure Dart parser, validator, generator, and Vietnamese translator
/// for 5-field standard Cron expressions:
/// `[minute] [hour] [dayOfMonth] [month] [dayOfWeek]`
class CronParser {
  final String rawExpression;
  final Set<int> minutes;
  final Set<int> hours;
  final Set<int> daysOfMonth;
  final Set<int> months;
  final Set<int> daysOfWeek; // 1 = Monday ... 7 = Sunday (0 also treated as 7/Sunday)

  const CronParser._({
    required this.rawExpression,
    required this.minutes,
    required this.hours,
    required this.daysOfMonth,
    required this.months,
    required this.daysOfWeek,
  });

  /// Parse a 5-part cron expression. Throws [FormatException] if invalid.
  factory CronParser.parse(String expression) {
    final trimmed = expression.trim().replaceAll(RegExp(r'\s+'), ' ');
    final parts = trimmed.split(' ');
    if (parts.length != 5) {
      throw FormatException(
        'Biểu thức Cron phải có đúng 5 trường cách nhau bằng dấu cách: '
        '[phút] [giờ] [ngày trong tháng] [tháng] [thứ trong tuần]. '
        'Hiện có ${parts.length} trường.',
      );
    }

    final minutes = _parseField(parts[0], 0, 59, 'Phút');
    final hours = _parseField(parts[1], 0, 23, 'Giờ');
    final daysOfMonth = _parseField(parts[2], 1, 31, 'Ngày trong tháng');
    final months = _parseField(parts[3], 1, 12, 'Tháng');
    final rawDow = _parseField(parts[4], 0, 7, 'Thứ trong tuần');
    // Normalize Sunday (0 -> 7)
    final daysOfWeek = <int>{};
    for (final d in rawDow) {
      daysOfWeek.add(d == 0 ? 7 : d);
    }

    return CronParser._(
      rawExpression: trimmed,
      minutes: minutes,
      hours: hours,
      daysOfMonth: daysOfMonth,
      months: months,
      daysOfWeek: daysOfWeek,
    );
  }

  /// Try to parse without throwing. Returns null if invalid.
  static CronParser? tryParse(String expression) {
    try {
      return CronParser.parse(expression);
    } catch (_) {
      return null;
    }
  }

  /// Validate expression, returns null if valid, or an error message string.
  static String? validate(String expression) {
    try {
      CronParser.parse(expression);
      return null;
    } catch (e) {
      if (e is FormatException) return e.message;
      return e.toString();
    }
  }

  /// Check if a given DateTime matches this cron schedule
  bool matches(DateTime dt) {
    if (!months.contains(dt.month)) return false;
    if (!daysOfMonth.contains(dt.day)) return false;
    // dt.weekday in Dart is 1 (Mon) to 7 (Sun)
    if (!daysOfWeek.contains(dt.weekday)) return false;
    if (!hours.contains(dt.hour)) return false;
    if (!minutes.contains(dt.minute)) return false;
    return true;
  }

  /// Find the next occurrences of this cron expression starting from [from] (default now).
  List<DateTime> getNextOccurrences({DateTime? from, int count = 5}) {
    final results = <DateTime>[];
    DateTime cursor = from ?? DateTime.now();

    // Advance to the start of the next minute
    cursor = DateTime(
      cursor.year,
      cursor.month,
      cursor.day,
      cursor.hour,
      cursor.minute,
    ).add(const Duration(minutes: 1));

    // Search up to 365 days ahead
    final limit = cursor.add(const Duration(days: 366));

    while (cursor.isBefore(limit) && results.length < count) {
      if (!months.contains(cursor.month)) {
        // Jump to next month
        cursor = DateTime(cursor.year, cursor.month + 1, 1, 0, 0);
        continue;
      }
      if (!daysOfMonth.contains(cursor.day) || !daysOfWeek.contains(cursor.weekday)) {
        // Jump to next day
        cursor = DateTime(cursor.year, cursor.month, cursor.day + 1, 0, 0);
        continue;
      }
      if (!hours.contains(cursor.hour)) {
        // Jump to next hour
        cursor = DateTime(cursor.year, cursor.month, cursor.day, cursor.hour + 1, 0);
        continue;
      }
      if (!minutes.contains(cursor.minute)) {
        // Next minute
        cursor = cursor.add(const Duration(minutes: 1));
        continue;
      }

      results.add(cursor);
      cursor = cursor.add(const Duration(minutes: 1));
    }

    return results;
  }

  /// Helper to parse a single field (supports *, */n, a-b, a,b,c, a-b/n)
  static Set<int> _parseField(String raw, int min, int max, String fieldName) {
    final values = <int>{};
    final parts = raw.split(',');

    for (final part in parts) {
      final p = part.trim();
      if (p.isEmpty) {
        throw FormatException('$fieldName không được chứa phần tử trống');
      }

      if (p == '*') {
        for (int i = min; i <= max; i++) {
          values.add(i);
        }
      } else if (p.startsWith('*/')) {
        final step = int.tryParse(p.substring(2));
        if (step == null || step <= 0) {
          throw FormatException('Bước nhảy "$p" của $fieldName không hợp lệ');
        }
        for (int i = min; i <= max; i += step) {
          values.add(i);
        }
      } else if (p.contains('/')) {
        final slashParts = p.split('/');
        if (slashParts.length != 2) {
          throw FormatException('Định dạng "$p" của $fieldName không hợp lệ');
        }
        final step = int.tryParse(slashParts[1]);
        if (step == null || step <= 0) {
          throw FormatException('Bước nhảy "${slashParts[1]}" của $fieldName không hợp lệ');
        }
        final rangeSet = _parseRangeOrSingle(slashParts[0], min, max, fieldName);
        final sorted = rangeSet.toList()..sort();
        if (sorted.isEmpty) continue;
        final start = sorted.first;
        final end = sorted.last;
        for (int i = start; i <= end; i += step) {
          if (rangeSet.contains(i)) values.add(i);
        }
      } else {
        values.addAll(_parseRangeOrSingle(p, min, max, fieldName));
      }
    }

    if (values.isEmpty) {
      throw FormatException('$fieldName không có giá trị nào hợp lệ');
    }

    return values;
  }

  static Set<int> _parseRangeOrSingle(String p, int min, int max, String fieldName) {
    final values = <int>{};
    if (p.contains('-')) {
      final bounds = p.split('-');
      if (bounds.length != 2) {
        throw FormatException('Dải giá trị "$p" của $fieldName không hợp lệ');
      }
      final start = int.tryParse(bounds[0]);
      final end = int.tryParse(bounds[1]);
      if (start == null || end == null || start > end || start < min || end > max) {
        throw FormatException('Dải giá trị "$p" của $fieldName vượt quá [$min, $max]');
      }
      for (int i = start; i <= end; i++) {
        values.add(i);
      }
    } else {
      final val = int.tryParse(p);
      if (val == null || val < min || val > max) {
        throw FormatException('Giá trị "$p" của $fieldName phải nằm trong khoảng $min - $max');
      }
      values.add(val);
    }
    return values;
  }

  /// Translates a Cron expression into clear, readable Vietnamese text.
  static String toVietnamese(String expression) {
    final parser = tryParse(expression);
    if (parser == null) {
      final err = validate(expression);
      return err ?? 'Biểu thức Cron không hợp lệ';
    }

    // Days of week description
    String dowText = '';
    if (parser.daysOfWeek.length == 7) {
      dowText = 'Hàng ngày';
    } else if (parser.daysOfWeek.length == 5 &&
        [1, 2, 3, 4, 5].every((d) => parser.daysOfWeek.contains(d))) {
      dowText = 'Các ngày trong tuần (T2 - T6)';
    } else if (parser.daysOfWeek.length == 2 &&
        [6, 7].every((d) => parser.daysOfWeek.contains(d))) {
      dowText = 'Cuối tuần (T7 & CN)';
    } else {
      final names = {
        1: 'Thứ 2',
        2: 'Thứ 3',
        3: 'Thứ 4',
        4: 'Thứ 5',
        5: 'Thứ 6',
        6: 'Thứ 7',
        7: 'Chủ nhật',
      };
      final sortedDow = parser.daysOfWeek.toList()..sort();
      dowText = sortedDow.map((d) => names[d]).join(', ');
    }

    // Time description
    String timeText = '';
    final sortedMins = parser.minutes.toList()..sort();
    final sortedHours = parser.hours.toList()..sort();

    // Check if it's every N minutes
    if (expression.startsWith('*/') || expression.split(' ')[0].startsWith('*/')) {
      final minPart = expression.split(' ')[0];
      final step = minPart.substring(2);
      if (sortedHours.length == 24) {
        timeText = 'Mỗi $step phút';
      } else {
        final startH = sortedHours.first.toString().padLeft(2, '0');
        final endH = sortedHours.last.toString().padLeft(2, '0');
        timeText = 'Mỗi $step phút (từ $startH:00 đến $endH:59)';
      }
    } else if (sortedMins.length == 1) {
      final minStr = sortedMins.first.toString().padLeft(2, '0');
      if (sortedHours.length == 24) {
        timeText = 'Mỗi giờ một lần tại phút $minStr';
      } else if (sortedHours.length == 1) {
        final hourStr = sortedHours.first.toString().padLeft(2, '0');
        timeText = 'Lúc $hourStr:$minStr';
      } else {
        // Check if hours follow a regular step
        bool isStep = false;
        int diff = 0;
        if (sortedHours.length > 2) {
          diff = sortedHours[1] - sortedHours[0];
          isStep = true;
          for (int i = 2; i < sortedHours.length; i++) {
            if (sortedHours[i] - sortedHours[i - 1] != diff) {
              isStep = false;
              break;
            }
          }
        }
        if (isStep && diff > 1) {
          final startH = sortedHours.first.toString().padLeft(2, '0');
          final endH = sortedHours.last.toString().padLeft(2, '0');
          timeText = 'Mỗi $diff giờ một lần từ $startH:$minStr đến $endH:$minStr';
        } else {
          final timeList = sortedHours
              .map((h) => '${h.toString().padLeft(2, '0')}:$minStr')
              .join(', ');
          timeText = 'Lúc $timeList';
        }
      }
    } else {
      timeText = '${sortedHours.length} mốc giờ (${sortedHours.first}h - ${sortedHours.last}h)';
    }

    return '$dowText: $timeText';
  }

  /// Builds a standard 5-part cron expression for fixed times of day.
  /// Example: [TimeOfDay(8, 0), TimeOfDay(20, 0)] -> `0 8,20 * * *`
  static String buildFixedTimesCron(
    List<TimeOfDay> times, {
    List<int>? weekdays,
  }) {
    if (times.isEmpty) {
      times = [const TimeOfDay(hour: 8, minute: 0)];
    }

    final dowPart = _buildWeekdaysPart(weekdays);

    // If all times share the same minute
    final minutes = times.map((t) => t.minute).toSet().toList()..sort();
    final hours = times.map((t) => t.hour).toSet().toList()..sort();

    if (minutes.length == 1) {
      return '${minutes.first} ${hours.join(',')} * * $dowPart';
    }

    // If multiple different minutes exist, list the primary or first
    return '${times.first.minute} ${hours.join(',')} * * $dowPart';
  }

  /// Builds a standard cron expression for an interval within a time window.
  /// Example: interval = 120 mins (2h), start = 8:00, end = 22:00 -> `0 8-22/2 * * *`
  static String buildIntervalCron({
    required int intervalMinutes,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    List<int>? weekdays,
  }) {
    final dowPart = _buildWeekdaysPart(weekdays);

    if (intervalMinutes < 60) {
      // Sub-hour intervals (e.g. 15, 30 mins)
      final step = intervalMinutes;
      final startH = startTime.hour;
      final endH = endTime.hour;
      if (startH == 0 && endH == 23) {
        return '*/$step * * * $dowPart';
      }
      return '*/$step $startH-$endH * * $dowPart';
    } else {
      // Hourly intervals (e.g. 1, 2, 3, 4 hours)
      final hourStep = intervalMinutes ~/ 60;
      final minute = startTime.minute;
      final startH = startTime.hour;
      final endH = endTime.hour;

      if (hourStep == 1) {
        if (startH == 0 && endH == 23) {
          return '$minute * * * $dowPart';
        }
        return '$minute $startH-$endH * * $dowPart';
      } else {
        return '$minute $startH-$endH/$hourStep * * $dowPart';
      }
    }
  }

  static String _buildWeekdaysPart(List<int>? weekdays) {
    if (weekdays == null || weekdays.isEmpty || weekdays.length == 7) {
      return '*';
    }
    final sorted = weekdays.toSet().toList()..sort();
    if (sorted.length == 5 && [1, 2, 3, 4, 5].every(sorted.contains)) {
      return '1-5';
    }
    if (sorted.length == 2 && [6, 7].every(sorted.contains)) {
      return '6,7';
    }
    return sorted.join(',');
  }
}
