import 'package:schreib/models/entry.dart';

/// How often a series promises a new part.
enum CadenceKind { none, daily, weekly }

/// A publishing rhythm. The 'every Saturday' commitment lives here: it drives
/// reminders and the 'next part due' state, and it is what lets a serialised
/// story build suspense between commits.
class Cadence {
  const Cadence.none() : kind = CadenceKind.none, weekday = null;
  const Cadence.daily() : kind = CadenceKind.daily, weekday = null;

  /// [weekday] uses `DateTime.monday`..`DateTime.sunday`.
  const Cadence.weekly(int this.weekday) : kind = CadenceKind.weekly;

  final CadenceKind kind;
  final int? weekday;

  /// The next day this series is due after [from], or null if unscheduled.
  DateTime? nextDueAfter(DateTime from) {
    switch (kind) {
      case CadenceKind.none:
        return null;
      case CadenceKind.daily:
        return DateTime(from.year, from.month, from.day + 1);
      case CadenceKind.weekly:
        final target = weekday!;
        var ahead = (target - from.weekday) % 7;
        if (ahead == 0) ahead = 7;
        return DateTime(from.year, from.month, from.day + ahead);
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Cadence && other.kind == kind && other.weekday == weekday;

  @override
  int get hashCode => Object.hash(kind, weekday);
}

/// A collection of entries read in order: the 'repo'.
///
/// A reader arriving at part nine reads the log from the beginning, which is
/// what makes a commit history better for serialised work than a mailing list.
class Series {
  const Series({
    required this.id,
    required this.title,
    required this.createdAt,
    this.description,
    this.cadence = const Cadence.none(),
    this.visibility = EntryVisibility.private,
  });

  final String id;
  final String title;
  final String? description;
  final Cadence cadence;
  final DateTime createdAt;
  final EntryVisibility visibility;

  Series copyWith({
    String? title,
    String? description,
    Cadence? cadence,
    EntryVisibility? visibility,
  }) => Series(
    id: id,
    title: title ?? this.title,
    createdAt: createdAt,
    description: description ?? this.description,
    cadence: cadence ?? this.cadence,
    visibility: visibility ?? this.visibility,
  );

  @override
  String toString() => 'Series($id, $title)';
}
