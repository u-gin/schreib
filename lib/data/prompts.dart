import 'package:schreib/data/quotes.dart';
import 'package:schreib/models/prompt.dart';

/// The prompt corpus, derived from the quote list the app started as.
///
/// A quote is now the thing you write *against* rather than the product
/// itself, so the id is the index: stable as long as the list only grows by
/// appending.
final List<Prompt> promptCorpus = List.unmodifiable([
  for (var i = 0; i < quotes.length; i++)
    Prompt(
      id: 'q$i',
      text: quotes[i]['quote']!,
      attributedTo: quotes[i]['author'],
      // None of these carry a citation yet. Saying so is cheaper than
      // repeating the web's apocrypha as though it were sourced.
      attributionDisputed: true,
    ),
]);

/// The prompt for a given `YYYY-MM-DD` day.
///
/// The same every time it is asked for that day, and different across days.
/// A prompt that changed on every rebuild would be a slot machine, not
/// something to answer.
Prompt promptForDay(String dayKey) =>
    promptCorpus[_stableHash(dayKey) % promptCorpus.length];

/// FNV-1a, 32 bit.
///
/// Dart's own `String.hashCode` is only stable within a single run, so a
/// prompt chosen with it would change every time the app restarted -- twice
/// in one day, on the same day.
int _stableHash(String value) {
  var hash = 0x811c9dc5;
  for (final unit in value.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0x7fffffff;
  }
  return hash;
}
