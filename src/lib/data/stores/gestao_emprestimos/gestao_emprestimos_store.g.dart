// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'gestao_emprestimos_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GestaoEmprestimosStore)
final gestaoEmprestimosStoreProvider = GestaoEmprestimosStoreProvider._();

final class GestaoEmprestimosStoreProvider
    extends
        $AsyncNotifierProvider<GestaoEmprestimosStore, GestaoEmprestimosState> {
  GestaoEmprestimosStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gestaoEmprestimosStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gestaoEmprestimosStoreHash();

  @$internal
  @override
  GestaoEmprestimosStore create() => GestaoEmprestimosStore();
}

String _$gestaoEmprestimosStoreHash() =>
    r'648772c90dd7c73d2066e1fc9422c6de391ecaa6';

abstract class _$GestaoEmprestimosStore
    extends $AsyncNotifier<GestaoEmprestimosState> {
  FutureOr<GestaoEmprestimosState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<GestaoEmprestimosState>, GestaoEmprestimosState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<GestaoEmprestimosState>,
                GestaoEmprestimosState
              >,
              AsyncValue<GestaoEmprestimosState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
