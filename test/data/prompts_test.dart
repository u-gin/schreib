import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/data/prompts.dart';

void main() {
  test('the corpus covers every quote', () {
    expect(promptCorpus, isNotEmpty);
    expect(promptCorpus.every((p) => p.text.trim().isNotEmpty), isTrue);
    expect(promptCorpus.every((p) => p.isAttributed), isTrue);
  });

  test('a day always gets the same prompt', () {
    // The point of the stable hash: restarting the app mid-morning must not
    // hand the author a different prompt than the one they were answering.
    for (final day in ['2026-09-18', '2026-01-01', '2027-12-31']) {
      expect(promptForDay(day).id, promptForDay(day).id);
      expect(promptForDay(day).text, promptForDay(day).text);
    }
  });

  test('consecutive days differ', () {
    final ids = [
      for (var d = 1; d <= 14; d++)
        promptForDay('2026-09-${d.toString().padLeft(2, '0')}').id,
    ];
    var repeats = 0;
    for (var i = 1; i < ids.length; i++) {
      if (ids[i] == ids[i - 1]) repeats++;
    }
    expect(repeats, 0, reason: 'the same prompt two days running');
  });

  test('spreads across the corpus rather than favouring a few', () {
    final seen = <String>{};
    for (var d = 0; d < 120; d++) {
      final date = DateTime(2026, 1, 1).add(Duration(days: d));
      final key =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';
      seen.add(promptForDay(key).id);
    }
    expect(
      seen.length,
      greaterThan(promptCorpus.length ~/ 2),
      reason: 'over four months it should reach most of the corpus',
    );
  });
}
