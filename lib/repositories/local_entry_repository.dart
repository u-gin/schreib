import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:schreib/data/app_database.dart';
import 'package:schreib/models/entry.dart';
import 'package:schreib/models/revision.dart';
import 'package:schreib/repositories/entry_repository.dart';

/// The phase 1 store: everything on the device, nothing on a server.
///
/// This is not a placeholder for a backend. "Your writing, on your device" is
/// a real property, and it means the writing surface works on a plane.
class LocalEntryRepository implements EntryRepository {
  LocalEntryRepository(this._db, {Uuid? uuid, DateTime Function()? clock})
    : _uuid = uuid ?? const Uuid(),
      _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final Uuid _uuid;
  final DateTime Function() _now;

  @override
  Stream<List<Entry>> watchAll() {
    final query = _db.select(_db.entries)
      ..orderBy([(e) => OrderingTerm.desc(e.dayKey)]);
    return query.watch().map((rows) => rows.map(_toModel).toList());
  }

  @override
  Stream<Entry?> watchByDay(String dayKey) {
    final query = _db.select(_db.entries)
      ..where((e) => e.dayKey.equals(dayKey))
      ..limit(1);
    return query.watch().map(
      (rows) => rows.isEmpty ? null : _toModel(rows.first),
    );
  }

  @override
  Stream<List<Entry>> watchSeries(String seriesId) {
    final query = _db.select(_db.entries)
      ..where((e) => e.seriesId.equals(seriesId))
      ..orderBy([(e) => OrderingTerm.asc(e.createdAt)]);
    return query.watch().map((rows) => rows.map(_toModel).toList());
  }

  @override
  Future<void> commit(Entry entry) =>
      _db.into(_db.entries).insert(_toRow(entry));

  @override
  Future<void> revise(String entryId, String newBody) {
    return _db.transaction(() async {
      final existing = await byId(entryId);
      if (existing == null) {
        throw StateError('no entry $entryId to revise');
      }

      // Validate before writing anything: `revised` enforces the length limit.
      final updated = existing.revised(newBody);

      await _db
          .into(_db.revisions)
          .insert(
            RevisionRow(
              id: _uuid.v4(),
              entryId: entryId,
              body: existing.body,
              sequence: existing.revisionCount,
              replacedAt: _now().toUtc(),
            ),
          );
      await _db.update(_db.entries).replace(_toRow(updated));
    });
  }

  @override
  Future<List<Revision>> revisionsOf(String entryId) async {
    final query = _db.select(_db.revisions)
      ..where((r) => r.entryId.equals(entryId))
      ..orderBy([(r) => OrderingTerm.desc(r.sequence)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        Revision(
          id: row.id,
          entryId: row.entryId,
          body: row.body,
          sequence: row.sequence,
          replacedAt: row.replacedAt,
        ),
    ];
  }

  @override
  Future<List<Entry>> pendingSync() async {
    final query = _db.select(_db.entries)
      ..where((e) => e.syncState.equalsValue(StoredSyncState.synced).not());
    return (await query.get()).map(_toModel).toList();
  }

  @override
  Future<Entry?> byId(String id) async {
    final query = _db.select(_db.entries)..where((e) => e.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  @override
  Future<void> delete(String entryId) {
    return _db.transaction(() async {
      await (_db.delete(
        _db.revisions,
      )..where((r) => r.entryId.equals(entryId))).go();
      await (_db.delete(_db.entries)..where((e) => e.id.equals(entryId))).go();
    });
  }

  Entry _toModel(EntryRow row) => Entry(
    id: row.id,
    body: row.body,
    createdAt: row.createdAt,
    dayKey: row.dayKey,
    tzOffsetMinutes: row.tzOffsetMinutes,
    seriesId: row.seriesId,
    promptId: row.promptId,
    revisionCount: row.revisionCount,
    visibility: EntryVisibility.values[row.visibility.index],
    syncState: SyncState.values[row.syncState.index],
  );

  EntryRow _toRow(Entry entry) => EntryRow(
    id: entry.id,
    body: entry.body,
    createdAt: entry.createdAt,
    dayKey: entry.dayKey,
    tzOffsetMinutes: entry.tzOffsetMinutes,
    seriesId: entry.seriesId,
    promptId: entry.promptId,
    revisionCount: entry.revisionCount,
    visibility: StoredVisibility.values[entry.visibility.index],
    syncState: StoredSyncState.values[entry.syncState.index],
  );
}
