import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Stored entries.
///
/// The primary key is a client-generated UUID rather than an autoincrementing
/// integer. Entries are written offline, so the id has to be valid before the
/// server has ever heard of it; this is what keeps the phase 2 sync migration
/// from having to rewrite local references.
@DataClassName('EntryRow')
class Entries extends Table {
  TextColumn get id => text()();
  TextColumn get body => text().withLength(min: 1, max: 300)();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get dayKey => text().withLength(min: 10, max: 10)();
  IntColumn get tzOffsetMinutes => integer()();
  TextColumn get seriesId => text().nullable()();
  TextColumn get promptId => text().nullable()();
  IntColumn get revisionCount => integer().withDefault(const Constant(0))();
  IntColumn get visibility => intEnum<StoredVisibility>()();
  IntColumn get syncState => intEnum<StoredSyncState>()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Superseded entry text, ordered by [Revisions.sequence].
@DataClassName('RevisionRow')
class Revisions extends Table {
  TextColumn get id => text()();
  TextColumn get entryId => text().references(Entries, #id)();
  TextColumn get body => text()();
  IntColumn get sequence => integer()();
  DateTimeColumn get replacedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SeriesRow')
class SeriesTable extends Table {
  @override
  String get tableName => 'series';

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get cadenceKind => integer()();
  IntColumn get cadenceWeekday => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get visibility => intEnum<StoredVisibility>()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Persisted mirrors of the domain enums.
///
/// Separate from the model enums on purpose: the stored ordinals are a schema
/// commitment, so reordering a domain enum must not silently rewrite history.
enum StoredVisibility { private, unlisted, public }

enum StoredSyncState { localOnly, pendingPush, synced }

@DriftDatabase(tables: [Entries, Revisions, SeriesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'schreib'));

  @override
  int get schemaVersion => 1;
}
