// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The seam.
///
/// Deliberately unimplemented: `main` overrides it with a
/// [LocalEntryRepository], phase 2 overrides it with a syncing one, and tests
/// override it with a fake. Nothing above this line knows which it got.

@ProviderFor(entryRepository)
final entryRepositoryProvider = EntryRepositoryProvider._();

/// The seam.
///
/// Deliberately unimplemented: `main` overrides it with a
/// [LocalEntryRepository], phase 2 overrides it with a syncing one, and tests
/// override it with a fake. Nothing above this line knows which it got.

final class EntryRepositoryProvider
    extends
        $FunctionalProvider<EntryRepository, EntryRepository, EntryRepository>
    with $Provider<EntryRepository> {
  /// The seam.
  ///
  /// Deliberately unimplemented: `main` overrides it with a
  /// [LocalEntryRepository], phase 2 overrides it with a syncing one, and tests
  /// override it with a fake. Nothing above this line knows which it got.
  EntryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entryRepositoryHash();

  @$internal
  @override
  $ProviderElement<EntryRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EntryRepository create(Ref ref) {
    return entryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntryRepository>(value),
    );
  }
}

String _$entryRepositoryHash() => r'73d45efb31f3876c1d9569abd4153d4daae100b2';

/// Clock seam, so anything date-dependent stays testable.

@ProviderFor(clock)
final clockProvider = ClockProvider._();

/// Clock seam, so anything date-dependent stays testable.

final class ClockProvider
    extends
        $FunctionalProvider<
          DateTime Function(),
          DateTime Function(),
          DateTime Function()
        >
    with $Provider<DateTime Function()> {
  /// Clock seam, so anything date-dependent stays testable.
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<DateTime Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DateTime Function() create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime Function()>(value),
    );
  }
}

String _$clockHash() => r'3f65ad34ac6fcd532de9004042bdf2ed2bd85b13';

@ProviderFor(uuid)
final uuidProvider = UuidProvider._();

final class UuidProvider extends $FunctionalProvider<Uuid, Uuid, Uuid>
    with $Provider<Uuid> {
  UuidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uuidProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uuidHash();

  @$internal
  @override
  $ProviderElement<Uuid> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uuid create(Ref ref) {
    return uuid(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uuid value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uuid>(value),
    );
  }
}

String _$uuidHash() => r'63633bd7add95a8e80ee3cd2fbccd7919f6eebc9';

/// Every entry, newest first.

@ProviderFor(entries)
final entriesProvider = EntriesProvider._();

/// Every entry, newest first.

final class EntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Entry>>,
          List<Entry>,
          Stream<List<Entry>>
        >
    with $FutureModifier<List<Entry>>, $StreamProvider<List<Entry>> {
  /// Every entry, newest first.
  EntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entriesHash();

  @$internal
  @override
  $StreamProviderElement<List<Entry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Entry>> create(Ref ref) {
    return entries(ref);
  }
}

String _$entriesHash() => r'3a87c6c8575d3a40355f6546c9c22326ccbc5f2b';

/// Today's writing day, in the author's calendar.

@ProviderFor(today)
final todayProvider = TodayProvider._();

/// Today's writing day, in the author's calendar.

final class TodayProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Today's writing day, in the author's calendar.
  TodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return today(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$todayHash() => r'c2ce7436fe1560fb4df308dcc6f6952ec2bdb914';

/// Today's entry, or null if nothing is written yet.

@ProviderFor(todaysEntry)
final todaysEntryProvider = TodaysEntryProvider._();

/// Today's entry, or null if nothing is written yet.

final class TodaysEntryProvider
    extends $FunctionalProvider<AsyncValue<Entry?>, Entry?, Stream<Entry?>>
    with $FutureModifier<Entry?>, $StreamProvider<Entry?> {
  /// Today's entry, or null if nothing is written yet.
  TodaysEntryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaysEntryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaysEntryHash();

  @$internal
  @override
  $StreamProviderElement<Entry?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Entry?> create(Ref ref) {
    return todaysEntry(ref);
  }
}

String _$todaysEntryHash() => r'362a2337be318a7ad20e4da810eba50eba848b55';

/// Streak state, recomputed from entries on every change.

@ProviderFor(streak)
final streakProvider = StreakProvider._();

/// Streak state, recomputed from entries on every change.

final class StreakProvider extends $FunctionalProvider<Streak, Streak, Streak>
    with $Provider<Streak> {
  /// Streak state, recomputed from entries on every change.
  StreakProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streakProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streakHash();

  @$internal
  @override
  $ProviderElement<Streak> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Streak create(Ref ref) {
    return streak(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Streak value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Streak>(value),
    );
  }
}

String _$streakHash() => r'18103d51c2c5c2a05d18adcf7d1f83b51ab386e5';

/// Entries of one series, in reading order.

@ProviderFor(seriesEntries)
final seriesEntriesProvider = SeriesEntriesFamily._();

/// Entries of one series, in reading order.

final class SeriesEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Entry>>,
          List<Entry>,
          Stream<List<Entry>>
        >
    with $FutureModifier<List<Entry>>, $StreamProvider<List<Entry>> {
  /// Entries of one series, in reading order.
  SeriesEntriesProvider._({
    required SeriesEntriesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'seriesEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$seriesEntriesHash();

  @override
  String toString() {
    return r'seriesEntriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Entry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Entry>> create(Ref ref) {
    final argument = this.argument as String;
    return seriesEntries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SeriesEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$seriesEntriesHash() => r'be2847b42fc1fcdfbcf42c2c100d40182c4f2c94';

/// Entries of one series, in reading order.

final class SeriesEntriesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Entry>>, String> {
  SeriesEntriesFamily._()
    : super(
        retry: null,
        name: r'seriesEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Entries of one series, in reading order.

  SeriesEntriesProvider call(String seriesId) =>
      SeriesEntriesProvider._(argument: seriesId, from: this);

  @override
  String toString() => r'seriesEntriesProvider';
}

/// Writes entries. The only way the UI creates or edits writing.

@ProviderFor(EntryComposer)
final entryComposerProvider = EntryComposerProvider._();

/// Writes entries. The only way the UI creates or edits writing.
final class EntryComposerProvider
    extends $NotifierProvider<EntryComposer, void> {
  /// Writes entries. The only way the UI creates or edits writing.
  EntryComposerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entryComposerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entryComposerHash();

  @$internal
  @override
  EntryComposer create() => EntryComposer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$entryComposerHash() => r'86fbf458251031425088e2b92c491d404ed3cb93';

/// Writes entries. The only way the UI creates or edits writing.

abstract class _$EntryComposer extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
