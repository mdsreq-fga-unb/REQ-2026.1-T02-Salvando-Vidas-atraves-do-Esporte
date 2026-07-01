// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'historico_emprestimos_store.dart';

class HistoricoItemMapper extends ClassMapperBase<HistoricoItem> {
  HistoricoItemMapper._();

  static HistoricoItemMapper? _instance;
  static HistoricoItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HistoricoItemMapper._());
      EmprestimoMapper.ensureInitialized();
      AlunoMapper.ensureInitialized();
      LocalUserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HistoricoItem';

  static Emprestimo _$emprestimo(HistoricoItem v) => v.emprestimo;
  static const Field<HistoricoItem, Emprestimo> _f$emprestimo = Field(
    'emprestimo',
    _$emprestimo,
  );
  static Aluno? _$aluno(HistoricoItem v) => v.aluno;
  static const Field<HistoricoItem, Aluno> _f$aluno = Field(
    'aluno',
    _$aluno,
    opt: true,
  );
  static LocalUser? _$voluntario(HistoricoItem v) => v.voluntario;
  static const Field<HistoricoItem, LocalUser> _f$voluntario = Field(
    'voluntario',
    _$voluntario,
    opt: true,
  );

  @override
  final MappableFields<HistoricoItem> fields = const {
    #emprestimo: _f$emprestimo,
    #aluno: _f$aluno,
    #voluntario: _f$voluntario,
  };

  static HistoricoItem _instantiate(DecodingData data) {
    return HistoricoItem(
      emprestimo: data.dec(_f$emprestimo),
      aluno: data.dec(_f$aluno),
      voluntario: data.dec(_f$voluntario),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HistoricoItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HistoricoItem>(map);
  }

  static HistoricoItem fromJson(String json) {
    return ensureInitialized().decodeJson<HistoricoItem>(json);
  }
}

mixin HistoricoItemMappable {
  String toJson() {
    return HistoricoItemMapper.ensureInitialized().encodeJson<HistoricoItem>(
      this as HistoricoItem,
    );
  }

  Map<String, dynamic> toMap() {
    return HistoricoItemMapper.ensureInitialized().encodeMap<HistoricoItem>(
      this as HistoricoItem,
    );
  }

  HistoricoItemCopyWith<HistoricoItem, HistoricoItem, HistoricoItem>
  get copyWith => _HistoricoItemCopyWithImpl<HistoricoItem, HistoricoItem>(
    this as HistoricoItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return HistoricoItemMapper.ensureInitialized().stringifyValue(
      this as HistoricoItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return HistoricoItemMapper.ensureInitialized().equalsValue(
      this as HistoricoItem,
      other,
    );
  }

  @override
  int get hashCode {
    return HistoricoItemMapper.ensureInitialized().hashValue(
      this as HistoricoItem,
    );
  }
}

extension HistoricoItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HistoricoItem, $Out> {
  HistoricoItemCopyWith<$R, HistoricoItem, $Out> get $asHistoricoItem =>
      $base.as((v, t, t2) => _HistoricoItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HistoricoItemCopyWith<$R, $In extends HistoricoItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  EmprestimoCopyWith<$R, Emprestimo, Emprestimo> get emprestimo;
  AlunoCopyWith<$R, Aluno, Aluno>? get aluno;
  LocalUserCopyWith<$R, LocalUser, LocalUser>? get voluntario;
  $R call({Emprestimo? emprestimo, Aluno? aluno, LocalUser? voluntario});
  HistoricoItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HistoricoItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HistoricoItem, $Out>
    implements HistoricoItemCopyWith<$R, HistoricoItem, $Out> {
  _HistoricoItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HistoricoItem> $mapper =
      HistoricoItemMapper.ensureInitialized();
  @override
  EmprestimoCopyWith<$R, Emprestimo, Emprestimo> get emprestimo =>
      $value.emprestimo.copyWith.$chain((v) => call(emprestimo: v));
  @override
  AlunoCopyWith<$R, Aluno, Aluno>? get aluno =>
      $value.aluno?.copyWith.$chain((v) => call(aluno: v));
  @override
  LocalUserCopyWith<$R, LocalUser, LocalUser>? get voluntario =>
      $value.voluntario?.copyWith.$chain((v) => call(voluntario: v));
  @override
  $R call({
    Emprestimo? emprestimo,
    Object? aluno = $none,
    Object? voluntario = $none,
  }) => $apply(
    FieldCopyWithData({
      if (emprestimo != null) #emprestimo: emprestimo,
      if (aluno != $none) #aluno: aluno,
      if (voluntario != $none) #voluntario: voluntario,
    }),
  );
  @override
  HistoricoItem $make(CopyWithData data) => HistoricoItem(
    emprestimo: data.get(#emprestimo, or: $value.emprestimo),
    aluno: data.get(#aluno, or: $value.aluno),
    voluntario: data.get(#voluntario, or: $value.voluntario),
  );

  @override
  HistoricoItemCopyWith<$R2, HistoricoItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HistoricoItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HistoricoEmprestimosStateMapper
    extends ClassMapperBase<HistoricoEmprestimosState> {
  HistoricoEmprestimosStateMapper._();

  static HistoricoEmprestimosStateMapper? _instance;
  static HistoricoEmprestimosStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = HistoricoEmprestimosStateMapper._(),
      );
      HistoricoItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HistoricoEmprestimosState';

  static List<HistoricoItem> _$itens(HistoricoEmprestimosState v) => v.itens;
  static const Field<HistoricoEmprestimosState, List<HistoricoItem>> _f$itens =
      Field('itens', _$itens);
  static List<HistoricoItem> _$itensFiltrados(HistoricoEmprestimosState v) =>
      v.itensFiltrados;
  static const Field<HistoricoEmprestimosState, List<HistoricoItem>>
  _f$itensFiltrados = Field(
    'itensFiltrados',
    _$itensFiltrados,
    key: r'itens_filtrados',
  );
  static String _$filtroTipo(HistoricoEmprestimosState v) => v.filtroTipo;
  static const Field<HistoricoEmprestimosState, String> _f$filtroTipo = Field(
    'filtroTipo',
    _$filtroTipo,
    key: r'filtro_tipo',
    opt: true,
    def: 'todos',
  );

  @override
  final MappableFields<HistoricoEmprestimosState> fields = const {
    #itens: _f$itens,
    #itensFiltrados: _f$itensFiltrados,
    #filtroTipo: _f$filtroTipo,
  };

  static HistoricoEmprestimosState _instantiate(DecodingData data) {
    return HistoricoEmprestimosState(
      itens: data.dec(_f$itens),
      itensFiltrados: data.dec(_f$itensFiltrados),
      filtroTipo: data.dec(_f$filtroTipo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HistoricoEmprestimosState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HistoricoEmprestimosState>(map);
  }

  static HistoricoEmprestimosState fromJson(String json) {
    return ensureInitialized().decodeJson<HistoricoEmprestimosState>(json);
  }
}

mixin HistoricoEmprestimosStateMappable {
  String toJson() {
    return HistoricoEmprestimosStateMapper.ensureInitialized()
        .encodeJson<HistoricoEmprestimosState>(
          this as HistoricoEmprestimosState,
        );
  }

  Map<String, dynamic> toMap() {
    return HistoricoEmprestimosStateMapper.ensureInitialized()
        .encodeMap<HistoricoEmprestimosState>(
          this as HistoricoEmprestimosState,
        );
  }

  HistoricoEmprestimosStateCopyWith<
    HistoricoEmprestimosState,
    HistoricoEmprestimosState,
    HistoricoEmprestimosState
  >
  get copyWith =>
      _HistoricoEmprestimosStateCopyWithImpl<
        HistoricoEmprestimosState,
        HistoricoEmprestimosState
      >(this as HistoricoEmprestimosState, $identity, $identity);
  @override
  String toString() {
    return HistoricoEmprestimosStateMapper.ensureInitialized().stringifyValue(
      this as HistoricoEmprestimosState,
    );
  }

  @override
  bool operator ==(Object other) {
    return HistoricoEmprestimosStateMapper.ensureInitialized().equalsValue(
      this as HistoricoEmprestimosState,
      other,
    );
  }

  @override
  int get hashCode {
    return HistoricoEmprestimosStateMapper.ensureInitialized().hashValue(
      this as HistoricoEmprestimosState,
    );
  }
}

extension HistoricoEmprestimosStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HistoricoEmprestimosState, $Out> {
  HistoricoEmprestimosStateCopyWith<$R, HistoricoEmprestimosState, $Out>
  get $asHistoricoEmprestimosState => $base.as(
    (v, t, t2) => _HistoricoEmprestimosStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HistoricoEmprestimosStateCopyWith<
  $R,
  $In extends HistoricoEmprestimosState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    HistoricoItem,
    HistoricoItemCopyWith<$R, HistoricoItem, HistoricoItem>
  >
  get itens;
  ListCopyWith<
    $R,
    HistoricoItem,
    HistoricoItemCopyWith<$R, HistoricoItem, HistoricoItem>
  >
  get itensFiltrados;
  $R call({
    List<HistoricoItem>? itens,
    List<HistoricoItem>? itensFiltrados,
    String? filtroTipo,
  });
  HistoricoEmprestimosStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HistoricoEmprestimosStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HistoricoEmprestimosState, $Out>
    implements
        HistoricoEmprestimosStateCopyWith<$R, HistoricoEmprestimosState, $Out> {
  _HistoricoEmprestimosStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HistoricoEmprestimosState> $mapper =
      HistoricoEmprestimosStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    HistoricoItem,
    HistoricoItemCopyWith<$R, HistoricoItem, HistoricoItem>
  >
  get itens => ListCopyWith(
    $value.itens,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(itens: v),
  );
  @override
  ListCopyWith<
    $R,
    HistoricoItem,
    HistoricoItemCopyWith<$R, HistoricoItem, HistoricoItem>
  >
  get itensFiltrados => ListCopyWith(
    $value.itensFiltrados,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(itensFiltrados: v),
  );
  @override
  $R call({
    List<HistoricoItem>? itens,
    List<HistoricoItem>? itensFiltrados,
    String? filtroTipo,
  }) => $apply(
    FieldCopyWithData({
      if (itens != null) #itens: itens,
      if (itensFiltrados != null) #itensFiltrados: itensFiltrados,
      if (filtroTipo != null) #filtroTipo: filtroTipo,
    }),
  );
  @override
  HistoricoEmprestimosState $make(CopyWithData data) =>
      HistoricoEmprestimosState(
        itens: data.get(#itens, or: $value.itens),
        itensFiltrados: data.get(#itensFiltrados, or: $value.itensFiltrados),
        filtroTipo: data.get(#filtroTipo, or: $value.filtroTipo),
      );

  @override
  HistoricoEmprestimosStateCopyWith<$R2, HistoricoEmprestimosState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HistoricoEmprestimosStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

