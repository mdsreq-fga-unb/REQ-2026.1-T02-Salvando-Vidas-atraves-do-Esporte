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
      _t$_R0Mapper.ensureInitialized();
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
  static List<AlunoHome> _$alunosHome(HomeState v) => v.alunosHome;
  static const Field<HomeState, List<AlunoHome>> _f$alunosHome = Field(
    'alunosHome',
    _$alunosHome,
    key: r'alunos_home',
  );
  static int _$totalTurmas(HomeState v) => v.totalTurmas;
  static const Field<HomeState, int> _f$totalTurmas = Field(
    'totalTurmas',
    _$totalTurmas,
    key: r'total_turmas',
  );
  static int _$totalAlunos(HomeState v) => v.totalAlunos;
  static const Field<HomeState, int> _f$totalAlunos = Field(
    'totalAlunos',
    _$totalAlunos,
    key: r'total_alunos',
    opt: true,
    def: 0,
  );
  static int _$totalAtivos(HomeState v) => v.totalAtivos;
  static const Field<HomeState, int> _f$totalAtivos = Field(
    'totalAtivos',
    _$totalAtivos,
    key: r'total_ativos',
    opt: true,
    def: 0,
  );
  static int _$totalInativos(HomeState v) => v.totalInativos;
  static const Field<HomeState, int> _f$totalInativos = Field(
    'totalInativos',
    _$totalInativos,
    key: r'total_inativos',
    opt: true,
    def: 0,
  );
  static int _$kimonosDisponiveis(HomeState v) => v.kimonosDisponiveis;
  static const Field<HomeState, int> _f$kimonosDisponiveis = Field(
    'kimonosDisponiveis',
    _$kimonosDisponiveis,
    key: r'kimonos_disponiveis',
    opt: true,
    def: 0,
  );
  static int _$alertasEvasao(HomeState v) => v.alertasEvasao;
  static const Field<HomeState, int> _f$alertasEvasao = Field(
    'alertasEvasao',
    _$alertasEvasao,
    key: r'alertas_evasao',
    opt: true,
    def: 0,
  );
  static OrderBy _$orderBy(HomeState v) => v.orderBy;
  static const Field<HomeState, OrderBy> _f$orderBy = Field(
    'orderBy',
    _$orderBy,
    key: r'order_by',
    opt: true,
    def: OrderBy.ultimaPresenca,
  );
  static bool _$ascending(HomeState v) => v.ascending;
  static const Field<HomeState, bool> _f$ascending = Field(
    'ascending',
    _$ascending,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<HomeState> fields = const {
    #alunos: _f$alunos,
    #alunosHome: _f$alunosHome,
    #totalTurmas: _f$totalTurmas,
    #totalAlunos: _f$totalAlunos,
    #totalAtivos: _f$totalAtivos,
    #totalInativos: _f$totalInativos,
    #kimonosDisponiveis: _f$kimonosDisponiveis,
    #alertasEvasao: _f$alertasEvasao,
    #orderBy: _f$orderBy,
    #ascending: _f$ascending,
  };

  static HomeState _instantiate(DecodingData data) {
    return HomeState(
      alunos: data.dec(_f$alunos),
      alunosHome: data.dec(_f$alunosHome),
      totalTurmas: data.dec(_f$totalTurmas),
      totalAlunos: data.dec(_f$totalAlunos),
      totalAtivos: data.dec(_f$totalAtivos),
      totalInativos: data.dec(_f$totalInativos),
      kimonosDisponiveis: data.dec(_f$kimonosDisponiveis),
      alertasEvasao: data.dec(_f$alertasEvasao),
      orderBy: data.dec(_f$orderBy),
      ascending: data.dec(_f$ascending),
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
  ListCopyWith<$R, AlunoHome, ObjectCopyWith<$R, AlunoHome, AlunoHome>>
  get alunosHome;
  $R call({
    List<Aluno>? alunos,
    List<AlunoHome>? alunosHome,
    int? totalTurmas,
    int? totalAlunos,
    int? totalAtivos,
    int? totalInativos,
    int? kimonosDisponiveis,
    int? alertasEvasao,
    OrderBy? orderBy,
    bool? ascending,
  });
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
  ListCopyWith<$R, AlunoHome, ObjectCopyWith<$R, AlunoHome, AlunoHome>>
  get alunosHome => ListCopyWith(
    $value.alunosHome,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(alunosHome: v),
  );
  @override
  $R call({
    List<Aluno>? alunos,
    List<AlunoHome>? alunosHome,
    int? totalTurmas,
    int? totalAlunos,
    int? totalAtivos,
    int? totalInativos,
    int? kimonosDisponiveis,
    int? alertasEvasao,
    OrderBy? orderBy,
    bool? ascending,
  }) => $apply(
    FieldCopyWithData({
      if (alunos != null) #alunos: alunos,
      if (alunosHome != null) #alunosHome: alunosHome,
      if (totalTurmas != null) #totalTurmas: totalTurmas,
      if (totalAlunos != null) #totalAlunos: totalAlunos,
      if (totalAtivos != null) #totalAtivos: totalAtivos,
      if (totalInativos != null) #totalInativos: totalInativos,
      if (kimonosDisponiveis != null) #kimonosDisponiveis: kimonosDisponiveis,
      if (alertasEvasao != null) #alertasEvasao: alertasEvasao,
      if (orderBy != null) #orderBy: orderBy,
      if (ascending != null) #ascending: ascending,
    }),
  );
  @override
  HomeState $make(CopyWithData data) => HomeState(
    alunos: data.get(#alunos, or: $value.alunos),
    alunosHome: data.get(#alunosHome, or: $value.alunosHome),
    totalTurmas: data.get(#totalTurmas, or: $value.totalTurmas),
    totalAlunos: data.get(#totalAlunos, or: $value.totalAlunos),
    totalAtivos: data.get(#totalAtivos, or: $value.totalAtivos),
    totalInativos: data.get(#totalInativos, or: $value.totalInativos),
    kimonosDisponiveis: data.get(
      #kimonosDisponiveis,
      or: $value.kimonosDisponiveis,
    ),
    alertasEvasao: data.get(#alertasEvasao, or: $value.alertasEvasao),
    orderBy: data.get(#orderBy, or: $value.orderBy),
    ascending: data.get(#ascending, or: $value.ascending),
  );

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

typedef _t$_R0<A, B, C> = (A, B, C);

class _t$_R0Mapper extends RecordMapperBase<_t$_R0> {
  static _t$_R0Mapper? _instance;
  _t$_R0Mapper._();

  static _t$_R0Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = _t$_R0Mapper._());
      MapperBase.addType(<A, B, C>(f) => f<(A, B, C)>());
    }
    return _instance!;
  }

  static dynamic _$$1(_t$_R0 v) => v.$1;
  static dynamic _arg$$1<A, B, C>(f) => f<A>();
  static const Field<_t$_R0, dynamic> _f$$1 = Field('\$1', _$$1, arg: _arg$$1);
  static dynamic _$$2(_t$_R0 v) => v.$2;
  static dynamic _arg$$2<A, B, C>(f) => f<B>();
  static const Field<_t$_R0, dynamic> _f$$2 = Field('\$2', _$$2, arg: _arg$$2);
  static dynamic _$$3(_t$_R0 v) => v.$3;
  static dynamic _arg$$3<A, B, C>(f) => f<C>();
  static const Field<_t$_R0, dynamic> _f$$3 = Field('\$3', _$$3, arg: _arg$$3);

  @override
  final MappableFields<_t$_R0> fields = const {
    #$1: _f$$1,
    #$2: _f$$2,
    #$3: _f$$3,
  };

  @override
  Function get typeFactory =>
      <A, B, C>(f) => f<_t$_R0<A, B, C>>();

  static _t$_R0<A, B, C> _instantiate<A, B, C>(DecodingData<_t$_R0> data) {
    return (data.dec(_f$$1), data.dec(_f$$2), data.dec(_f$$3));
  }

  @override
  final Function instantiate = _instantiate;

  static _t$_R0<A, B, C> fromMap<A, B, C>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<_t$_R0<A, B, C>>(map);
  }

  static _t$_R0<A, B, C> fromJson<A, B, C>(String json) {
    return ensureInitialized().decodeJson<_t$_R0<A, B, C>>(json);
  }
}

