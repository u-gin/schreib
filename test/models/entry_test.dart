import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/models/entry.dart';

void main() {
  Entry compose(String body, {DateTime? now}) => Entry.compose(
    id: 'id',
    body: body,
    now: now ?? DateTime(2026, 9, 18, 14, 30),
  );

  group('the 300 character limit', () {
    test('is hard', () {
      expect(Entry.maxLength, 300);
      expect(() => compose('x' * 301), throwsA(isA<ArgumentError>()));
    });

    test('accepts exactly the limit', () {
      expect(compose('x' * 300).body.length, 300);
    });

    test('measures the trimmed text', () {
      // Surrounding whitespace should not cost the author characters.
      expect(compose('  ${'x' * 300}  ').body.length, 300);
    });

    test('rejects an empty or whitespace-only entry', () {
      expect(() => compose(''), throwsA(isA<ArgumentError>()));
      expect(() => compose('   \n  '), throwsA(isA<ArgumentError>()));
    });

    test('applies to revisions too', () {
      final entry = compose('The original text, long enough to pass.');
      expect(() => entry.revised('x' * 301), throwsA(isA<ArgumentError>()));
      expect(() => entry.revised('  '), throwsA(isA<ArgumentError>()));
    });
  });

  group('private by default', () {
    test('a composed entry is private', () {
      expect(
        compose('Something written quietly, padded.').visibility,
        EntryVisibility.private,
      );
      expect(compose('Something written quietly, padded.').isPublic, isFalse);
    });

    test('publishing is an explicit act', () {
      final entry = compose(
        'Something written to share, padded out.',
        now: DateTime(2026, 9, 18, 9),
      ).copyWith(visibility: EntryVisibility.public);
      expect(entry.isPublic, isTrue);
    });

    test('nothing starts out synced', () {
      expect(
        compose('Written offline, padded out.').syncState,
        SyncState.localOnly,
      );
    });
  });

  group('the writing day', () {
    test('comes from the local calendar, not the UTC instant', () {
      // Late evening local time: deriving the day from UTC would push this
      // into tomorrow for anyone east of Greenwich, or yesterday west of it.
      final entry = compose(
        'Written just before midnight, padded.',
        now: DateTime(2026, 9, 18, 23, 55),
      );
      expect(entry.dayKey, '2026-09-18');
    });

    test('is recorded with the offset it was resolved in', () {
      final entry = compose('An ordinary entry, padded out.');
      expect(
        entry.tzOffsetMinutes,
        DateTime(2026, 9, 18, 14, 30).timeZoneOffset.inMinutes,
      );
    });

    test('a UTC instant is converted before the day is taken', () {
      final entry = Entry.compose(
        id: 'id',
        body: 'Composed from a UTC instant, padded.',
        now: DateTime.utc(2026, 9, 18, 12),
      );
      expect(entry.dayKey, dayKeyForLocal(DateTime.utc(2026, 9, 18, 12)));
      expect(entry.createdAt.isUtc, isTrue);
    });
  });

  group('revising', () {
    test('replaces the text and counts the revision', () {
      final revised = compose(
        'The first wording, padded out.',
      ).revised('The second wording, padded out.');
      expect(revised.body, 'The second wording, padded out.');
      expect(revised.revisionCount, 1);
      expect(revised.wasEdited, isTrue);
    });

    test('keeps the original id and writing day', () {
      final original = compose('The first wording, padded out.');
      final revised = original.revised('The second wording, padded out.');
      expect(revised.id, original.id);
      expect(revised.dayKey, original.dayKey);
      expect(revised.createdAt, original.createdAt);
    });

    test('a synced entry becomes pending again', () {
      final synced = compose(
        'Already on the server, padded.',
      ).copyWith(syncState: SyncState.synced);
      expect(
        synced.revised('Edited afterwards, padded out.').syncState,
        SyncState.pendingPush,
      );
    });
  });
}

/// The day key a local rendering of [instant] would produce.
String dayKeyForLocal(DateTime instant) {
  final local = instant.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  return '${local.year}-$month-$day';
}
