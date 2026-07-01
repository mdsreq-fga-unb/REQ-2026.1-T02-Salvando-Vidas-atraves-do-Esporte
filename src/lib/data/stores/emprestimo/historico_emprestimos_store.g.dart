// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'historico_emprestimos_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoricoEmprestimosStore)
final historicoEmprestimosStoreProvider = HistoricoEmprestimosStoreProvider._();

final class HistoricoEmprestimosStoreProvider
    extends
        $AsyncNotifierProvider<
          HistoricoEmprestimosStore,
          HistoricoEmprestimosState
        > {
  HistoricoEmprestimosStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historicoEmprestimosStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historicoEmprestimosStoreHash();

  @$internal
  @override
  HistoricoEmprestimosStore create() => HistoricoEmprestimosStore();
}

String _$historicoEmprestimosStoreHash() =>
    r'1809806ab1878b9a86ffa20a876505ee2d36bf23';

abstract class _$HistoricoEmprestimosStore
    extends $AsyncNotifier<HistoricoEmprestimosState> {
  FutureOr<HistoricoEmprestimosState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<HistoricoEmprestimosState>,
              HistoricoEmprestimosState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<HistoricoEmprestimosState>,
                HistoricoEmprestimosState
              >,
              AsyncValue<HistoricoEmprestimosState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
