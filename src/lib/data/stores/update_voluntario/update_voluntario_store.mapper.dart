// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_voluntario_store.dart';

class UpdateVoluntarioStateMapper
    extends ClassMapperBase<UpdateVoluntarioState> {
  UpdateVoluntarioStateMapper._();

  static UpdateVoluntarioStateMapper? _instance;
  static UpdateVoluntarioStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateVoluntarioStateMapper._());
      FaixaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateVoluntarioState';

  static String _$id(UpdateVoluntarioState v) => v.id;
  static const Field<UpdateVoluntarioState, String> _f$id = Field('id', _$id);
  static String _$nome(UpdateVoluntarioState v) => v.nome;
  static const Field<UpdateVoluntarioState, String> _f$nome = Field(
    'nome',
    _$nome,
    opt: true,
    def: '',
  );
  static String _$email(UpdateVoluntarioState v) => v.email;
  static const Field<UpdateVoluntarioState, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static String _$telefone(UpdateVoluntarioState v) => v.telefone;
  static const Field<UpdateVoluntarioState, String> _f$telefone = Field(
    'telefone',
    _$telefone,
    opt: true,
    def: '',
  );
  static String _$senha(UpdateVoluntarioState v) => v.senha;
  static const Field<UpdateVoluntarioState, String> _f$senha = Field(
    'senha',
    _$senha,
    opt: true,
    def: '',
  );
  static String _$cpf(UpdateVoluntarioState v) => v.cpf;
  static const Field<UpdateVoluntarioState, String> _f$cpf = Field(
    'cpf',
    _$cpf,
    opt: true,
    def: '',
  );
  static String _$funcao(UpdateVoluntarioState v) => v.funcao;
  static const Field<UpdateVoluntarioState, String> _f$funcao = Field(
    'funcao',
    _$funcao,
    opt: true,
    def: '',
  );
  static Faixa _$faixa(UpdateVoluntarioState v) => v.faixa;
  static const Field<UpdateVoluntarioState, Faixa> _f$faixa = Field(
    'faixa',
    _$faixa,
    opt: true,
    def: Faixa.branca,
  );
  static bool _$dirty(UpdateVoluntarioState v) => v.dirty;
  static const Field<UpdateVoluntarioState, bool> _f$dirty = Field(
    'dirty',
    _$dirty,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<UpdateVoluntarioState> fields = const {
    #id: _f$id,
    #nome: _f$nome,
    #email: _f$email,
    #telefone: _f$telefone,
    #senha: _f$senha,
    #cpf: _f$cpf,
    #funcao: _f$funcao,
    #faixa: _f$faixa,
    #dirty: _f$dirty,
  };

  static UpdateVoluntarioState _instantiate(DecodingData data) {
    return UpdateVoluntarioState(
      id: data.dec(_f$id),
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

  static UpdateVoluntarioState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateVoluntarioState>(map);
  }

  static UpdateVoluntarioState fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateVoluntarioState>(json);
  }
}

mixin UpdateVoluntarioStateMappable {
  String toJson() {
    return UpdateVoluntarioStateMapper.ensureInitialized()
        .encodeJson<UpdateVoluntarioState>(this as UpdateVoluntarioState);
  }

  Map<String, dynamic> toMap() {
    return UpdateVoluntarioStateMapper.ensureInitialized()
        .encodeMap<UpdateVoluntarioState>(this as UpdateVoluntarioState);
  }

  UpdateVoluntarioStateCopyWith<
    UpdateVoluntarioState,
    UpdateVoluntarioState,
    UpdateVoluntarioState
  >
  get copyWith =>
      _UpdateVoluntarioStateCopyWithImpl<
        UpdateVoluntarioState,
        UpdateVoluntarioState
      >(this as UpdateVoluntarioState, $identity, $identity);
  @override
  String toString() {
    return UpdateVoluntarioStateMapper.ensureInitialized().stringifyValue(
      this as UpdateVoluntarioState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UpdateVoluntarioStateMapper.ensureInitialized().equalsValue(
      this as UpdateVoluntarioState,
      other,
    );
  }

  @override
  int get hashCode {
    return UpdateVoluntarioStateMapper.ensureInitialized().hashValue(
      this as UpdateVoluntarioState,
    );
  }
}

extension UpdateVoluntarioStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateVoluntarioState, $Out> {
  UpdateVoluntarioStateCopyWith<$R, UpdateVoluntarioState, $Out>
  get $asUpdateVoluntarioState => $base.as(
    (v, t, t2) => _UpdateVoluntarioStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UpdateVoluntarioStateCopyWith<
  $R,
  $In extends UpdateVoluntarioState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? nome,
    String? email,
    String? telefone,
    String? senha,
    String? cpf,
    String? funcao,
    Faixa? faixa,
    bool? dirty,
  });
  UpdateVoluntarioStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UpdateVoluntarioStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateVoluntarioState, $Out>
    implements UpdateVoluntarioStateCopyWith<$R, UpdateVoluntarioState, $Out> {
  _UpdateVoluntarioStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateVoluntarioState> $mapper =
      UpdateVoluntarioStateMapper.ensureInitialized();
  @override
  $R call({
    String? id,
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
      if (id != null) #id: id,
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
  UpdateVoluntarioState $make(CopyWithData data) => UpdateVoluntarioState(
    id: data.get(#id, or: $value.id),
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
  UpdateVoluntarioStateCopyWith<$R2, UpdateVoluntarioState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UpdateVoluntarioStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

