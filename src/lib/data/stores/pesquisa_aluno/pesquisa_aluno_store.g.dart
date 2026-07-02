// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'pesquisa_aluno_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PesquisaAluno)
final pesquisaAlunoProvider = PesquisaAlunoProvider._();

final class PesquisaAlunoProvider
    extends $AsyncNotifierProvider<PesquisaAluno, PesquisaAlunoState> {
  PesquisaAlunoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pesquisaAlunoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pesquisaAlunoHash();

  @$internal
  @override
  PesquisaAluno create() => PesquisaAluno();
}

String _$pesquisaAlunoHash() => r'0e44938e8be851b261c552e9117dd98a67cd3ca1';

abstract class _$PesquisaAluno extends $AsyncNotifier<PesquisaAlunoState> {
  FutureOr<PesquisaAlunoState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PesquisaAlunoState>, PesquisaAlunoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PesquisaAlunoState>, PesquisaAlunoState>,
              AsyncValue<PesquisaAlunoState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
