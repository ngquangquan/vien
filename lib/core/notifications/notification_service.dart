import 'dart:async';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
  final List<Timer> _desktopTimers = [];

  NotificationService({this.db});

  void _clearDesktopTimers() {
    for (final timer in _desktopTimers) {
      timer.cancel();
    }
    _desktopTimers.clear();
  }

  Future<void> initialize({
    void Function(String? payload)? onSelectNotification,
  }) async {
    if (_isInitialized) return;

    try {
      // tz.local stays UTC on purpose: reminders are one-shot absolute
      // instants (TZDateTime.from below), so the zone does not affect them.
      tz.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings(
        '@drawable/ic_launcher_foreground',
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

      // Create Android Notification Channel with max importance
      final androidImpl = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidImpl != null) {
        await androidImpl.createNotificationChannel(
          const AndroidNotificationChannel(
            'study_reminder_channel',
            'Nhắc nhở học tập',
            description: 'Thông báo lịch học từ vựng và ôn tập',
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
          ),
        );
      }

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
        final areEnabled = await androidImpl.areNotificationsEnabled();
        if (areEnabled == false) {
          final granted = await androidImpl.requestNotificationsPermission();
          return granted ?? false;
        }
        try {
          await androidImpl.requestExactAlarmsPermission();
        } catch (_) {}
        return areEnabled ?? true;
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
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      icon: '@drawable/ic_launcher_foreground',
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
      if (CronParser.validate(cronExpression) != null) {
        debugPrint('Invalid cron expression for scheduling: $cronExpression');
        return 0;
      }

      _clearDesktopTimers();

      // Cancel existing study reminders in slot range (100 to 199) in parallel
      try {
        await Future.wait([
          for (int i = 100; i < 200; i++) _plugin.cancel(id: i),
        ]);
      } catch (e) {
        debugPrint('Cancel reminders failed: $e');
      }

      final upcoming = CronParser.nextOccurrences(
        cronExpression,
        count: occurrencesToSchedule,
      );

      // Pre-fetch vocabularies once in a single efficient query
      final dueVocabs = (await _getDueVocabularies(
        limit: occurrencesToSchedule * 2,
      ))..shuffle();

      int scheduledCount = 0;
      final isDesktop = !kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.windows ||
              defaultTargetPlatform == TargetPlatform.linux ||
              defaultTargetPlatform == TargetPlatform.macOS);

      for (int i = 0; i < upcoming.length; i++) {
        final targetDt = upcoming[i];
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

        if (isDesktop) {
          // On Desktop platforms, zonedSchedule is not supported by plugins. Use in-memory timers.
          final delay = targetDt.difference(DateTime.now());
          if (!delay.isNegative) {
            final timer = Timer(delay, () async {
              try {
                await _plugin.show(
                  id: notifId,
                  title: notificationTitle,
                  body: notificationBody,
                  notificationDetails: _buildNotificationDetails(
                    bigText: notificationBody,
                  ),
                  payload: notificationPayload,
                );
              } catch (e) {
                debugPrint('Desktop scheduled reminder error: $e');
              }
            });
            _desktopTimers.add(timer);
            scheduledCount++;
          }
        } else {
          // On Mobile (Android / iOS): Use zonedSchedule with precise timestamp
          final tzTarget = tz.TZDateTime.from(targetDt, tz.local);

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
            debugPrint(
              'Exact alarm scheduling failed for item $i, retrying with inexact: $e',
            );
            try {
              await _plugin.zonedSchedule(
                id: notifId,
                title: notificationTitle,
                body: notificationBody,
                scheduledDate: tzTarget,
                notificationDetails: _buildNotificationDetails(
                  bigText: notificationBody,
                ),
                androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
                payload: notificationPayload,
              );
              scheduledCount++;
            } catch (e2) {
              debugPrint('Failed to schedule item $i at $targetDt: $e2');
            }
          }
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

  Future<void> cancelAll() async {
    _clearDesktopTimers();
    try {
      await _plugin.cancelAll();
    } catch (e) {
      debugPrint('NotificationService cancelAll failed: $e');
    }
  }
}
