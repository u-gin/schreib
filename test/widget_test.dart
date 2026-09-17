import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schreib/config/route_config.dart';
import 'package:schreib/data/quotes.dart';
import 'package:schreib/main.dart';

void main() {
  setUpAll(() {
    // Inter is not bundled, so without this the tests reach for the network.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget app({String initialLocation = '/'}) =>
      MyApp(router: createAppRouter(initialLocation: initialLocation));

  /// The quote text as rendered: the card wraps it in typographic quotes.
  Finder quoteText(String quote) => find.text('“$quote”');

  group('home screen', () {
    testWidgets('shows a quote from the list with its author', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      final shown = quotes.where((q) => tester.any(quoteText(q['quote']!)));

      expect(
        shown,
        hasLength(1),
        reason: 'exactly one quote from the list should be on screen',
      );
      expect(find.text('— ${shown.single['author']}'), findsOneWidget);
    });

    testWidgets('tapping the background swaps in a different quote', (
      tester,
    ) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      final before = quotes.firstWhere(
        (q) => tester.any(quoteText(q['quote']!)),
      );

      await tester.tapAt(tester.getCenter(find.byType(Scaffold)));
      await tester.pumpAndSettle();

      expect(quoteText(before['quote']!), findsNothing);
    });

    testWidgets('quote survives a short viewport without being clipped away', (
      tester,
    ) async {
      // A landscape phone. The quote used to overflow and get silently cut.
      tester.view.physicalSize = const Size(640, 360);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  group('navigation', () {
    testWidgets('the nav item routes to the submit screen', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Submit quote here!'));
      await tester.pumpAndSettle();

      expect(find.text('Submit a Quote'), findsOneWidget);
    });

    testWidgets('Back returns to the home screen', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Submit quote here!'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Submit a Quote'), findsNothing);
      expect(find.text('Submit quote here!'), findsOneWidget);
    });

    testWidgets('Back still reaches home when /submit was opened directly', (
      tester,
    ) async {
      // A deep link or a page refresh leaves nothing on the stack to pop.
      await tester.pumpWidget(app(initialLocation: '/submit'));
      await tester.pumpAndSettle();

      expect(find.text('Submit a Quote'), findsOneWidget);

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Submit quote here!'), findsOneWidget);
    });
  });

  group('submit form', () {
    testWidgets('rejects an empty quote and an empty author', (tester) async {
      await tester.pumpWidget(app(initialLocation: '/submit'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Submit'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a quote'), findsOneWidget);
      expect(
        find.text('Please enter a name to display as the author'),
        findsOneWidget,
      );
    });

    testWidgets('rejects a quote that is too short', (tester) async {
      await tester.pumpWidget(app(initialLocation: '/submit'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'too short');
      await tester.ensureVisible(find.text('Submit'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Quote is too short'), findsOneWidget);
    });

    testWidgets('does not claim success, and keeps what was typed', (
      tester,
    ) async {
      await tester.pumpWidget(app(initialLocation: '/submit'));
      await tester.pumpAndSettle();

      const quote = 'A quote long enough to pass validation.';
      await tester.enterText(find.byType(TextFormField).first, quote);
      await tester.enterText(find.byType(TextFormField).last, 'Ada Lovelace');

      await tester.ensureVisible(find.text('Submit'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(
        find.descendant(
          of: find.byType(SnackBar),
          matching: find.textContaining('wasn’t sent'),
        ),
        findsOneWidget,
      );
      expect(find.text('Quote submitted!'), findsNothing);

      // Clearing the fields would imply the quote went somewhere.
      expect(find.text(quote), findsOneWidget);
      expect(find.text('Ada Lovelace'), findsOneWidget);
    });
  });

  group('quote content', () {
    test('every quote has an author and neither field is blank', () {
      for (final quote in quotes) {
        expect(quote['quote']?.trim(), isNotEmpty);
        expect(quote['author']?.trim(), isNotEmpty);
      }
    });

    test('quotes are short enough to be actual quotations', () {
      // Guards against the generated filler that once padded every entry.
      for (final quote in quotes) {
        expect(
          quote['quote']!.length,
          lessThan(120),
          reason: 'suspiciously long: ${quote['author']}',
        );
      }
    });
  });
}
