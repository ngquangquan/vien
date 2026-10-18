import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'cron_parser.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  NotificationService();

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
  }) {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
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
      await _plugin.show(
        id: 9999,
        title: title,
        body: body,
        notificationDetails: _buildNotificationDetails(),
        payload: '/review',
      );
    } catch (e) {
      debugPrint('NotificationService sendTestNotification failed: $e');
    }
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

      // First cancel existing study reminders in slot range (100 to 199)
      for (int i = 100; i < 200; i++) {
        await _plugin.cancel(id: i);
      }

      final upcoming = parser.getNextOccurrences(
        from: DateTime.now(),
        count: occurrencesToSchedule,
      );

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

        try {
          await _plugin.zonedSchedule(
            id: notifId,
            title: title,
            body: body,
            scheduledDate: tzTarget,
            notificationDetails: _buildNotificationDetails(),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            payload: payload,
          );
          scheduledCount++;
        } catch (e) {
          debugPrint('Failed to schedule item $i at $targetDt: $e');
        }
      }

      debugPrint('Successfully scheduled $scheduledCount notifications for cron $cronExpression');
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
