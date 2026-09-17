import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/models/entry.dart';
import 'package:schreib/models/streak.dart';

void main() {
  /// An entry written on [day] of September 2026.
  Entry onSept(int day) => Entry.compose(
    id: 'e$day',
    body: 'An entry written on September $day, padded to length.',
    now: DateTime(2026, 9, day, 21),
  );

  Streak streakOn(int today, List<int> daysWritten) =>
      Streak.from(daysWritten.map(onSept), now: DateTime(2026, 9, today, 22));

  group('empty', () {
    test('no entries means no streak', () {
      final streak = Streak.from(const []);
      expect(streak.current, 0);
      expect(streak.longest, 0);
      expect(streak.totalDays, 0);
      expect(streak.isAlive, isFalse);
      expect(streak.committedToday, isFalse);
    });
  });

  group('consecutive days', () {
    test('counts an unbroken run ending today', () {
      final streak = streakOn(18, [16, 17, 18]);
      expect(streak.current, 3);
      expect(streak.committedToday, isTrue);
    });

    test('a single day written today is a streak of one', () {
      expect(streakOn(18, [18]).current, 1);
    });

    test('totalDays counts distinct days, not entries', () {
      final streak = Streak.from([
        onSept(17),
        onSept(18),
        onSept(18),
      ], now: DateTime(2026, 9, 18, 22));
      expect(streak.totalDays, 2);
    });
  });

  group('today not yet written', () {
    test('an unwritten today does not break the streak', () {
      // The day is not over, so it is not a miss.
      final streak = streakOn(18, [15, 16, 17]);
      expect(streak.current, 3);
      expect(streak.committedToday, isFalse);
      expect(streak.isAlive, isTrue);
    });

    test('yesterday missed but today written keeps the run alive', () {
      final streak = streakOn(18, [15, 16, 18]);
      // The run survives the 17th, but the 17th is not credited as written:
      // three days written is three days written.
      expect(streak.current, 3);
      expect(streak.isAlive, isTrue);
      expect(streak.forgivenDays, contains('2026-09-17'));
    });
  });

  group('grace: one forgiven miss per week', () {
    test('an isolated miss is absorbed', () {
      // Missed the 16th; wrote either side of it. Four written days, and the
      // run reaches back past the gap instead of restarting at it.
      final streak = streakOn(18, [14, 15, 17, 18]);
      expect(streak.current, 4);
      expect(streak.forgivenDays, {'2026-09-16'});
    });

    test('two misses in a row always end the streak', () {
      // Missed the 16th and 17th.
      final streak = streakOn(18, [13, 14, 15, 18]);
      expect(streak.current, 1, reason: 'only today survives');
      expect(streak.forgivenDays, isEmpty);
    });

    test('a second miss inside the same week is not forgiven', () {
      // Missed the 13th and the 16th: eight days apart is too close.
      final streak = streakOn(18, [11, 12, 14, 15, 17, 18]);
      expect(streak.current, 4, reason: 'the 14th and 15th are cut off');
      expect(streak.forgivenDays, {'2026-09-16'});
    });

    test('a second miss outside the window is forgiven again', () {
      // Missed the 17th and the 9th: more than seven days apart.
      final days = [4, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 18];
      final streak = streakOn(18, days);
      expect(streak.current, days.length, reason: 'written days only');
      expect(streak.forgivenDays, {'2026-09-17', '2026-09-09'});
    });

    test('never resets to zero while the run holds', () {
      // The decision: a missed day costs momentum, never everything.
      final streak = streakOn(18, [14, 15, 16, 18]);
      expect(streak.current, greaterThan(0));
    });
  });

  group('stale streaks', () {
    test('a run that ended long ago is not current', () {
      final streak = streakOn(18, [1, 2, 3]);
      expect(streak.current, 0);
      expect(streak.isAlive, isFalse);
      expect(streak.longest, 3, reason: 'but it is still the record');
    });

    test('longest survives a broken current run', () {
      final streak = streakOn(18, [1, 2, 3, 4, 5, 18]);
      expect(streak.current, 1);
      expect(streak.longest, 5);
    });
  });

  group('month and year boundaries', () {
    test('a run spanning a month end stays unbroken', () {
      final streak = Streak.from([
        Entry.compose(
          id: 'a',
          body: 'The last day of August, padded to length.',
          now: DateTime(2026, 8, 31, 20),
        ),
        Entry.compose(
          id: 'b',
          body: 'The first day of September, padded out.',
          now: DateTime(2026, 9, 1, 20),
        ),
      ], now: DateTime(2026, 9, 1, 22));
      expect(streak.current, 2);
    });

    test('a run spanning a year end stays unbroken', () {
      final streak = Streak.from([
        Entry.compose(
          id: 'a',
          body: 'New Year’s Eve, padded out to length.',
          now: DateTime(2026, 12, 31, 20),
        ),
        Entry.compose(
          id: 'b',
          body: 'New Year’s Day, padded out to length.',
          now: DateTime(2027, 1, 1, 20),
        ),
      ], now: DateTime(2027, 1, 1, 22));
      expect(streak.current, 2);
    });
  });
}
