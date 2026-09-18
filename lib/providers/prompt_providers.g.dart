// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The prompt to write against today.

@ProviderFor(todaysPrompt)
final todaysPromptProvider = TodaysPromptProvider._();

/// The prompt to write against today.

final class TodaysPromptProvider
    extends $FunctionalProvider<Prompt, Prompt, Prompt>
    with $Provider<Prompt> {
  /// The prompt to write against today.
  TodaysPromptProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaysPromptProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaysPromptHash();

  @$internal
  @override
  $ProviderElement<Prompt> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Prompt create(Ref ref) {
    return todaysPrompt(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Prompt value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Prompt>(value),
    );
  }
}

String _$todaysPromptHash() => r'cfda84f81645098f16ae6b4b7fa06acf040b4944';
