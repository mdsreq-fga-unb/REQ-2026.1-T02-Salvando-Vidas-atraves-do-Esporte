// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'turmas_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TurmasStore)
final turmasStoreProvider = TurmasStoreProvider._();

final class TurmasStoreProvider
    extends $AsyncNotifierProvider<TurmasStore, List<Turma>> {
  TurmasStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'turmasStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$turmasStoreHash();

  @$internal
  @override
  TurmasStore create() => TurmasStore();
}

String _$turmasStoreHash() => r'3ce166b162f513451224c898e1d80b8f98979ddb';

abstract class _$TurmasStore extends $AsyncNotifier<List<Turma>> {
  FutureOr<List<Turma>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Turma>>, List<Turma>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Turma>>, List<Turma>>,
              AsyncValue<List<Turma>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
