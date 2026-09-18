// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The seam for reminders, mirroring the entry store.
///
/// Unimplemented on purpose: `main` overrides it with a
/// [LocalReminderScheduler], tests override it with a fake, and nothing above
/// this line touches the notification plugin.

@ProviderFor(reminderScheduler)
final reminderSchedulerProvider = ReminderSchedulerProvider._();

/// The seam for reminders, mirroring the entry store.
///
/// Unimplemented on purpose: `main` overrides it with a
/// [LocalReminderScheduler], tests override it with a fake, and nothing above
/// this line touches the notification plugin.

final class ReminderSchedulerProvider
    extends
        $FunctionalProvider<
          ReminderScheduler,
          ReminderScheduler,
          ReminderScheduler
        >
    with $Provider<ReminderScheduler> {
  /// The seam for reminders, mirroring the entry store.
  ///
  /// Unimplemented on purpose: `main` overrides it with a
  /// [LocalReminderScheduler], tests override it with a fake, and nothing above
  /// this line touches the notification plugin.
  ReminderSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSchedulerHash();

  @$internal
  @override
  $ProviderElement<ReminderScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderScheduler create(Ref ref) {
    return reminderScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderScheduler>(value),
    );
  }
}

String _$reminderSchedulerHash() => r'74d75967a8731f33a262fc9114d70cb7b960d267';

/// The time the daily reminder is set for.
///
/// Holds the choice only; persisting it belongs with the settings screen that
/// does not exist yet.

@ProviderFor(ReminderSetting)
final reminderSettingProvider = ReminderSettingProvider._();

/// The time the daily reminder is set for.
///
/// Holds the choice only; persisting it belongs with the settings screen that
/// does not exist yet.
final class ReminderSettingProvider
    extends $NotifierProvider<ReminderSetting, ReminderTime?> {
  /// The time the daily reminder is set for.
  ///
  /// Holds the choice only; persisting it belongs with the settings screen that
  /// does not exist yet.
  ReminderSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSettingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSettingHash();

  @$internal
  @override
  ReminderSetting create() => ReminderSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderTime?>(value),
    );
  }
}

String _$reminderSettingHash() => r'b1ad550ef1a8cbc69c602297a3523ec55c699877';

/// The time the daily reminder is set for.
///
/// Holds the choice only; persisting it belongs with the settings screen that
/// does not exist yet.

abstract class _$ReminderSetting extends $Notifier<ReminderTime?> {
  ReminderTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReminderTime?, ReminderTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReminderTime?, ReminderTime?>,
              ReminderTime?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
