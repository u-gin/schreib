import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show ProviderException, ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/models/entry.dart';
import 'package:schreib/providers/entry_providers.dart';

import '../support/fake_entry_repository.dart';

void main() {
  late FakeEntryRepository repo;
  late ProviderContainer container;
  var now = DateTime(2026, 9, 18, 10);

  /// A container wired the way `main` wires the app, but against the fake and
  /// a frozen clock. This is the seam doing its job.
  ProviderContainer makeContainer() {
    final c = ProviderContainer(
      overrides: [
        entryRepositoryProvider.overrideWithValue(repo),
        clockProvider.overrideWithValue(() => now),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  /// Holds an autodispose provider open for the length of a test, the way a
  /// widget watching it would.
  void keepAlive(ProviderContainer c, ProviderListenable<Object?> provider) {
    final sub = c.listen(provider, (_, _) {});
    addTearDown(sub.close);
  }

  setUp(() {
    now = DateTime(2026, 9, 18, 10);
    repo = FakeEntryRepository(clock: () => now);
    addTearDown(repo.dispose);
    container = makeContainer();
  });

  test('today comes from the injected clock', () {
    expect(container.read(todayProvider), '2026-09-18');
  });

  test(
    'committing stores an entry that reads back through the stream',
    () async {
      keepAlive(container, entriesProvider);
      await pumpEventQueue();

      await container
          .read(entryComposerProvider.notifier)
          .commit('A first line of the day, padded out.');
      await pumpEventQueue();

      final entries = container.read(entriesProvider).value;
      expect(entries, hasLength(1));
      expect(entries!.single.body, 'A first line of the day, padded out.');
    },
  );

  test('a committed entry is private and local by default', () async {
    final composer = container.read(entryComposerProvider.notifier);
    final entry = await composer.commit('Written for nobody, padded out.');

    expect(entry.visibility, EntryVisibility.private);
    expect(entry.syncState, SyncState.localOnly);
  });

  test('each commit gets a distinct id', () async {
    final composer = container.read(entryComposerProvider.notifier);
    final first = await composer.commit('The first entry, padded out.');
    now = DateTime(2026, 9, 19, 10);
    final second = await composer.commit('The second entry, padded out.');

    expect(first.id, isNotEmpty);
    expect(first.id, isNot(second.id));
  });

  test('an over-long commit is rejected and nothing is stored', () async {
    final composer = container.read(entryComposerProvider.notifier);

    await expectLater(
      () => composer.commit('x' * (Entry.maxLength + 1)),
      throwsA(isA<ArgumentError>()),
    );
    expect(await repo.watchAll().first, isEmpty);
  });

  test('todaysEntry is null until today is written', () async {
    final seen = <Entry?>[];
    final sub = container.listen(todaysEntryProvider, (_, next) {
      if (next case AsyncData(:final value)) seen.add(value);
    }, fireImmediately: true);
    addTearDown(sub.close);

    await pumpEventQueue();
    expect(seen, [null], reason: 'nothing written yet');

    await container
        .read(entryComposerProvider.notifier)
        .commit('Today’s line, padded out to length.');
    await pumpEventQueue();

    expect(seen.last, isNotNull, reason: 'the stream reported the new entry');
  });

  test('streak reflects what has been committed', () async {
    final composer = container.read(entryComposerProvider.notifier);

    now = DateTime(2026, 9, 16, 10);
    await composer.commit('An entry on the 16th, padded out.');
    now = DateTime(2026, 9, 17, 10);
    await composer.commit('An entry on the 17th, padded out.');
    now = DateTime(2026, 9, 18, 10);
    await composer.commit('An entry on the 18th, padded out.');

    // Rebuild so the derived providers see the frozen clock's new value.
    final fresh = makeContainer();
    keepAlive(fresh, entriesProvider);
    await pumpEventQueue();

    final streak = fresh.read(streakProvider);
    expect(streak.current, 3);
    expect(streak.committedToday, isTrue);
  });

  test('revising through the composer keeps history', () async {
    final composer = container.read(entryComposerProvider.notifier);
    final entry = await composer.commit('The first wording, padded out.');

    await composer.revise(entry.id, 'The second wording, padded out.');

    expect(
      (await repo.byId(entry.id))!.body,
      'The second wording, padded out.',
    );
    expect(await repo.revisionsOf(entry.id), hasLength(1));
  });

  test('the repository provider must be overridden', () {
    final bare = ProviderContainer();
    addTearDown(bare.dispose);
    expect(
      () => bare.read(entryRepositoryProvider),
      throwsA(
        isA<ProviderException>().having(
          (e) => e.exception,
          'wrapped exception',
          isA<UnimplementedError>(),
        ),
      ),
    );
  });
}
