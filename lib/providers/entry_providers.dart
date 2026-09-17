import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:schreib/models/day_key.dart';
import 'package:schreib/models/entry.dart';
import 'package:schreib/models/streak.dart';
import 'package:schreib/repositories/entry_repository.dart';

part 'entry_providers.g.dart';

/// The seam.
///
/// Deliberately unimplemented: `main` overrides it with a
/// [LocalEntryRepository], phase 2 overrides it with a syncing one, and tests
/// override it with a fake. Nothing above this line knows which it got.
@Riverpod(keepAlive: true)
EntryRepository entryRepository(Ref ref) => throw UnimplementedError(
  'override entryRepositoryProvider in ProviderScope',
);

/// Clock seam, so anything date-dependent stays testable.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;

@Riverpod(keepAlive: true)
Uuid uuid(Ref ref) => const Uuid();

/// Every entry, newest first.
@riverpod
Stream<List<Entry>> entries(Ref ref) =>
    ref.watch(entryRepositoryProvider).watchAll();

/// Today's writing day, in the author's calendar.
@riverpod
String today(Ref ref) => dayKeyOf(ref.watch(clockProvider)());

/// Today's entry, or null if nothing is written yet.
@riverpod
Stream<Entry?> todaysEntry(Ref ref) =>
    ref.watch(entryRepositoryProvider).watchByDay(ref.watch(todayProvider));

/// Streak state, recomputed from entries on every change.
@riverpod
Streak streak(Ref ref) {
  final entries = ref.watch(entriesProvider).value ?? const <Entry>[];
  return Streak.from(entries, now: ref.watch(clockProvider)());
}

/// Entries of one series, in reading order.
@riverpod
Stream<List<Entry>> seriesEntries(Ref ref, String seriesId) =>
    ref.watch(entryRepositoryProvider).watchSeries(seriesId);

/// Writes entries. The only way the UI creates or edits writing.
@riverpod
class EntryComposer extends _$EntryComposer {
  @override
  void build() {}

  /// Commits [body] as today's entry.
  ///
  /// Throws [ArgumentError] if [body] is empty or over [Entry.maxLength].
  Future<Entry> commit(
    String body, {
    String? seriesId,
    String? promptId,
    EntryVisibility visibility = EntryVisibility.private,
  }) async {
    final entry = Entry.compose(
      id: ref.read(uuidProvider).v4(),
      body: body,
      now: ref.read(clockProvider)(),
      seriesId: seriesId,
      promptId: promptId,
      visibility: visibility,
    );
    await ref.read(entryRepositoryProvider).commit(entry);
    return entry;
  }

  Future<void> revise(String entryId, String newBody) =>
      ref.read(entryRepositoryProvider).revise(entryId, newBody);
}
