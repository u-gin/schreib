import 'dart:async';

import 'package:schreib/models/entry.dart';
import 'package:schreib/models/revision.dart';
import 'package:schreib/repositories/entry_repository.dart';

/// In-memory [EntryRepository] for tests that care about behaviour above the
/// store, not the store itself.
///
/// It is held to the same contract test as the real one, so it cannot quietly
/// drift into being a more forgiving fiction than the database.
class FakeEntryRepository implements EntryRepository {
  FakeEntryRepository({DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final DateTime Function() _now;
  final Map<String, Entry> _entries = {};
  final List<Revision> _revisions = [];
  final _changes = StreamController<void>.broadcast();

  var _nextRevisionId = 0;

  void dispose() => _changes.close();

  Stream<T> _watch<T>(T Function() read) async* {
    yield read();
    yield* _changes.stream.map((_) => read());
  }

  List<Entry> get _newestFirst {
    final all = _entries.values.toList()
      ..sort((a, b) => b.dayKey.compareTo(a.dayKey));
    return all;
  }

  @override
  Stream<List<Entry>> watchAll() => _watch(() => _newestFirst);

  @override
  Stream<Entry?> watchByDay(String dayKey) => _watch(() {
    for (final entry in _entries.values) {
      if (entry.dayKey == dayKey) return entry;
    }
    return null;
  });

  @override
  Stream<List<Entry>> watchSeries(String seriesId) => _watch(() {
    final matching =
        _entries.values.where((e) => e.seriesId == seriesId).toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return matching;
  });

  @override
  Future<void> commit(Entry entry) async {
    _entries[entry.id] = entry;
    _changes.add(null);
  }

  @override
  Future<void> revise(String entryId, String newBody) async {
    final existing = _entries[entryId];
    if (existing == null) {
      throw StateError('no entry $entryId to revise');
    }
    final updated = existing.revised(newBody);
    _revisions.add(
      Revision(
        id: 'rev-${_nextRevisionId++}',
        entryId: entryId,
        body: existing.body,
        sequence: existing.revisionCount,
        replacedAt: _now().toUtc(),
      ),
    );
    _entries[entryId] = updated;
    _changes.add(null);
  }

  @override
  Future<List<Revision>> revisionsOf(String entryId) async {
    final matching = _revisions.where((r) => r.entryId == entryId).toList()
      ..sort((a, b) => b.sequence.compareTo(a.sequence));
    return matching;
  }

  @override
  Future<List<Entry>> pendingSync() async =>
      _entries.values.where((e) => e.syncState != SyncState.synced).toList();

  @override
  Future<Entry?> byId(String id) async => _entries[id];

  @override
  Future<void> delete(String entryId) async {
    _entries.remove(entryId);
    _revisions.removeWhere((r) => r.entryId == entryId);
    _changes.add(null);
  }
}
