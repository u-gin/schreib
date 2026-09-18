/// The time of day a writing reminder fires, in the author's own calendar.
///
/// Deliberately free of Flutter types so the scheduling arithmetic -- which
/// is where the awkward cases live -- can be tested without a widget binding.
class ReminderTime {
  const ReminderTime(this.hour, this.minute)
    : assert(hour >= 0 && hour < 24, 'hour must be 0..23'),
      assert(minute >= 0 && minute < 60, 'minute must be 0..59');

  /// Evening, when the day is nearly over but there is still time to write.
  static const ReminderTime defaultTime = ReminderTime(20, 0);

  final int hour;
  final int minute;

  /// The next time this reminder is due after [after].
  ///
  /// Today if that has not passed yet, tomorrow otherwise. A reminder due
  /// exactly now belongs to tomorrow: the notification for this moment has
  /// already been and gone.
  DateTime nextOccurrence({required DateTime after}) {
    final today = DateTime(after.year, after.month, after.day, hour, minute);
    if (today.isAfter(after)) return today;

    // Day + 1 rather than a 24 hour offset: DateTime normalises the overflow
    // across month and year ends, and keeps the wall-clock time fixed when a
    // daylight-saving shift makes the day 23 or 25 hours long.
    return DateTime(after.year, after.month, after.day + 1, hour, minute);
  }

  String format24h() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      other is ReminderTime && other.hour == hour && other.minute == minute;

  @override
  int get hashCode => Object.hash(hour, minute);

  @override
  String toString() => 'ReminderTime(${format24h()})';
}
