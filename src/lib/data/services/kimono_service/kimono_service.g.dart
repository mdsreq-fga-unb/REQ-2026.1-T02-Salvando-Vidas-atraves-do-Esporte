// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'kimono_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kimonoService)
final kimonoServiceProvider = KimonoServiceProvider._();

final class KimonoServiceProvider
    extends $FunctionalProvider<KimonoService, KimonoService, KimonoService>
    with $Provider<KimonoService> {
  KimonoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kimonoServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kimonoServiceHash();

  @$internal
  @override
  $ProviderElement<KimonoService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KimonoService create(Ref ref) {
    return kimonoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KimonoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KimonoService>(value),
    );
  }
}

String _$kimonoServiceHash() => r'9f67175e79b7e78e6fbf02bd3630daadf2182d6f';
