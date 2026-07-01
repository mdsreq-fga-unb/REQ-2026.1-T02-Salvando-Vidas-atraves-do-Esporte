// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'gestao_emprestimos_store.dart';

class GestaoEmprestimosStateMapper
    extends ClassMapperBase<GestaoEmprestimosState> {
  GestaoEmprestimosStateMapper._();

  static GestaoEmprestimosStateMapper? _instance;
  static GestaoEmprestimosStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GestaoEmprestimosStateMapper._());
      AlunoMapper.ensureInitialized();
      EmprestimoMapper.ensureInitialized();
      EstoqueMapper.ensureInitialized();
      TamanhoKimonoMapper.ensureInitialized();
      CorKimonoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GestaoEmprestimosState';

  static List<Aluno> _$alunos(GestaoEmprestimosState v) => v.alunos;
  static const Field<GestaoEmprestimosState, List<Aluno>> _f$alunos = Field(
    'alunos',
    _$alunos,
  );
  static List<Aluno> _$alunosFiltrados(GestaoEmprestimosState v) =>
      v.alunosFiltrados;
  static const Field<GestaoEmprestimosState, List<Aluno>> _f$alunosFiltrados =
      Field('alunosFiltrados', _$alunosFiltrados, key: r'alunos_filtrados');
  static List<Emprestimo> _$emprestimos(GestaoEmprestimosState v) =>
      v.emprestimos;
  static const Field<GestaoEmprestimosState, List<Emprestimo>> _f$emprestimos =
      Field('emprestimos', _$emprestimos);
  static List<Estoque> _$estoque(GestaoEmprestimosState v) => v.estoque;
  static const Field<GestaoEmprestimosState, List<Estoque>> _f$estoque = Field(
    'estoque',
    _$estoque,
  );
  static List<Estoque> _$estoqueFiltrado(GestaoEmprestimosState v) =>
      v.estoqueFiltrado;
  static const Field<GestaoEmprestimosState, List<Estoque>> _f$estoqueFiltrado =
      Field('estoqueFiltrado', _$estoqueFiltrado, key: r'estoque_filtrado');
  static TamanhoKimono? _$tamanho(GestaoEmprestimosState v) => v.tamanho;
  static const Field<GestaoEmprestimosState, TamanhoKimono> _f$tamanho = Field(
    'tamanho',
    _$tamanho,
    opt: true,
  );
  static CorKimono? _$cor(GestaoEmprestimosState v) => v.cor;
  static const Field<GestaoEmprestimosState, CorKimono> _f$cor = Field(
    'cor',
    _$cor,
    opt: true,
  );
  static Estoque? _$kimono(GestaoEmprestimosState v) => v.kimono;
  static const Field<GestaoEmprestimosState, Estoque> _f$kimono = Field(
    'kimono',
    _$kimono,
    opt: true,
  );

  @override
  final MappableFields<GestaoEmprestimosState> fields = const {
    #alunos: _f$alunos,
    #alunosFiltrados: _f$alunosFiltrados,
    #emprestimos: _f$emprestimos,
    #estoque: _f$estoque,
    #estoqueFiltrado: _f$estoqueFiltrado,
    #tamanho: _f$tamanho,
    #cor: _f$cor,
    #kimono: _f$kimono,
  };

  static GestaoEmprestimosState _instantiate(DecodingData data) {
    return GestaoEmprestimosState(
      alunos: data.dec(_f$alunos),
      alunosFiltrados: data.dec(_f$alunosFiltrados),
      emprestimos: data.dec(_f$emprestimos),
      estoque: data.dec(_f$estoque),
      estoqueFiltrado: data.dec(_f$estoqueFiltrado),
      tamanho: data.dec(_f$tamanho),
      cor: data.dec(_f$cor),
      kimono: data.dec(_f$kimono),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GestaoEmprestimosState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GestaoEmprestimosState>(map);
  }

  static GestaoEmprestimosState fromJson(String json) {
    return ensureInitialized().decodeJson<GestaoEmprestimosState>(json);
  }
}

mixin GestaoEmprestimosStateMappable {
  String toJson() {
    return GestaoEmprestimosStateMapper.ensureInitialized()
        .encodeJson<GestaoEmprestimosState>(this as GestaoEmprestimosState);
  }

  Map<String, dynamic> toMap() {
    return GestaoEmprestimosStateMapper.ensureInitialized()
        .encodeMap<GestaoEmprestimosState>(this as GestaoEmprestimosState);
  }

  GestaoEmprestimosStateCopyWith<
    GestaoEmprestimosState,
    GestaoEmprestimosState,
    GestaoEmprestimosState
  >
  get copyWith =>
      _GestaoEmprestimosStateCopyWithImpl<
        GestaoEmprestimosState,
        GestaoEmprestimosState
      >(this as GestaoEmprestimosState, $identity, $identity);
  @override
  String toString() {
    return GestaoEmprestimosStateMapper.ensureInitialized().stringifyValue(
      this as GestaoEmprestimosState,
    );
  }

  @override
  bool operator ==(Object other) {
    return GestaoEmprestimosStateMapper.ensureInitialized().equalsValue(
      this as GestaoEmprestimosState,
      other,
    );
  }

  @override
  int get hashCode {
    return GestaoEmprestimosStateMapper.ensureInitialized().hashValue(
      this as GestaoEmprestimosState,
    );
  }
}

extension GestaoEmprestimosStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GestaoEmprestimosState, $Out> {
  GestaoEmprestimosStateCopyWith<$R, GestaoEmprestimosState, $Out>
  get $asGestaoEmprestimosState => $base.as(
    (v, t, t2) => _GestaoEmprestimosStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GestaoEmprestimosStateCopyWith<
  $R,
  $In extends GestaoEmprestimosState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos;
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunosFiltrados;
  ListCopyWith<$R, Emprestimo, EmprestimoCopyWith<$R, Emprestimo, Emprestimo>>
  get emprestimos;
  ListCopyWith<$R, Estoque, EstoqueCopyWith<$R, Estoque, Estoque>> get estoque;
  ListCopyWith<$R, Estoque, EstoqueCopyWith<$R, Estoque, Estoque>>
  get estoqueFiltrado;
  EstoqueCopyWith<$R, Estoque, Estoque>? get kimono;
  $R call({
    List<Aluno>? alunos,
    List<Aluno>? alunosFiltrados,
    List<Emprestimo>? emprestimos,
    List<Estoque>? estoque,
    List<Estoque>? estoqueFiltrado,
    TamanhoKimono? tamanho,
    CorKimono? cor,
    Estoque? kimono,
  });
  GestaoEmprestimosStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GestaoEmprestimosStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GestaoEmprestimosState, $Out>
    implements
        GestaoEmprestimosStateCopyWith<$R, GestaoEmprestimosState, $Out> {
  _GestaoEmprestimosStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GestaoEmprestimosState> $mapper =
      GestaoEmprestimosStateMapper.ensureInitialized();
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
  ListCopyWith<$R, Emprestimo, EmprestimoCopyWith<$R, Emprestimo, Emprestimo>>
  get emprestimos => ListCopyWith(
    $value.emprestimos,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(emprestimos: v),
  );
  @override
  ListCopyWith<$R, Estoque, EstoqueCopyWith<$R, Estoque, Estoque>>
  get estoque => ListCopyWith(
    $value.estoque,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(estoque: v),
  );
  @override
  ListCopyWith<$R, Estoque, EstoqueCopyWith<$R, Estoque, Estoque>>
  get estoqueFiltrado => ListCopyWith(
    $value.estoqueFiltrado,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(estoqueFiltrado: v),
  );
  @override
  EstoqueCopyWith<$R, Estoque, Estoque>? get kimono =>
      $value.kimono?.copyWith.$chain((v) => call(kimono: v));
  @override
  $R call({
    List<Aluno>? alunos,
    List<Aluno>? alunosFiltrados,
    List<Emprestimo>? emprestimos,
    List<Estoque>? estoque,
    List<Estoque>? estoqueFiltrado,
    Object? tamanho = $none,
    Object? cor = $none,
    Object? kimono = $none,
  }) => $apply(
    FieldCopyWithData({
      if (alunos != null) #alunos: alunos,
      if (alunosFiltrados != null) #alunosFiltrados: alunosFiltrados,
      if (emprestimos != null) #emprestimos: emprestimos,
      if (estoque != null) #estoque: estoque,
      if (estoqueFiltrado != null) #estoqueFiltrado: estoqueFiltrado,
      if (tamanho != $none) #tamanho: tamanho,
      if (cor != $none) #cor: cor,
      if (kimono != $none) #kimono: kimono,
    }),
  );
  @override
  GestaoEmprestimosState $make(CopyWithData data) => GestaoEmprestimosState(
    alunos: data.get(#alunos, or: $value.alunos),
    alunosFiltrados: data.get(#alunosFiltrados, or: $value.alunosFiltrados),
    emprestimos: data.get(#emprestimos, or: $value.emprestimos),
    estoque: data.get(#estoque, or: $value.estoque),
    estoqueFiltrado: data.get(#estoqueFiltrado, or: $value.estoqueFiltrado),
    tamanho: data.get(#tamanho, or: $value.tamanho),
    cor: data.get(#cor, or: $value.cor),
    kimono: data.get(#kimono, or: $value.kimono),
  );

  @override
  GestaoEmprestimosStateCopyWith<$R2, GestaoEmprestimosState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GestaoEmprestimosStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

