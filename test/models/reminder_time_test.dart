import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/models/reminder_time.dart';

void main() {
  group('nextOccurrence', () {
    test('is later today when the time has not passed', () {
      final next = const ReminderTime(
        20,
        0,
      ).nextOccurrence(after: DateTime(2026, 9, 18, 14, 30));
      expect(next, DateTime(2026, 9, 18, 20, 0));
    });

    test('is tomorrow when the time has already passed', () {
      final next = const ReminderTime(
        20,
        0,
      ).nextOccurrence(after: DateTime(2026, 9, 18, 21, 15));
      expect(next, DateTime(2026, 9, 19, 20, 0));
    });

    test('is tomorrow when the time is exactly now', () {
      // The notification for this instant has already been and gone.
      final next = const ReminderTime(
        20,
        0,
      ).nextOccurrence(after: DateTime(2026, 9, 18, 20, 0));
      expect(next, DateTime(2026, 9, 19, 20, 0));
    });

    test('rolls over a month end', () {
      final next = const ReminderTime(
        7,
        30,
      ).nextOccurrence(after: DateTime(2026, 9, 30, 9, 0));
      expect(next, DateTime(2026, 10, 1, 7, 30));
    });

    test('rolls over a year end', () {
      final next = const ReminderTime(
        7,
        30,
      ).nextOccurrence(after: DateTime(2026, 12, 31, 9, 0));
      expect(next, DateTime(2027, 1, 1, 7, 30));
    });

    test('rolls over a leap day', () {
      final next = const ReminderTime(
        6,
        0,
      ).nextOccurrence(after: DateTime(2028, 2, 28, 8, 0));
      expect(next, DateTime(2028, 2, 29, 6, 0));
    });

    test('keeps the wall-clock time across a daylight-saving shift', () {
      // Adding a day rather than 24 hours is what makes this hold: the day
      // itself may be 23 or 25 hours long, but 20:00 stays 20:00.
      final next = const ReminderTime(
        20,
        0,
      ).nextOccurrence(after: DateTime(2026, 10, 24, 22, 0));
      expect(next.hour, 20);
      expect(next.minute, 0);
      expect(next.day, 25);
    });

    test('handles midnight', () {
      final next = const ReminderTime(
        0,
        0,
      ).nextOccurrence(after: DateTime(2026, 9, 18, 23, 59));
      expect(next, DateTime(2026, 9, 19, 0, 0));
    });
  });

  group('validation and formatting', () {
    test('rejects an impossible time', () {
      expect(() => ReminderTime(24, 0), throwsA(isA<AssertionError>()));
      expect(() => ReminderTime(12, 60), throwsA(isA<AssertionError>()));
      expect(() => ReminderTime(-1, 0), throwsA(isA<AssertionError>()));
    });

    test('formats with padding', () {
      expect(const ReminderTime(9, 5).format24h(), '09:05');
      expect(const ReminderTime(20, 0).format24h(), '20:00');
    });

    test('compares by value', () {
      expect(const ReminderTime(20, 0), const ReminderTime(20, 0));
      expect(const ReminderTime(20, 0), isNot(const ReminderTime(20, 1)));
    });

    test('defaults to the evening', () {
      expect(ReminderTime.defaultTime, const ReminderTime(20, 0));
    });
  });
}
