// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cadastro_voluntario_form.dart';

class CadastroVoluntarioStateMapper
    extends ClassMapperBase<CadastroVoluntarioState> {
  CadastroVoluntarioStateMapper._();

  static CadastroVoluntarioStateMapper? _instance;
  static CadastroVoluntarioStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CadastroVoluntarioStateMapper._(),
      );
      FaixaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CadastroVoluntarioState';

  static String _$nome(CadastroVoluntarioState v) => v.nome;
  static const Field<CadastroVoluntarioState, String> _f$nome = Field(
    'nome',
    _$nome,
    opt: true,
    def: '',
  );
  static String _$email(CadastroVoluntarioState v) => v.email;
  static const Field<CadastroVoluntarioState, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static String _$telefone(CadastroVoluntarioState v) => v.telefone;
  static const Field<CadastroVoluntarioState, String> _f$telefone = Field(
    'telefone',
    _$telefone,
    opt: true,
    def: '',
  );
  static String _$senha(CadastroVoluntarioState v) => v.senha;
  static const Field<CadastroVoluntarioState, String> _f$senha = Field(
    'senha',
    _$senha,
    opt: true,
    def: '',
  );
  static String _$cpf(CadastroVoluntarioState v) => v.cpf;
  static const Field<CadastroVoluntarioState, String> _f$cpf = Field(
    'cpf',
    _$cpf,
    opt: true,
    def: '',
  );
  static String _$funcao(CadastroVoluntarioState v) => v.funcao;
  static const Field<CadastroVoluntarioState, String> _f$funcao = Field(
    'funcao',
    _$funcao,
    opt: true,
    def: '',
  );
  static Faixa _$faixa(CadastroVoluntarioState v) => v.faixa;
  static const Field<CadastroVoluntarioState, Faixa> _f$faixa = Field(
    'faixa',
    _$faixa,
    opt: true,
    def: Faixa.branca,
  );
  static bool _$dirty(CadastroVoluntarioState v) => v.dirty;
  static const Field<CadastroVoluntarioState, bool> _f$dirty = Field(
    'dirty',
    _$dirty,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<CadastroVoluntarioState> fields = const {
    #nome: _f$nome,
    #email: _f$email,
    #telefone: _f$telefone,
    #senha: _f$senha,
    #cpf: _f$cpf,
    #funcao: _f$funcao,
    #faixa: _f$faixa,
    #dirty: _f$dirty,
  };

  static CadastroVoluntarioState _instantiate(DecodingData data) {
    return CadastroVoluntarioState(
      nome: data.dec(_f$nome),
      email: data.dec(_f$email),
      telefone: data.dec(_f$telefone),
      senha: data.dec(_f$senha),
      cpf: data.dec(_f$cpf),
      funcao: data.dec(_f$funcao),
      faixa: data.dec(_f$faixa),
      dirty: data.dec(_f$dirty),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CadastroVoluntarioState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CadastroVoluntarioState>(map);
  }

  static CadastroVoluntarioState fromJson(String json) {
    return ensureInitialized().decodeJson<CadastroVoluntarioState>(json);
  }
}

mixin CadastroVoluntarioStateMappable {
  String toJson() {
    return CadastroVoluntarioStateMapper.ensureInitialized()
        .encodeJson<CadastroVoluntarioState>(this as CadastroVoluntarioState);
  }

  Map<String, dynamic> toMap() {
    return CadastroVoluntarioStateMapper.ensureInitialized()
        .encodeMap<CadastroVoluntarioState>(this as CadastroVoluntarioState);
  }

  CadastroVoluntarioStateCopyWith<
    CadastroVoluntarioState,
    CadastroVoluntarioState,
    CadastroVoluntarioState
  >
  get copyWith =>
      _CadastroVoluntarioStateCopyWithImpl<
        CadastroVoluntarioState,
        CadastroVoluntarioState
      >(this as CadastroVoluntarioState, $identity, $identity);
  @override
  String toString() {
    return CadastroVoluntarioStateMapper.ensureInitialized().stringifyValue(
      this as CadastroVoluntarioState,
    );
  }

  @override
  bool operator ==(Object other) {
    return CadastroVoluntarioStateMapper.ensureInitialized().equalsValue(
      this as CadastroVoluntarioState,
      other,
    );
  }

  @override
  int get hashCode {
    return CadastroVoluntarioStateMapper.ensureInitialized().hashValue(
      this as CadastroVoluntarioState,
    );
  }
}

extension CadastroVoluntarioStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CadastroVoluntarioState, $Out> {
  CadastroVoluntarioStateCopyWith<$R, CadastroVoluntarioState, $Out>
  get $asCadastroVoluntarioState => $base.as(
    (v, t, t2) => _CadastroVoluntarioStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CadastroVoluntarioStateCopyWith<
  $R,
  $In extends CadastroVoluntarioState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? nome,
    String? email,
    String? telefone,
    String? senha,
    String? cpf,
    String? funcao,
    Faixa? faixa,
    bool? dirty,
  });
  CadastroVoluntarioStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CadastroVoluntarioStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CadastroVoluntarioState, $Out>
    implements
        CadastroVoluntarioStateCopyWith<$R, CadastroVoluntarioState, $Out> {
  _CadastroVoluntarioStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CadastroVoluntarioState> $mapper =
      CadastroVoluntarioStateMapper.ensureInitialized();
  @override
  $R call({
    String? nome,
    String? email,
    String? telefone,
    String? senha,
    String? cpf,
    String? funcao,
    Faixa? faixa,
    bool? dirty,
  }) => $apply(
    FieldCopyWithData({
      if (nome != null) #nome: nome,
      if (email != null) #email: email,
      if (telefone != null) #telefone: telefone,
      if (senha != null) #senha: senha,
      if (cpf != null) #cpf: cpf,
      if (funcao != null) #funcao: funcao,
      if (faixa != null) #faixa: faixa,
      if (dirty != null) #dirty: dirty,
    }),
  );
  @override
  CadastroVoluntarioState $make(CopyWithData data) => CadastroVoluntarioState(
    nome: data.get(#nome, or: $value.nome),
    email: data.get(#email, or: $value.email),
    telefone: data.get(#telefone, or: $value.telefone),
    senha: data.get(#senha, or: $value.senha),
    cpf: data.get(#cpf, or: $value.cpf),
    funcao: data.get(#funcao, or: $value.funcao),
    faixa: data.get(#faixa, or: $value.faixa),
    dirty: data.get(#dirty, or: $value.dirty),
  );

  @override
  CadastroVoluntarioStateCopyWith<$R2, CadastroVoluntarioState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CadastroVoluntarioStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

