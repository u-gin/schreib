import 'package:schreib/models/day_key.dart';

/// How widely an entry is shared. Private is the default, deliberately: people
/// only write daily if they are allowed to write badly.
enum EntryVisibility { private, unlisted, public }

/// Where an entry stands relative to the server. Phase 1 never leaves
/// [SyncState.localOnly]; the field exists so phase 2 does not need a
/// migration.
enum SyncState { localOnly, pendingPush, synced }

/// One commit: the atomic unit of the product.
///
/// Immutable. Editing produces a new [Entry] plus a `Revision` holding the
/// superseded text, so history stays visible.
class Entry {
  /// The hard ceiling on an entry, in characters.
  ///
  /// Hard, not advisory: it is what keeps a daily entry achievable in two
  /// minutes, keeps the card legible at any length, and keeps Schreib out of
  /// competition with long-form publishing.
  static const int maxLength = 300;

  const Entry({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.dayKey,
    required this.tzOffsetMinutes,
    this.seriesId,
    this.promptId,
    this.revisionCount = 0,
    this.visibility = EntryVisibility.private,
    this.syncState = SyncState.localOnly,
  });

  /// Builds an entry from author input, resolving the writing day and
  /// enforcing the length limit.
  ///
  /// [id] must be a client-generated UUID: entries are written offline, and
  /// server-assigned ids would have to be reconciled on first sync.
  factory Entry.compose({
    required String id,
    required String body,
    required DateTime now,
    String? seriesId,
    String? promptId,
    EntryVisibility visibility = EntryVisibility.private,
  }) {
    final text = body.trim();
    if (text.isEmpty) {
      throw ArgumentError.value(body, 'body', 'an entry cannot be empty');
    }
    if (text.length > maxLength) {
      throw ArgumentError.value(
        body,
        'body',
        'an entry is at most $maxLength characters (got ${text.length})',
      );
    }

    final local = now.isUtc ? now.toLocal() : now;
    return Entry(
      id: id,
      body: text,
      createdAt: local.toUtc(),
      dayKey: dayKeyOf(local),
      tzOffsetMinutes: local.timeZoneOffset.inMinutes,
      seriesId: seriesId,
      promptId: promptId,
      visibility: visibility,
    );
  }

  final String id;
  final String body;

  /// The instant of writing, in UTC.
  final DateTime createdAt;

  /// The day this entry counts for, as `YYYY-MM-DD` in the author's calendar.
  final String dayKey;

  /// The author's UTC offset when they wrote, so [dayKey] can be audited.
  final int tzOffsetMinutes;

  final String? seriesId;
  final String? promptId;

  /// How many times this entry has been revised. 0 means never edited.
  final int revisionCount;

  final EntryVisibility visibility;
  final SyncState syncState;

  bool get isPublic => visibility == EntryVisibility.public;
  bool get wasEdited => revisionCount > 0;

  /// The revised entry. The caller is responsible for storing a `Revision`
  /// carrying the superseded [body].
  Entry revised(String newBody) {
    final text = newBody.trim();
    if (text.isEmpty) {
      throw ArgumentError.value(newBody, 'newBody', 'an entry cannot be empty');
    }
    if (text.length > maxLength) {
      throw ArgumentError.value(
        newBody,
        'newBody',
        'an entry is at most $maxLength characters (got ${text.length})',
      );
    }
    return copyWith(
      body: text,
      revisionCount: revisionCount + 1,
      syncState: syncState == SyncState.synced
          ? SyncState.pendingPush
          : syncState,
    );
  }

  Entry copyWith({
    String? body,
    String? seriesId,
    String? promptId,
    int? revisionCount,
    EntryVisibility? visibility,
    SyncState? syncState,
  }) {
    return Entry(
      id: id,
      body: body ?? this.body,
      createdAt: createdAt,
      dayKey: dayKey,
      tzOffsetMinutes: tzOffsetMinutes,
      seriesId: seriesId ?? this.seriesId,
      promptId: promptId ?? this.promptId,
      revisionCount: revisionCount ?? this.revisionCount,
      visibility: visibility ?? this.visibility,
      syncState: syncState ?? this.syncState,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Entry &&
      other.id == id &&
      other.body == body &&
      other.dayKey == dayKey &&
      other.revisionCount == revisionCount &&
      other.visibility == visibility &&
      other.syncState == syncState;

  @override
  int get hashCode =>
      Object.hash(id, body, dayKey, revisionCount, visibility, syncState);

  @override
  String toString() => 'Entry($id, $dayKey, ${body.length} chars)';
}
