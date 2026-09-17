/// A writing day, in the author's own calendar.
///
/// Streaks are a local-calendar idea, not a UTC one. Deriving the day from a
/// UTC instant loses a day for anyone writing late in the evening, and
/// scrambles the streak of anyone who travels. So the day is resolved once,
/// where the author is, at the moment they write, and stored alongside the
/// instant.
library;

/// Formats [local] as `YYYY-MM-DD`. Sorts correctly as a plain string.
String dayKeyOf(DateTime local) {
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  return '${local.year.toString().padLeft(4, '0')}-$month-$day';
}

/// Parses a `YYYY-MM-DD` key back to local midnight.
DateTime dayFromKey(String key) {
  final parts = key.split('-');
  if (parts.length != 3) {
    throw FormatException('not a day key', key);
  }
  return DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
  );
}

/// Local midnight of [instant], with the time of day discarded.
DateTime startOfDay(DateTime instant) =>
    DateTime(instant.year, instant.month, instant.day);
