// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'cadastro_aluno.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CadastroAluno)
final cadastroAlunoProvider = CadastroAlunoProvider._();

final class CadastroAlunoProvider
    extends $NotifierProvider<CadastroAluno, CadastroAlunoState> {
  CadastroAlunoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cadastroAlunoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cadastroAlunoHash();

  @$internal
  @override
  CadastroAluno create() => CadastroAluno();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CadastroAlunoState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CadastroAlunoState>(value),
    );
  }
}

String _$cadastroAlunoHash() => r'2e5b4b68a900c6803cd2c3f2bd6663bf156e4e98';

abstract class _$CadastroAluno extends $Notifier<CadastroAlunoState> {
  CadastroAlunoState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CadastroAlunoState, CadastroAlunoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CadastroAlunoState, CadastroAlunoState>,
              CadastroAlunoState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
