// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'turma_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(turmaService)
final turmaServiceProvider = TurmaServiceProvider._();

final class TurmaServiceProvider
    extends $FunctionalProvider<TurmaService, TurmaService, TurmaService>
    with $Provider<TurmaService> {
  TurmaServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'turmaServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$turmaServiceHash();

  @$internal
  @override
  $ProviderElement<TurmaService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TurmaService create(Ref ref) {
    return turmaService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TurmaService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TurmaService>(value),
    );
  }
}

String _$turmaServiceHash() => r'52ea4a43085c956d7a3357e6bd816bd18b9b3ed9';
