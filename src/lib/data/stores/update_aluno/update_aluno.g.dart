// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'update_aluno.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateAluno)
final updateAlunoProvider = UpdateAlunoFamily._();

final class UpdateAlunoProvider
    extends $NotifierProvider<UpdateAluno, UpdateAlunoState> {
  UpdateAlunoProvider._({
    required UpdateAlunoFamily super.from,
    required (Aluno, Responsavel?) super.argument,
  }) : super(
         retry: null,
         name: r'updateAlunoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateAlunoHash();

  @override
  String toString() {
    return r'updateAlunoProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UpdateAluno create() => UpdateAluno();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateAlunoState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateAlunoState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateAlunoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateAlunoHash() => r'f6bf7cd61a7ab5fcf1dc7f789d44aed23931d7ac';

final class UpdateAlunoFamily extends $Family
    with
        $ClassFamilyOverride<
          UpdateAluno,
          UpdateAlunoState,
          UpdateAlunoState,
          UpdateAlunoState,
          (Aluno, Responsavel?)
        > {
  UpdateAlunoFamily._()
    : super(
        retry: null,
        name: r'updateAlunoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateAlunoProvider call(Aluno aluno, Responsavel? responsavel) =>
      UpdateAlunoProvider._(argument: (aluno, responsavel), from: this);

  @override
  String toString() => r'updateAlunoProvider';
}

abstract class _$UpdateAluno extends $Notifier<UpdateAlunoState> {
  late final _$args = ref.$arg as (Aluno, Responsavel?);
  Aluno get aluno => _$args.$1;
  Responsavel? get responsavel => _$args.$2;

  UpdateAlunoState build(Aluno aluno, Responsavel? responsavel);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UpdateAlunoState, UpdateAlunoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdateAlunoState, UpdateAlunoState>,
              UpdateAlunoState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
