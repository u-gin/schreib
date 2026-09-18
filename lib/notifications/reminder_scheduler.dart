import 'package:schreib/models/reminder_time.dart';

/// Schedules the daily nudge to write.
///
/// A habit app lives or dies on this. It is the reason phase 1 targets
/// mobile: web push cannot deliver a reliable daily reminder on iOS.
///
/// An interface for the same reason the entry store has one -- so screens and
/// tests never touch the platform plugin.
abstract interface class ReminderScheduler {
  /// Asks the operating system for permission to post notifications.
  ///
  /// Returns whether it was granted. Must be called from a user action, not
  /// at startup: an unexplained permission dialog on first launch is how an
  /// app gets permanently denied.
  Future<bool> requestPermission();

  /// Whether notifications are currently permitted.
  Future<bool> hasPermission();

  /// Schedules a reminder at [time] every day, replacing any existing one.
  Future<void> scheduleDaily(ReminderTime time);

  /// Removes the reminder.
  Future<void> cancel();

  /// When the reminder will next fire, or null if none is scheduled.
  Future<DateTime?> nextReminder();
}
