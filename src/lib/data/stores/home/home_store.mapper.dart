// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_store.dart';

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
      AlunoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeState';

  static List<Aluno> _$alunos(HomeState v) => v.alunos;
  static const Field<HomeState, List<Aluno>> _f$alunos = Field(
    'alunos',
    _$alunos,
  );
  static int _$totalTurmas(HomeState v) => v.totalTurmas;
  static const Field<HomeState, int> _f$totalTurmas = Field(
    'totalTurmas',
    _$totalTurmas,
    key: r'total_turmas',
  );
  static int _$kimonosDisponiveis(HomeState v) => v.kimonosDisponiveis;
  static const Field<HomeState, int> _f$kimonosDisponiveis = Field(
    'kimonosDisponiveis',
    _$kimonosDisponiveis,
    key: r'kimonos_disponiveis',
  );

  @override
  final MappableFields<HomeState> fields = const {
    #alunos: _f$alunos,
    #totalTurmas: _f$totalTurmas,
    #kimonosDisponiveis: _f$kimonosDisponiveis,
  };
  @override
  final bool ignoreNull = true;

  static HomeState _instantiate(DecodingData data) {
    return HomeState(
      alunos: data.dec(_f$alunos),
      totalTurmas: data.dec(_f$totalTurmas),
      kimonosDisponiveis: data.dec(_f$kimonosDisponiveis),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeState>(map);
  }

  static HomeState fromJson(String json) {
    return ensureInitialized().decodeJson<HomeState>(json);
  }
}

mixin HomeStateMappable {
  String toJson() {
    return HomeStateMapper.ensureInitialized().encodeJson<HomeState>(
      this as HomeState,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeStateMapper.ensureInitialized().encodeMap<HomeState>(
      this as HomeState,
    );
  }

  HomeStateCopyWith<HomeState, HomeState, HomeState> get copyWith =>
      _HomeStateCopyWithImpl<HomeState, HomeState>(
        this as HomeState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeStateMapper.ensureInitialized().stringifyValue(
      this as HomeState,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeStateMapper.ensureInitialized().equalsValue(
      this as HomeState,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeStateMapper.ensureInitialized().hashValue(this as HomeState);
  }
}

extension HomeStateValueCopy<$R, $Out> on ObjectCopyWith<$R, HomeState, $Out> {
  HomeStateCopyWith<$R, HomeState, $Out> get $asHomeState =>
      $base.as((v, t, t2) => _HomeStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeStateCopyWith<$R, $In extends HomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos;
  $R call({List<Aluno>? alunos, int? totalTurmas, int? kimonosDisponiveis});
  HomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeState, $Out>
    implements HomeStateCopyWith<$R, HomeState, $Out> {
  _HomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeState> $mapper =
      HomeStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos =>
      ListCopyWith(
        $value.alunos,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(alunos: v),
      );
  @override
  $R call({List<Aluno>? alunos, int? totalTurmas, int? kimonosDisponiveis}) =>
      $apply(
        FieldCopyWithData({
          if (alunos != null) #alunos: alunos,
          if (totalTurmas != null) #totalTurmas: totalTurmas,
          if (kimonosDisponiveis != null)
            #kimonosDisponiveis: kimonosDisponiveis,
        }),
      );
  @override
  HomeState $make(CopyWithData data) => HomeState(
    alunos: data.get(#alunos, or: $value.alunos),
    totalTurmas: data.get(#totalTurmas, or: $value.totalTurmas),
    kimonosDisponiveis: data.get(
      #kimonosDisponiveis,
      or: $value.kimonosDisponiveis,
    ),
  );

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

