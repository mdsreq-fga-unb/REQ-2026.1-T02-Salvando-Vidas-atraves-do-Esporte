// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'gestao_kimonos_store.dart';

class GestaoKimonosStateMapper extends ClassMapperBase<GestaoKimonosState> {
  GestaoKimonosStateMapper._();

  static GestaoKimonosStateMapper? _instance;
  static GestaoKimonosStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GestaoKimonosStateMapper._());
      EstoqueMapper.ensureInitialized();
      DoacaoMapper.ensureInitialized();
      PerdaMapper.ensureInitialized();
      EmprestimoMapper.ensureInitialized();
      AlunoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GestaoKimonosState';

  static List<Estoque> _$estoque(GestaoKimonosState v) => v.estoque;
  static const Field<GestaoKimonosState, List<Estoque>> _f$estoque = Field(
    'estoque',
    _$estoque,
  );
  static List<Doacao> _$doacoes(GestaoKimonosState v) => v.doacoes;
  static const Field<GestaoKimonosState, List<Doacao>> _f$doacoes = Field(
    'doacoes',
    _$doacoes,
  );
  static List<Perda> _$perdas(GestaoKimonosState v) => v.perdas;
  static const Field<GestaoKimonosState, List<Perda>> _f$perdas = Field(
    'perdas',
    _$perdas,
  );
  static List<Emprestimo> _$emprestimos(GestaoKimonosState v) => v.emprestimos;
  static const Field<GestaoKimonosState, List<Emprestimo>> _f$emprestimos =
      Field('emprestimos', _$emprestimos);
  static Map<int, Aluno> _$alunos(GestaoKimonosState v) => v.alunos;
  static const Field<GestaoKimonosState, Map<int, Aluno>> _f$alunos = Field(
    'alunos',
    _$alunos,
  );

  @override
  final MappableFields<GestaoKimonosState> fields = const {
    #estoque: _f$estoque,
    #doacoes: _f$doacoes,
    #perdas: _f$perdas,
    #emprestimos: _f$emprestimos,
    #alunos: _f$alunos,
  };

  static GestaoKimonosState _instantiate(DecodingData data) {
    return GestaoKimonosState(
      estoque: data.dec(_f$estoque),
      doacoes: data.dec(_f$doacoes),
      perdas: data.dec(_f$perdas),
      emprestimos: data.dec(_f$emprestimos),
      alunos: data.dec(_f$alunos),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GestaoKimonosState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GestaoKimonosState>(map);
  }

  static GestaoKimonosState fromJson(String json) {
    return ensureInitialized().decodeJson<GestaoKimonosState>(json);
  }
}

mixin GestaoKimonosStateMappable {
  String toJson() {
    return GestaoKimonosStateMapper.ensureInitialized()
        .encodeJson<GestaoKimonosState>(this as GestaoKimonosState);
  }

  Map<String, dynamic> toMap() {
    return GestaoKimonosStateMapper.ensureInitialized()
        .encodeMap<GestaoKimonosState>(this as GestaoKimonosState);
  }

  GestaoKimonosStateCopyWith<
    GestaoKimonosState,
    GestaoKimonosState,
    GestaoKimonosState
  >
  get copyWith =>
      _GestaoKimonosStateCopyWithImpl<GestaoKimonosState, GestaoKimonosState>(
        this as GestaoKimonosState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GestaoKimonosStateMapper.ensureInitialized().stringifyValue(
      this as GestaoKimonosState,
    );
  }

  @override
  bool operator ==(Object other) {
    return GestaoKimonosStateMapper.ensureInitialized().equalsValue(
      this as GestaoKimonosState,
      other,
    );
  }

  @override
  int get hashCode {
    return GestaoKimonosStateMapper.ensureInitialized().hashValue(
      this as GestaoKimonosState,
    );
  }
}

extension GestaoKimonosStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GestaoKimonosState, $Out> {
  GestaoKimonosStateCopyWith<$R, GestaoKimonosState, $Out>
  get $asGestaoKimonosState => $base.as(
    (v, t, t2) => _GestaoKimonosStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GestaoKimonosStateCopyWith<
  $R,
  $In extends GestaoKimonosState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Estoque, EstoqueCopyWith<$R, Estoque, Estoque>> get estoque;
  ListCopyWith<$R, Doacao, DoacaoCopyWith<$R, Doacao, Doacao>> get doacoes;
  ListCopyWith<$R, Perda, PerdaCopyWith<$R, Perda, Perda>> get perdas;
  ListCopyWith<$R, Emprestimo, EmprestimoCopyWith<$R, Emprestimo, Emprestimo>>
  get emprestimos;
  MapCopyWith<$R, int, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos;
  $R call({
    List<Estoque>? estoque,
    List<Doacao>? doacoes,
    List<Perda>? perdas,
    List<Emprestimo>? emprestimos,
    Map<int, Aluno>? alunos,
  });
  GestaoKimonosStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GestaoKimonosStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GestaoKimonosState, $Out>
    implements GestaoKimonosStateCopyWith<$R, GestaoKimonosState, $Out> {
  _GestaoKimonosStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GestaoKimonosState> $mapper =
      GestaoKimonosStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Estoque, EstoqueCopyWith<$R, Estoque, Estoque>>
  get estoque => ListCopyWith(
    $value.estoque,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(estoque: v),
  );
  @override
  ListCopyWith<$R, Doacao, DoacaoCopyWith<$R, Doacao, Doacao>> get doacoes =>
      ListCopyWith(
        $value.doacoes,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(doacoes: v),
      );
  @override
  ListCopyWith<$R, Perda, PerdaCopyWith<$R, Perda, Perda>> get perdas =>
      ListCopyWith(
        $value.perdas,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(perdas: v),
      );
  @override
  ListCopyWith<$R, Emprestimo, EmprestimoCopyWith<$R, Emprestimo, Emprestimo>>
  get emprestimos => ListCopyWith(
    $value.emprestimos,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(emprestimos: v),
  );
  @override
  MapCopyWith<$R, int, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos =>
      MapCopyWith(
        $value.alunos,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(alunos: v),
      );
  @override
  $R call({
    List<Estoque>? estoque,
    List<Doacao>? doacoes,
    List<Perda>? perdas,
    List<Emprestimo>? emprestimos,
    Map<int, Aluno>? alunos,
  }) => $apply(
    FieldCopyWithData({
      if (estoque != null) #estoque: estoque,
      if (doacoes != null) #doacoes: doacoes,
      if (perdas != null) #perdas: perdas,
      if (emprestimos != null) #emprestimos: emprestimos,
      if (alunos != null) #alunos: alunos,
    }),
  );
  @override
  GestaoKimonosState $make(CopyWithData data) => GestaoKimonosState(
    estoque: data.get(#estoque, or: $value.estoque),
    doacoes: data.get(#doacoes, or: $value.doacoes),
    perdas: data.get(#perdas, or: $value.perdas),
    emprestimos: data.get(#emprestimos, or: $value.emprestimos),
    alunos: data.get(#alunos, or: $value.alunos),
  );

  @override
  GestaoKimonosStateCopyWith<$R2, GestaoKimonosState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GestaoKimonosStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

