import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:schreib/models/reminder_time.dart';
import 'package:schreib/notifications/reminder_scheduler.dart';

/// Device-local reminders. No server involved, which is why phase 1 can ship
/// the whole habit loop without a backend.
class LocalReminderScheduler implements ReminderScheduler {
  LocalReminderScheduler({
    FlutterLocalNotificationsPlugin? plugin,
    DateTime Function()? clock,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
       _now = clock ?? DateTime.now;

  /// Reused so scheduling a new time replaces the old reminder rather than
  /// stacking a second one.
  static const int _notificationId = 1;

  static const AndroidNotificationDetails _android = AndroidNotificationDetails(
    'daily_reminder',
    'Daily writing reminder',
    channelDescription: 'A once-a-day nudge to write today’s entry.',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );

  static const NotificationDetails _details = NotificationDetails(
    android: _android,
    iOS: DarwinNotificationDetails(),
  );

  final FlutterLocalNotificationsPlugin _plugin;
  final DateTime Function() _now;

  bool _initialised = false;

  /// Loads the timezone database and initialises the plugin, once.
  ///
  /// Called lazily from each entry point rather than from `main()`: startup
  /// must not do platform work that can fail, or a failure takes down screens
  /// that have nothing to do with notifications.
  Future<void> _ensureInitialised() async {
    if (_initialised) return;

    tz_data.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation((await FlutterTimezone.getLocalTimezone()).identifier),
    );

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          // Asked for explicitly later, from a user action.
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _initialised = true;
  }

  @override
  Future<bool> requestPermission() async {
    await _ensureInitialised();

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }

    final granted = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    return granted ?? false;
  }

  @override
  Future<bool> hasPermission() async {
    await _ensureInitialised();
    final enabled = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.areNotificationsEnabled();
    // iOS reports nothing here; treat unknown as permitted and let the
    // request call settle it.
    return enabled ?? true;
  }

  @override
  Future<void> scheduleDaily(ReminderTime time) async {
    await _ensureInitialised();
    await cancel();

    final next = time.nextOccurrence(after: _now());

    await _plugin.zonedSchedule(
      id: _notificationId,
      title: 'Time to write',
      body: 'One line is enough.',
      scheduledDate: tz.TZDateTime.from(next, tz.local),
      notificationDetails: _details,
      // Inexact on purpose. Exact alarms need a permission Android grants
      // grudgingly and users can revoke, and a writing nudge does not care
      // about a few minutes.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // Repeat daily at this wall-clock time.
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancel() async {
    await _ensureInitialised();
    await _plugin.cancel(id: _notificationId);
  }

  @override
  Future<DateTime?> nextReminder() async {
    await _ensureInitialised();
    final pending = await _plugin.pendingNotificationRequests();
    if (!pending.any((r) => r.id == _notificationId)) return null;

    // The platform does not report the fire date, so it is recomputed from
    // the stored time by the caller. Presence is what this answers.
    return _now();
  }
}
