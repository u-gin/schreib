import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schreib/config/route_config.dart';
import 'package:schreib/main.dart';
import 'package:schreib/providers/entry_providers.dart';

import 'support/fake_entry_repository.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('starting the app does not open the store', (tester) async {
    // Regression: the database used to be constructed in `main`, so a
    // platform that could not open one white-screened the entire app --
    // including every screen that never touches storage. Opening it must
    // stay deferred until something actually reads the repository.
    var opened = false;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          entryRepositoryProvider.overrideWith((ref) {
            opened = true;
            return FakeEntryRepository();
          }),
        ],
        child: MyApp(router: createAppRouter()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Submit quote here!'), findsOneWidget);
    expect(opened, isFalse, reason: 'the store was built during startup');
  });

  testWidgets('the submit route also starts without opening the store', (
    tester,
  ) async {
    var opened = false;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          entryRepositoryProvider.overrideWith((ref) {
            opened = true;
            return FakeEntryRepository();
          }),
        ],
        child: MyApp(router: createAppRouter(initialLocation: '/submit')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Submit a Quote'), findsOneWidget);
    expect(opened, isFalse);
  });
}
