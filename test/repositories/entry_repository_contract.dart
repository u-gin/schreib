import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/models/entry.dart';
import 'package:schreib/repositories/entry_repository.dart';

/// The behaviour every [EntryRepository] must have, run against each
/// implementation.
///
/// Sharing one suite is what stops the test fake from becoming a kinder
/// fiction than the real database.
void runEntryRepositoryContract(
  String name,
  EntryRepository Function() create, {
  void Function()? tearDownEach,
}) {
  group('$name (contract)', () {
    late EntryRepository repo;

    setUp(() => repo = create());
    tearDown(() => tearDownEach?.call());

    Entry compose(String id, String body, {DateTime? at, String? seriesId}) =>
        Entry.compose(
          id: id,
          body: body,
          now: at ?? DateTime(2026, 9, 18, 10),
          seriesId: seriesId,
        );

    test('a committed entry can be read back', () async {
      final entry = compose('a', 'The first commit, long enough to pass.');
      await repo.commit(entry);

      final loaded = await repo.byId('a');
      expect(loaded, isNotNull);
      expect(loaded!.body, 'The first commit, long enough to pass.');
      expect(loaded.visibility, EntryVisibility.private);
    });

    test('an unknown id reads back as null', () async {
      expect(await repo.byId('nope'), isNull);
    });

    test('watchAll emits the current entries, newest day first', () async {
      await repo.commit(
        compose(
          'a',
          'Written on the 16th, padded out.',
          at: DateTime(2026, 9, 16),
        ),
      );
      await repo.commit(
        compose(
          'b',
          'Written on the 18th, padded out.',
          at: DateTime(2026, 9, 18),
        ),
      );

      final entries = await repo.watchAll().first;
      expect(entries.map((e) => e.id), ['b', 'a']);
    });

    test('watchAll re-emits after a commit', () async {
      final seen = <int>[];
      final sub = repo.watchAll().listen((entries) => seen.add(entries.length));

      await pumpEventQueue();
      await repo.commit(compose('a', 'A first entry, long enough to pass.'));
      await pumpEventQueue();

      expect(seen, containsAllInOrder([0, 1]));
      await sub.cancel();
    });

    test('watchByDay finds the entry for that day and nothing else', () async {
      await repo.commit(
        compose(
          'a',
          'The entry for the 18th, padded.',
          at: DateTime(2026, 9, 18),
        ),
      );

      expect((await repo.watchByDay('2026-09-18').first)?.id, 'a');
      expect(await repo.watchByDay('2026-09-17').first, isNull);
    });

    test('watchSeries returns that series only, in reading order', () async {
      await repo.commit(
        compose(
          'p1',
          'Part one of the story, padded.',
          at: DateTime(2026, 9, 12),
          seriesId: 's',
        ),
      );
      await repo.commit(
        compose(
          'p2',
          'Part two of the story, padded.',
          at: DateTime(2026, 9, 19),
          seriesId: 's',
        ),
      );
      await repo.commit(
        compose(
          'x',
          'Unrelated standalone entry, padded.',
          at: DateTime(2026, 9, 20),
        ),
      );

      final parts = await repo.watchSeries('s').first;
      expect(parts.map((e) => e.id), ['p1', 'p2']);
    });

    test('revising replaces the text and keeps the old version', () async {
      await repo.commit(compose('a', 'The original wording, padded out.'));

      await repo.revise('a', 'The revised wording, padded out.');

      final entry = await repo.byId('a');
      expect(entry!.body, 'The revised wording, padded out.');
      expect(entry.revisionCount, 1);
      expect(entry.wasEdited, isTrue);

      final history = await repo.revisionsOf('a');
      expect(history, hasLength(1));
      expect(history.single.body, 'The original wording, padded out.');
    });

    test('revisions accumulate, newest replacement first', () async {
      await repo.commit(compose('a', 'Version one of the text, padded.'));
      await repo.revise('a', 'Version two of the text, padded.');
      await repo.revise('a', 'Version three of the text, padded.');

      final history = await repo.revisionsOf('a');
      expect(history.map((r) => r.body), [
        'Version two of the text, padded.',
        'Version one of the text, padded.',
      ]);
      expect(history.map((r) => r.sequence), [1, 0]);
      expect((await repo.byId('a'))!.revisionCount, 2);
    });

    test('revising an unknown entry throws', () async {
      expect(
        () => repo.revise('ghost', 'Some replacement text, padded out.'),
        throwsA(isA<StateError>()),
      );
    });

    test('an over-long revision is rejected and changes nothing', () async {
      await repo.commit(compose('a', 'The original wording, padded out.'));

      await expectLater(
        () => repo.revise('a', 'x' * (Entry.maxLength + 1)),
        throwsA(isA<ArgumentError>()),
      );

      final entry = await repo.byId('a');
      expect(entry!.body, 'The original wording, padded out.');
      expect(entry.revisionCount, 0);
      expect(await repo.revisionsOf('a'), isEmpty);
    });

    test('everything written locally is pending sync', () async {
      await repo.commit(compose('a', 'An entry awaiting a server, padded.'));
      expect(await repo.pendingSync(), hasLength(1));
    });

    test('deleting removes the entry and its history', () async {
      await repo.commit(compose('a', 'An entry to be deleted, padded.'));
      await repo.revise('a', 'An entry about to vanish, padded.');

      await repo.delete('a');

      expect(await repo.byId('a'), isNull);
      expect(await repo.revisionsOf('a'), isEmpty);
    });
  });
}
