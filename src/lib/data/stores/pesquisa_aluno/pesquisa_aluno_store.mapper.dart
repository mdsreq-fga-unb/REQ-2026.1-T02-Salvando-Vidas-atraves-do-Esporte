// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pesquisa_aluno_store.dart';

class PesquisaAlunoStateMapper extends ClassMapperBase<PesquisaAlunoState> {
  PesquisaAlunoStateMapper._();

  static PesquisaAlunoStateMapper? _instance;
  static PesquisaAlunoStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PesquisaAlunoStateMapper._());
      AlunoMapper.ensureInitialized();
      ResponsavelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PesquisaAlunoState';

  static List<Aluno> _$alunos(PesquisaAlunoState v) => v.alunos;
  static const Field<PesquisaAlunoState, List<Aluno>> _f$alunos = Field(
    'alunos',
    _$alunos,
  );
  static List<Aluno> _$alunosFiltrados(PesquisaAlunoState v) =>
      v.alunosFiltrados;
  static const Field<PesquisaAlunoState, List<Aluno>> _f$alunosFiltrados =
      Field('alunosFiltrados', _$alunosFiltrados, key: r'alunos_filtrados');
  static Map<int, Responsavel> _$responsaveis(PesquisaAlunoState v) =>
      v.responsaveis;
  static const Field<PesquisaAlunoState, Map<int, Responsavel>>
  _f$responsaveis = Field('responsaveis', _$responsaveis);
  static bool _$mostrarInativos(PesquisaAlunoState v) => v.mostrarInativos;
  static const Field<PesquisaAlunoState, bool> _f$mostrarInativos = Field(
    'mostrarInativos',
    _$mostrarInativos,
    key: r'mostrar_inativos',
    opt: true,
    def: false,
  );

  @override
  final MappableFields<PesquisaAlunoState> fields = const {
    #alunos: _f$alunos,
    #alunosFiltrados: _f$alunosFiltrados,
    #responsaveis: _f$responsaveis,
    #mostrarInativos: _f$mostrarInativos,
  };

  static PesquisaAlunoState _instantiate(DecodingData data) {
    return PesquisaAlunoState(
      alunos: data.dec(_f$alunos),
      alunosFiltrados: data.dec(_f$alunosFiltrados),
      responsaveis: data.dec(_f$responsaveis),
      mostrarInativos: data.dec(_f$mostrarInativos),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PesquisaAlunoState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PesquisaAlunoState>(map);
  }

  static PesquisaAlunoState fromJson(String json) {
    return ensureInitialized().decodeJson<PesquisaAlunoState>(json);
  }
}

mixin PesquisaAlunoStateMappable {
  String toJson() {
    return PesquisaAlunoStateMapper.ensureInitialized()
        .encodeJson<PesquisaAlunoState>(this as PesquisaAlunoState);
  }

  Map<String, dynamic> toMap() {
    return PesquisaAlunoStateMapper.ensureInitialized()
        .encodeMap<PesquisaAlunoState>(this as PesquisaAlunoState);
  }

  PesquisaAlunoStateCopyWith<
    PesquisaAlunoState,
    PesquisaAlunoState,
    PesquisaAlunoState
  >
  get copyWith =>
      _PesquisaAlunoStateCopyWithImpl<PesquisaAlunoState, PesquisaAlunoState>(
        this as PesquisaAlunoState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PesquisaAlunoStateMapper.ensureInitialized().stringifyValue(
      this as PesquisaAlunoState,
    );
  }

  @override
  bool operator ==(Object other) {
    return PesquisaAlunoStateMapper.ensureInitialized().equalsValue(
      this as PesquisaAlunoState,
      other,
    );
  }

  @override
  int get hashCode {
    return PesquisaAlunoStateMapper.ensureInitialized().hashValue(
      this as PesquisaAlunoState,
    );
  }
}

extension PesquisaAlunoStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PesquisaAlunoState, $Out> {
  PesquisaAlunoStateCopyWith<$R, PesquisaAlunoState, $Out>
  get $asPesquisaAlunoState => $base.as(
    (v, t, t2) => _PesquisaAlunoStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PesquisaAlunoStateCopyWith<
  $R,
  $In extends PesquisaAlunoState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos;
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunosFiltrados;
  MapCopyWith<
    $R,
    int,
    Responsavel,
    ResponsavelCopyWith<$R, Responsavel, Responsavel>
  >
  get responsaveis;
  $R call({
    List<Aluno>? alunos,
    List<Aluno>? alunosFiltrados,
    Map<int, Responsavel>? responsaveis,
    bool? mostrarInativos,
  });
  PesquisaAlunoStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PesquisaAlunoStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PesquisaAlunoState, $Out>
    implements PesquisaAlunoStateCopyWith<$R, PesquisaAlunoState, $Out> {
  _PesquisaAlunoStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PesquisaAlunoState> $mapper =
      PesquisaAlunoStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos =>
      ListCopyWith(
        $value.alunos,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(alunos: v),
      );
  @override
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>>
  get alunosFiltrados => ListCopyWith(
    $value.alunosFiltrados,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(alunosFiltrados: v),
  );
  @override
  MapCopyWith<
    $R,
    int,
    Responsavel,
    ResponsavelCopyWith<$R, Responsavel, Responsavel>
  >
  get responsaveis => MapCopyWith(
    $value.responsaveis,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(responsaveis: v),
  );
  @override
  $R call({
    List<Aluno>? alunos,
    List<Aluno>? alunosFiltrados,
    Map<int, Responsavel>? responsaveis,
    bool? mostrarInativos,
  }) => $apply(
    FieldCopyWithData({
      if (alunos != null) #alunos: alunos,
      if (alunosFiltrados != null) #alunosFiltrados: alunosFiltrados,
      if (responsaveis != null) #responsaveis: responsaveis,
      if (mostrarInativos != null) #mostrarInativos: mostrarInativos,
    }),
  );
  @override
  PesquisaAlunoState $make(CopyWithData data) => PesquisaAlunoState(
    alunos: data.get(#alunos, or: $value.alunos),
    alunosFiltrados: data.get(#alunosFiltrados, or: $value.alunosFiltrados),
    responsaveis: data.get(#responsaveis, or: $value.responsaveis),
    mostrarInativos: data.get(#mostrarInativos, or: $value.mostrarInativos),
  );

  @override
  PesquisaAlunoStateCopyWith<$R2, PesquisaAlunoState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PesquisaAlunoStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

