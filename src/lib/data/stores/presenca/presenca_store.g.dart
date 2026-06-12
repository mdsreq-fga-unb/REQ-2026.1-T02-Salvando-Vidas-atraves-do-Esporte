// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'presenca_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PresencaStore)
final presencaStoreProvider = PresencaStoreFamily._();

final class PresencaStoreProvider
    extends $AsyncNotifierProvider<PresencaStore, List<Aluno>> {
  PresencaStoreProvider._({
    required PresencaStoreFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'presencaStoreProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$presencaStoreHash();

  @override
  String toString() {
    return r'presencaStoreProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PresencaStore create() => PresencaStore();

  @override
  bool operator ==(Object other) {
    return other is PresencaStoreProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$presencaStoreHash() => r'b9b2be738af90b04ca7abd4b2abcf6df73545e91';

final class PresencaStoreFamily extends $Family
    with
        $ClassFamilyOverride<
          PresencaStore,
          AsyncValue<List<Aluno>>,
          List<Aluno>,
          FutureOr<List<Aluno>>,
          int
        > {
  PresencaStoreFamily._()
    : super(
        retry: null,
        name: r'presencaStoreProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PresencaStoreProvider call(int id) =>
      PresencaStoreProvider._(argument: id, from: this);

  @override
  String toString() => r'presencaStoreProvider';
}

abstract class _$PresencaStore extends $AsyncNotifier<List<Aluno>> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<List<Aluno>> build(int id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Aluno>>, List<Aluno>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Aluno>>, List<Aluno>>,
              AsyncValue<List<Aluno>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
