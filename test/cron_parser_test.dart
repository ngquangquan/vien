import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vien/core/notifications/cron_parser.dart';
import 'package:vien/core/utils/responsive.dart';

void main() {
  group('CronParser tests', () {
    test('Validates and parses standard 5-field expressions', () {
      expect(CronParser.validate('0 8 * * *'), isNull);
      expect(CronParser.validate('0 8,14,20 * * *'), isNull);
      expect(CronParser.validate('0 8-22/2 * * *'), isNull);
      expect(CronParser.validate('*/30 8-20 * * 1-5'), isNull);
      expect(CronParser.validate('*/15 7-21 * * *'), isNull);
      expect(CronParser.validate('0 20 * * 1,3,5'), isNull);
      expect(CronParser.validate('30 19 * * 2,4,6'), isNull);

      // Invalid expressions
      expect(CronParser.validate('0 8 * *'), isNotNull); // Only 4 fields
      expect(CronParser.validate('65 8 * * *'), isNotNull); // 65 minute invalid
      expect(CronParser.validate('0 25 * * *'), isNotNull); // 25 hour invalid
      expect(CronParser.validate('0 8 32 * *'), isNotNull); // 32 day of month invalid
      expect(CronParser.validate('0 8 * 13 *'), isNotNull); // 13 month invalid
      expect(CronParser.validate('0 8 * * 8'), isNotNull); // 8 day of week invalid
    });

    test('Translates into Vietnamese description', () {
      final descDaily = CronParser.toVietnamese('0 8 * * *');
      expect(descDaily.contains('Hàng ngày'), isTrue);
      expect(descDaily.contains('08:00'), isTrue);

      final descStep = CronParser.toVietnamese('0 8-22/2 * * *');
      expect(descStep.contains('Hàng ngày'), isTrue);
      expect(descStep.contains('2 giờ'), isTrue);

      final descWeekdays = CronParser.toVietnamese('0 9 * * 1-5');
      expect(descWeekdays.contains('T2 - T6'), isTrue);
      expect(descWeekdays.contains('09:00'), isTrue);

      final descWeekend = CronParser.toVietnamese('0 10 * * 6,7');
      expect(descWeekend.contains('Cuối tuần'), isTrue);
      expect(descWeekend.contains('10:00'), isTrue);

      final descCustomDow = CronParser.toVietnamese('0 20 * * 1,3,5');
      expect(descCustomDow.contains('Thứ 2, Thứ 4, Thứ 6'), isTrue);
    });

    test('Generates cron expressions correctly', () {
      final fixed = CronParser.buildFixedTimesCron([
        const TimeOfDay(hour: 8, minute: 0),
        const TimeOfDay(hour: 20, minute: 0),
      ]);
      expect(fixed, '0 8,20 * * *');

      final interval = CronParser.buildIntervalCron(
        intervalMinutes: 120,
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
      );
      expect(interval, '0 8-22/2 * * *');

      final subHour = CronParser.buildIntervalCron(
        intervalMinutes: 30,
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 20, minute: 0),
        weekdays: [1, 2, 3, 4, 5],
      );
      expect(subHour, '*/30 8-20 * * 1-5');

      final fifteenMins = CronParser.buildIntervalCron(
        intervalMinutes: 15,
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 21, minute: 0),
      );
      expect(fifteenMins, '*/15 8-21 * * *');
    });

    test('Matches DateTime correctly', () {
      final parser = CronParser.parse('0 8 * * 1-5');
      // Monday 8:00 AM
      final mon8am = DateTime(2026, 10, 19, 8, 0); // Oct 19, 2026 is Monday
      expect(parser.matches(mon8am), isTrue);

      // Monday 8:01 AM (should not match)
      final mon801am = DateTime(2026, 10, 19, 8, 1);
      expect(parser.matches(mon801am), isFalse);

      // Sunday 8:00 AM (should not match 1-5)
      final sun8am = DateTime(2026, 10, 25, 8, 0);
      expect(parser.matches(sun8am), isFalse);
    });

    test('Calculates next occurrences correctly', () {
      final parser = CronParser.parse('0 8 * * *');
      final base = DateTime(2026, 10, 19, 7, 0); // 7:00 AM
      final occurrences = parser.getNextOccurrences(from: base, count: 2);
      expect(occurrences.length, 2);
      expect(occurrences[0], DateTime(2026, 10, 19, 8, 0));
      expect(occurrences[1], DateTime(2026, 10, 20, 8, 0));
    });
  });

  group('Responsive utility tests', () {
    test('Calculates dynamic columns correctly', () {
      expect(Responsive.dynamicColumns(320), 1);
      expect(Responsive.dynamicColumns(600), 2);
      expect(Responsive.dynamicColumns(900), 3);
      expect(Responsive.dynamicColumns(1200), 4);
      expect(Responsive.dynamicColumns(2000, maxColumns: 4), 4);
    });
  });
}
