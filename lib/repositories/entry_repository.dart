import 'package:schreib/models/entry.dart';
import 'package:schreib/models/revision.dart';

/// Reads and writes entries.
///
/// This interface is the seam. Screens and providers depend on it and never on
/// an implementation, so the local store can be swapped for a syncing one in
/// phase 2 by changing a single provider override.
abstract interface class EntryRepository {
  /// All entries, newest first. Emits again on every change.
  Stream<List<Entry>> watchAll();

  /// The entry for a given `YYYY-MM-DD` day, or null. Emits again on change.
  ///
  /// One entry per day is the shape the streak assumes; if a second is ever
  /// allowed, this becomes a list.
  Stream<Entry?> watchByDay(String dayKey);

  /// Entries belonging to [seriesId], oldest first: reading order.
  Stream<List<Entry>> watchSeries(String seriesId);

  /// Stores a new entry.
  Future<void> commit(Entry entry);

  /// Replaces an entry's text, keeping the old text as a [Revision].
  ///
  /// Throws [StateError] if [entryId] is unknown.
  Future<void> revise(String entryId, String newBody);

  /// The edit history of an entry, newest replacement first.
  Future<List<Revision>> revisionsOf(String entryId);

  /// Entries the server has not yet seen. The phase 2 push outbox.
  Future<List<Entry>> pendingSync();

  Future<Entry?> byId(String id);

  Future<void> delete(String entryId);
}
