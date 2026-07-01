// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_user.dart';

class RoleMapper extends EnumMapper<Role> {
  RoleMapper._();

  static RoleMapper? _instance;
  static RoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RoleMapper._());
    }
    return _instance!;
  }

  static Role fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Role decode(dynamic value) {
    switch (value) {
      case r'voluntario':
        return Role.voluntario;
      case r'admin':
        return Role.admin;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Role self) {
    switch (self) {
      case Role.voluntario:
        return r'voluntario';
      case Role.admin:
        return r'admin';
    }
  }
}

extension RoleMapperExtension on Role {
  String toValue() {
    RoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Role>(this) as String;
  }
}

class LocalUserMapper extends ClassMapperBase<LocalUser> {
  LocalUserMapper._();

  static LocalUserMapper? _instance;
  static LocalUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalUserMapper._());
      RoleMapper.ensureInitialized();
      FaixaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalUser';

  static String? _$id(LocalUser v) => v.id;
  static const Field<LocalUser, String> _f$id = Field('id', _$id, opt: true);
  static Role _$role(LocalUser v) => v.role;
  static const Field<LocalUser, Role> _f$role = Field('role', _$role);
  static String _$nome(LocalUser v) => v.nome;
  static const Field<LocalUser, String> _f$nome = Field('nome', _$nome);
  static String _$telefone(LocalUser v) => v.telefone;
  static const Field<LocalUser, String> _f$telefone = Field(
    'telefone',
    _$telefone,
  );
  static String _$cpf(LocalUser v) => v.cpf;
  static const Field<LocalUser, String> _f$cpf = Field(
    'cpf',
    _$cpf,
    opt: true,
    def: '',
  );
  static String _$email(LocalUser v) => v.email;
  static const Field<LocalUser, String> _f$email = Field('email', _$email);
  static String? _$senha(LocalUser v) => v.senha;
  static const Field<LocalUser, String> _f$senha = Field(
    'senha',
    _$senha,
    opt: true,
  );
  static String _$funcao(LocalUser v) => v.funcao;
  static const Field<LocalUser, String> _f$funcao = Field(
    'funcao',
    _$funcao,
    opt: true,
    def: '',
  );
  static Faixa _$faixa(LocalUser v) => v.faixa;
  static const Field<LocalUser, Faixa> _f$faixa = Field('faixa', _$faixa);
  static bool _$ativo(LocalUser v) => v.ativo;
  static const Field<LocalUser, bool> _f$ativo = Field(
    'ativo',
    _$ativo,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<LocalUser> fields = const {
    #id: _f$id,
    #role: _f$role,
    #nome: _f$nome,
    #telefone: _f$telefone,
    #cpf: _f$cpf,
    #email: _f$email,
    #senha: _f$senha,
    #funcao: _f$funcao,
    #faixa: _f$faixa,
    #ativo: _f$ativo,
  };

  static LocalUser _instantiate(DecodingData data) {
    return LocalUser(
      id: data.dec(_f$id),
      role: data.dec(_f$role),
      nome: data.dec(_f$nome),
      telefone: data.dec(_f$telefone),
      cpf: data.dec(_f$cpf),
      email: data.dec(_f$email),
      senha: data.dec(_f$senha),
      funcao: data.dec(_f$funcao),
      faixa: data.dec(_f$faixa),
      ativo: data.dec(_f$ativo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalUser>(map);
  }

  static LocalUser fromJson(String json) {
    return ensureInitialized().decodeJson<LocalUser>(json);
  }
}

mixin LocalUserMappable {
  String toJson() {
    return LocalUserMapper.ensureInitialized().encodeJson<LocalUser>(
      this as LocalUser,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalUserMapper.ensureInitialized().encodeMap<LocalUser>(
      this as LocalUser,
    );
  }

  LocalUserCopyWith<LocalUser, LocalUser, LocalUser> get copyWith =>
      _LocalUserCopyWithImpl<LocalUser, LocalUser>(
        this as LocalUser,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalUserMapper.ensureInitialized().stringifyValue(
      this as LocalUser,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalUserMapper.ensureInitialized().equalsValue(
      this as LocalUser,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalUserMapper.ensureInitialized().hashValue(this as LocalUser);
  }
}

extension LocalUserValueCopy<$R, $Out> on ObjectCopyWith<$R, LocalUser, $Out> {
  LocalUserCopyWith<$R, LocalUser, $Out> get $asLocalUser =>
      $base.as((v, t, t2) => _LocalUserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalUserCopyWith<$R, $In extends LocalUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    Role? role,
    String? nome,
    String? telefone,
    String? cpf,
    String? email,
    String? senha,
    String? funcao,
    Faixa? faixa,
    bool? ativo,
  });
  LocalUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalUser, $Out>
    implements LocalUserCopyWith<$R, LocalUser, $Out> {
  _LocalUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalUser> $mapper =
      LocalUserMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Role? role,
    String? nome,
    String? telefone,
    String? cpf,
    String? email,
    Object? senha = $none,
    String? funcao,
    Faixa? faixa,
    bool? ativo,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (role != null) #role: role,
      if (nome != null) #nome: nome,
      if (telefone != null) #telefone: telefone,
      if (cpf != null) #cpf: cpf,
      if (email != null) #email: email,
      if (senha != $none) #senha: senha,
      if (funcao != null) #funcao: funcao,
      if (faixa != null) #faixa: faixa,
      if (ativo != null) #ativo: ativo,
    }),
  );
  @override
  LocalUser $make(CopyWithData data) => LocalUser(
    id: data.get(#id, or: $value.id),
    role: data.get(#role, or: $value.role),
    nome: data.get(#nome, or: $value.nome),
    telefone: data.get(#telefone, or: $value.telefone),
    cpf: data.get(#cpf, or: $value.cpf),
    email: data.get(#email, or: $value.email),
    senha: data.get(#senha, or: $value.senha),
    funcao: data.get(#funcao, or: $value.funcao),
    faixa: data.get(#faixa, or: $value.faixa),
    ativo: data.get(#ativo, or: $value.ativo),
  );

  @override
  LocalUserCopyWith<$R2, LocalUser, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

