// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'presenca_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(presencaService)
final presencaServiceProvider = PresencaServiceProvider._();

final class PresencaServiceProvider
    extends
        $FunctionalProvider<PresencaService, PresencaService, PresencaService>
    with $Provider<PresencaService> {
  PresencaServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'presencaServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$presencaServiceHash();

  @$internal
  @override
  $ProviderElement<PresencaService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PresencaService create(Ref ref) {
    return presencaService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PresencaService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PresencaService>(value),
    );
  }
}

String _$presencaServiceHash() => r'08ec37f395ca2a3d07b6ff959d4302630c68d7e2';
