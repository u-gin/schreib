import 'dart:math' as math;

import 'package:schreib/models/day_key.dart';
import 'package:schreib/models/entry.dart';

/// Streak state, derived from entries and never stored.
///
/// The entries are the single source of truth. A stored counter would mean
/// every bug in the app could corrupt the number the author is proudest of,
/// and there would be no way to recompute it.
class Streak {
  const Streak({
    required this.current,
    required this.longest,
    required this.totalDays,
    required this.committedToday,
    required this.forgivenDays,
  });

  const Streak.empty()
    : current = 0,
      longest = 0,
      totalDays = 0,
      committedToday = false,
      forgivenDays = const {};

  /// How long a forgiven miss blocks the next one, in days.
  ///
  /// One missed day inside any week is absorbed; a second is not. A hard reset
  /// is the single biggest cause of habit-app abandonment, because the day
  /// after a first miss there is no reason left to come back.
  static const int graceWindowDays = 7;

  /// Days *written* in the run leading up to today.
  ///
  /// A forgiven miss keeps the run alive but is never counted as a written
  /// day. Reporting 15 for someone who wrote on 13 days would inflate the one
  /// number they are proudest of, and nothing else in the app would be
  /// believable afterwards.
  final int current;

  /// The best run ever recorded, under the same rules.
  final int longest;

  /// Total distinct days written. The honest lifetime number.
  final int totalDays;

  /// Whether today already has an entry.
  final bool committedToday;

  /// Missed days the grace rule carried the current streak through.
  ///
  /// The graph renders these differently: it shows what actually happened,
  /// even while the streak forgives it.
  final Set<String> forgivenDays;

  bool get isAlive => current > 0;

  /// Derives streak state from [entries].
  ///
  /// [now] is injectable so the rules can be tested without waiting a week.
  factory Streak.from(Iterable<Entry> entries, {DateTime? now}) {
    final committed = {for (final entry in entries) entry.dayKey};
    if (committed.isEmpty) return const Streak.empty();

    final today = startOfDay(now ?? DateTime.now());
    final sortedKeys = committed.toList()..sort();
    final earliest = dayFromKey(sortedKeys.first);

    var current = 0;
    final forgiven = <String>{};
    DateTime? lastForgiven;
    var cursor = today;
    var onToday = true;

    while (!cursor.isBefore(earliest)) {
      final key = dayKeyOf(cursor);

      if (committed.contains(key)) {
        current++;
        onToday = false;
        cursor = _previousDay(cursor);
        continue;
      }

      // Today is not a miss until the day is over.
      if (onToday) {
        onToday = false;
        cursor = _previousDay(cursor);
        continue;
      }

      // A real miss. Grace covers an isolated one, once per window.
      if (lastForgiven != null &&
          _daysBetween(lastForgiven, cursor) < graceWindowDays) {
        break;
      }
      final previous = _previousDay(cursor);
      if (!committed.contains(dayKeyOf(previous))) {
        break; // two missed days in a row always ends it
      }

      forgiven.add(key);
      lastForgiven = cursor;
      cursor = previous;
    }

    return Streak(
      current: current,
      longest: math.max(current, _longestRun(sortedKeys)),
      totalDays: committed.length,
      committedToday: committed.contains(dayKeyOf(today)),
      forgivenDays: forgiven,
    );
  }

  /// The best run in [sortedKeys] (ascending), under the same grace rule.
  static int _longestRun(List<String> sortedKeys) {
    var best = 0;
    var run = 0;
    DateTime? previous;
    DateTime? lastForgiven;

    for (final key in sortedKeys) {
      final day = dayFromKey(key);

      if (previous == null) {
        run = 1;
      } else {
        final gap = _daysBetween(day, previous);
        final canForgive =
            lastForgiven == null ||
            _daysBetween(day, lastForgiven) >= graceWindowDays;

        if (gap == 1) {
          run++;
        } else if (gap == 2 && canForgive) {
          lastForgiven = _previousDay(day);
          run++;
        } else {
          best = math.max(best, run);
          run = 1;
          lastForgiven = null;
        }
      }
      previous = day;
    }
    return math.max(best, run);
  }

  /// Calendar-safe previous day: [DateTime] normalises overflow, so this is
  /// correct across month ends and daylight-saving shifts.
  static DateTime _previousDay(DateTime day) =>
      DateTime(day.year, day.month, day.day - 1);

  /// Whole days from [b] to [a], immune to daylight-saving hour shifts.
  static int _daysBetween(DateTime a, DateTime b) => DateTime.utc(
    a.year,
    a.month,
    a.day,
  ).difference(DateTime.utc(b.year, b.month, b.day)).inDays;

  @override
  String toString() =>
      'Streak(current: $current, longest: $longest, total: $totalDays)';
}
