import 'package:schreib/models/reminder_time.dart';
import 'package:schreib/notifications/reminder_scheduler.dart';

/// In-memory [ReminderScheduler] for tests.
class FakeReminderScheduler implements ReminderScheduler {
  FakeReminderScheduler({this.permissionGranted = true, DateTime? now})
    : _now = now ?? DateTime(2026, 9, 18, 10);

  bool permissionGranted;
  final DateTime _now;

  int permissionRequests = 0;
  int cancelCount = 0;
  final List<ReminderTime> scheduled = [];

  ReminderTime? get active => scheduled.isEmpty ? null : scheduled.last;

  bool _isScheduled = false;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return permissionGranted;
  }

  @override
  Future<bool> hasPermission() async => permissionGranted;

  @override
  Future<void> scheduleDaily(ReminderTime time) async {
    scheduled.add(time);
    _isScheduled = true;
  }

  @override
  Future<void> cancel() async {
    cancelCount++;
    _isScheduled = false;
  }

  @override
  Future<DateTime?> nextReminder() async =>
      _isScheduled ? active!.nextOccurrence(after: _now) : null;
}
