// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'aluno_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(alunoService)
final alunoServiceProvider = AlunoServiceProvider._();

final class AlunoServiceProvider
    extends $FunctionalProvider<AlunoService, AlunoService, AlunoService>
    with $Provider<AlunoService> {
  AlunoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alunoServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alunoServiceHash();

  @$internal
  @override
  $ProviderElement<AlunoService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AlunoService create(Ref ref) {
    return alunoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlunoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlunoService>(value),
    );
  }
}

String _$alunoServiceHash() => r'855c6deaa9f8f4f17ed71cf2df6e74f933286e93';
