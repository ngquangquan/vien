import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:math';

import 'package:drift/drift.dart';

import '../database/app_database.dart';
import 'cron_parser.dart';

class _DueVocabulary {
  final String headwordId;
  final String spelling;
  final String? ipa;
  final String meaning;

  const _DueVocabulary({
    required this.headwordId,
    required this.spelling,
    required this.ipa,
    required this.meaning,
  });

  String buildNotificationTitle() {
    final pronunciation = ipa?.trim();
    if (pronunciation == null || pronunciation.isEmpty) {
      return spelling;
    }
    final displayIpa =
        pronunciation.startsWith('/') && pronunciation.endsWith('/')
        ? pronunciation
        : '/$pronunciation/';
    return '$spelling  $displayIpa';
  }

  String buildNotificationBody() {
    return meaning.trim();
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  final AppDatabase? db;

  NotificationService({this.db});

  Future<void> initialize({
    void Function(String? payload)? onSelectNotification,
  }) async {
    if (_isInitialized) return;

    try {
      tz.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      const windowsSettings = WindowsInitializationSettings(
        appName: 'Vien',
        appUserModelId: 'com.vien.app',
        guid: '3c19d4b0-3118-4b71-9c6f-6821d3f9b231',
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
        windows: windowsSettings,
      );

      await _plugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (response) {
          if (onSelectNotification != null) {
            onSelectNotification(response.payload);
          }
        },
      );

      _isInitialized = true;
    } catch (e, st) {
      debugPrint('NotificationService initialize failed: $e\n$st');
    }
  }

  Future<String?> getLaunchPayload() async {
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp != true) return null;
    return launchDetails?.notificationResponse?.payload;
  }

  Future<bool> requestPermission() async {
    try {
      final androidImpl = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidImpl != null) {
        final granted = await androidImpl.requestNotificationsPermission();
        return granted ?? false;
      }

      final iosImpl = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      if (iosImpl != null) {
        final granted = await iosImpl.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    } catch (e) {
      debugPrint('NotificationService requestPermission failed: $e');
    }

    return true;
  }

  NotificationDetails _buildNotificationDetails({
    String channelId = 'study_reminder_channel',
    String channelName = 'Nhắc nhở học tập',
    String channelDescription = 'Thông báo lịch học từ vựng và ôn tập',
    String? bigText,
  }) {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigText == null
          ? null
          : BigTextStyleInformation(bigText),
    );

    return NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      windows: const WindowsNotificationDetails(),
    );
  }

  /// Sends an immediate test notification for the user to verify permissions and appearance
  Future<void> sendTestNotification({
    String title = 'Nhắc nhở học tập (Thử nghiệm)',
    String body = 'Chúc bạn học từ vựng hiệu quả hôm nay! Hệ thống nhắc nhở hoạt động bình thường.',
  }) async {
    try {
      final vocabulary = await _getRandomDueVocabulary();
      final notificationTitle = vocabulary == null
          ? title
          : vocabulary.buildNotificationTitle();
      final notificationBody = vocabulary == null
          ? body
          : vocabulary.buildNotificationBody();
      final payload = vocabulary == null
          ? '/review'
          : 'vocabulary:${vocabulary.headwordId}';
      await _plugin.show(
        id: 9999,
        title: notificationTitle,
        body: notificationBody,
        notificationDetails: _buildNotificationDetails(
          bigText: notificationBody,
        ),
        payload: payload,
      );
    } catch (e) {
      debugPrint('NotificationService sendTestNotification failed: $e');
    }
  }

  Future<List<_DueVocabulary>> _getDueVocabularies({int limit = 50}) async {
    final database = db;
    if (database == null) return const [];

    try {
      final now = DateTime.now().millisecondsSinceEpoch;

      // 1. First priority: items due in learning_progress
      final lpQuery =
          database.select(database.learningProgress).join([
              innerJoin(
                database.senses,
                database.senses.id.equalsExp(
                  database.learningProgress.studyItemId,
                ),
              ),
              innerJoin(
                database.headwords,
                database.headwords.id.equalsExp(database.senses.headwordId),
              ),
            ])
            ..where(
              (database.learningProgress.dueAtMs.isNull() |
                      database.learningProgress.dueAtMs.isSmallerOrEqualValue(
                        now,
                      )) &
                  database.senses.isActive.equals(1) &
                  database.headwords.isArchived.equals(0),
            )
            ..limit(limit);

      final rows = await lpQuery.get();
      final candidates =
          <({String headwordId, String spelling, String meaning})>[];

      for (final row in rows) {
        final sense = row.readTable(database.senses);
        final headword = row.readTable(database.headwords);
        final meaning = (sense.meaningVi?.trim().isNotEmpty == true)
            ? sense.meaningVi!.trim()
            : sense.definitionEn.trim();
        candidates.add((
          headwordId: headword.id,
          spelling: headword.spelling,
          meaning: meaning,
        ));
      }

      // 2. Fallback: if no items are due yet in learning_progress, pick active words
      if (candidates.isEmpty) {
        final fallbackQuery =
            database.select(database.senses).join([
                innerJoin(
                  database.headwords,
                  database.headwords.id.equalsExp(database.senses.headwordId),
                ),
              ])
              ..where(
                database.senses.isActive.equals(1) &
                    database.headwords.isArchived.equals(0),
              )
              ..limit(limit);

        final fallbackRows = await fallbackQuery.get();
        for (final row in fallbackRows) {
          final sense = row.readTable(database.senses);
          final headword = row.readTable(database.headwords);
          final meaning = (sense.meaningVi?.trim().isNotEmpty == true)
              ? sense.meaningVi!.trim()
              : sense.definitionEn.trim();
          candidates.add((
            headwordId: headword.id,
            spelling: headword.spelling,
            meaning: meaning,
          ));
        }
      }

      if (candidates.isEmpty) return const [];

      // Bulk fetch pronunciations for candidates
      final headwordIds = candidates.map((c) => c.headwordId).toSet().toList();
      final pronRows = await (database.select(
        database.pronunciations,
      )..where((p) => p.headwordId.isIn(headwordIds))).get();

      final pronMap = <String, String?>{};
      for (final p in pronRows) {
        final hwId = p.headwordId;
        if (hwId == null || p.ipa == null || p.ipa!.trim().isEmpty) continue;
        final current = pronMap[hwId];
        if (current == null) {
          pronMap[hwId] = p.ipa;
        } else if (p.accent.toLowerCase() == 'uk' ||
            p.accent.toLowerCase() == 'gb') {
          pronMap[hwId] = p.ipa;
        }
      }

      return candidates.map((c) {
        return _DueVocabulary(
          headwordId: c.headwordId,
          spelling: c.spelling,
          ipa: pronMap[c.headwordId],
          meaning: c.meaning,
        );
      }).toList();
    } catch (e, st) {
      debugPrint('NotificationService _getDueVocabularies failed: $e\n$st');
      return const [];
    }
  }

  Future<_DueVocabulary?> _getRandomDueVocabulary() async {
    final list = await _getDueVocabularies(limit: 30);
    if (list.isEmpty) return null;
    return list[Random().nextInt(list.length)];
  }

  /// Schedules notifications based on a standard Cron expression or multiple upcoming slots
  Future<int> scheduleFromCron({
    required String cronExpression,
    required String title,
    required String body,
    int occurrencesToSchedule = 25,
    String? payload,
  }) async {
    try {
      final parser = CronParser.tryParse(cronExpression);
      if (parser == null) {
        debugPrint('Invalid cron expression for scheduling: $cronExpression');
        return 0;
      }

      // Cancel existing study reminders in slot range (100 to 199) in parallel
      try {
        final pending = await _plugin.pendingNotificationRequests();
        final reminderIds = pending
            .where((p) => p.id >= 100 && p.id < 200)
            .map((p) => p.id)
            .toSet();
        if (reminderIds.isNotEmpty) {
          await Future.wait(reminderIds.map((id) => _plugin.cancel(id: id)));
        }
      } catch (e) {
        await Future.wait([
          for (int i = 100; i < 200; i++) _plugin.cancel(id: i),
        ]);
      }

      final upcoming = parser.getNextOccurrences(
        from: DateTime.now(),
        count: occurrencesToSchedule,
      );

      // Pre-fetch vocabularies once in a single efficient query
      final dueVocabs = (await _getDueVocabularies(
        limit: occurrencesToSchedule * 2,
      ))..shuffle();

      int scheduledCount = 0;
      for (int i = 0; i < upcoming.length; i++) {
        final targetDt = upcoming[i];
        final tzTarget = tz.TZDateTime(
          tz.local,
          targetDt.year,
          targetDt.month,
          targetDt.day,
          targetDt.hour,
          targetDt.minute,
        );
        final notifId = 100 + i;
        final vocabulary = dueVocabs.isNotEmpty
            ? dueVocabs[i % dueVocabs.length]
            : null;
        final notificationTitle = vocabulary == null
            ? title
            : vocabulary.buildNotificationTitle();
        final notificationBody = vocabulary == null
            ? body
            : vocabulary.buildNotificationBody();
        final notificationPayload = vocabulary == null
            ? payload
            : 'vocabulary:${vocabulary.headwordId}';

        try {
          await _plugin.zonedSchedule(
            id: notifId,
            title: notificationTitle,
            body: notificationBody,
            scheduledDate: tzTarget,
            notificationDetails: _buildNotificationDetails(
              bigText: notificationBody,
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            payload: notificationPayload,
          );
          scheduledCount++;
        } catch (e) {
          debugPrint('Failed to schedule item $i at $targetDt: $e');
        }
      }

      debugPrint(
        'Successfully scheduled $scheduledCount notifications for cron $cronExpression',
      );
      return scheduledCount;
    } catch (e, st) {
      debugPrint('NotificationService scheduleFromCron failed: $e\n$st');
      return 0;
    }
  }

  Future<void> scheduleDailyReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    try {
      final now = DateTime.now();
      var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      final tzTarget = tz.TZDateTime.from(scheduledDate, tz.local);

      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tzTarget,
        notificationDetails: _buildNotificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
    } catch (e) {
      debugPrint('NotificationService scheduleDailyReminder fallback: $e');
      // Fallback to show if zonedSchedule fails on certain environments (e.g. desktop)
      await _plugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: _buildNotificationDetails(),
        payload: payload,
      );
    }
  }

  Future<void> cancelReminder(int id) async {
    try {
      await _plugin.cancel(id: id);
    } catch (e) {
      debugPrint('NotificationService cancelReminder failed: $e');
    }
  }

  Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (e) {
      debugPrint('NotificationService cancelAll failed: $e');
    }
  }
}
