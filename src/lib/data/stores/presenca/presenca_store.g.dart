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
    extends $AsyncNotifierProvider<PresencaStore, PresencaState> {
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

String _$presencaStoreHash() => r'882160fd8c4e2de1d6f4723fc92f68d91e8edc60';

final class PresencaStoreFamily extends $Family
    with
        $ClassFamilyOverride<
          PresencaStore,
          AsyncValue<PresencaState>,
          PresencaState,
          FutureOr<PresencaState>,
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

abstract class _$PresencaStore extends $AsyncNotifier<PresencaState> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<PresencaState> build(int id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PresencaState>, PresencaState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PresencaState>, PresencaState>,
              AsyncValue<PresencaState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
