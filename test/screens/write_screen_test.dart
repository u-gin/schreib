import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schreib/config/route_config.dart';
import 'package:schreib/data/prompts.dart';
import 'package:schreib/main.dart';
import 'package:schreib/models/entry.dart';
import 'package:schreib/providers/entry_providers.dart';

import '../support/fake_entry_repository.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  late FakeEntryRepository repo;
  final now = DateTime(2026, 9, 18, 10);

  setUp(() {
    repo = FakeEntryRepository(clock: () => now);
    addTearDown(repo.dispose);
  });

  Future<void> pumpWrite(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          entryRepositoryProvider.overrideWithValue(repo),
          clockProvider.overrideWithValue(() => now),
        ],
        child: MyApp(router: createAppRouter(initialLocation: '/write')),
      ),
    );
    await tester.pumpAndSettle();
  }

  // Finders are lazy, so these re-resolve on every use.
  final composer = find.byType(TextField);
  final commitButton = find.widgetWithText(ElevatedButton, 'Commit');

  group('the prompt', () {
    testWidgets('shows today’s prompt and its attribution', (tester) async {
      await pumpWrite(tester);

      final prompt = promptForDay('2026-09-18');
      expect(find.text('“${prompt.text}”'), findsOneWidget);
      expect(find.text('— ${prompt.attributedTo}'), findsOneWidget);
    });
  });

  group('the composer', () {
    testWidgets('starts empty with the full allowance', (tester) async {
      await pumpWrite(tester);

      expect(find.text('${Entry.maxLength} left'), findsOneWidget);
      expect(find.text('Only you'), findsOneWidget);
    });

    testWidgets('cannot commit nothing', (tester) async {
      await pumpWrite(tester);

      final button = tester.widget<ElevatedButton>(commitButton);
      expect(button.onPressed, isNull);
    });

    testWidgets('whitespace alone does not enable commit', (tester) async {
      await pumpWrite(tester);
      await tester.enterText(composer, '    ');
      await tester.pump();

      expect(tester.widget<ElevatedButton>(commitButton).onPressed, isNull);
    });

    testWidgets('counts down as you type', (tester) async {
      await pumpWrite(tester);
      await tester.enterText(composer, 'Twelve chars');
      await tester.pump();

      expect(find.text('${Entry.maxLength - 12} left'), findsOneWidget);
    });

    testWidgets('cannot be typed past the limit', (tester) async {
      await pumpWrite(tester);
      await tester.enterText(composer, 'x' * 400);
      await tester.pump();

      expect(
        tester.widget<TextField>(composer).controller!.text.length,
        Entry.maxLength,
      );
      expect(find.text('0 left'), findsOneWidget);
    });
  });

  group('committing', () {
    testWidgets('stores the entry against today’s prompt', (tester) async {
      await pumpWrite(tester);
      await tester.enterText(composer, 'A first line of the day.');
      await tester.pump();

      await tester.tap(commitButton);
      await tester.pumpAndSettle();

      final stored = await repo.watchAll().first;
      expect(stored, hasLength(1));
      expect(stored.single.body, 'A first line of the day.');
      expect(stored.single.dayKey, '2026-09-18');
      expect(stored.single.promptId, promptForDay('2026-09-18').id);
    });

    testWidgets('stores privately and unsynced', (tester) async {
      await pumpWrite(tester);
      await tester.enterText(composer, 'Something written quietly.');
      await tester.pump();
      await tester.tap(commitButton);
      await tester.pumpAndSettle();

      final stored = (await repo.watchAll().first).single;
      expect(stored.visibility, EntryVisibility.private);
      expect(stored.syncState, SyncState.localOnly);
    });

    testWidgets('confirms without claiming more than it did', (tester) async {
      await pumpWrite(tester);
      await tester.enterText(composer, 'A line worth keeping.');
      await tester.pump();
      await tester.tap(commitButton);
      await tester.pump();

      expect(find.text('Committed'), findsOneWidget);
    });
  });

  group('when today is already written', () {
    setUp(() async {
      await repo.commit(
        Entry.compose(id: 'today', body: 'The line written earlier.', now: now),
      );
    });

    testWidgets('loads the existing entry into the composer', (tester) async {
      await pumpWrite(tester);

      expect(
        tester.widget<TextField>(composer).controller!.text,
        'The line written earlier.',
      );
      expect(find.text('Committed today'), findsOneWidget);
    });

    testWidgets('offers Revise rather than Commit', (tester) async {
      await pumpWrite(tester);

      expect(commitButton, findsNothing);
      expect(find.widgetWithText(ElevatedButton, 'Revise'), findsOneWidget);
    });

    testWidgets('revising replaces the text and keeps history', (tester) async {
      await pumpWrite(tester);

      await tester.enterText(composer, 'The line, thought better of.');
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Revise'));
      await tester.pumpAndSettle();

      final stored = (await repo.watchAll().first).single;
      expect(stored.body, 'The line, thought better of.');
      expect(stored.revisionCount, 1);
      expect(await repo.revisionsOf('today'), hasLength(1));

      // One entry per day: revising must not create a second.
      expect(await repo.watchAll().first, hasLength(1));
    });

    testWidgets('shows the streak once there is one', (tester) async {
      await pumpWrite(tester);
      expect(find.text('1 day'), findsOneWidget);
    });
  });

  group('reaching it', () {
    testWidgets('home links to the writing screen', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entryRepositoryProvider.overrideWithValue(repo),
            clockProvider.overrideWithValue(() => now),
          ],
          child: MyApp(router: createAppRouter()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Write today'));
      await tester.pumpAndSettle();

      expect(find.text('Today'), findsOneWidget);
      expect(composer, findsOneWidget);
    });
  });
}
