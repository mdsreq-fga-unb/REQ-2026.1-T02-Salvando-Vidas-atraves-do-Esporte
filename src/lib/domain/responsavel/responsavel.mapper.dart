// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'responsavel.dart';

class ResponsavelMapper extends ClassMapperBase<Responsavel> {
  ResponsavelMapper._();

  static ResponsavelMapper? _instance;
  static ResponsavelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResponsavelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Responsavel';

  static String _$nome(Responsavel v) => v.nome;
  static const Field<Responsavel, String> _f$nome = Field('nome', _$nome);
  static String _$cpf(Responsavel v) => v.cpf;
  static const Field<Responsavel, String> _f$cpf = Field('cpf', _$cpf);
  static String _$contato(Responsavel v) => v.contato;
  static const Field<Responsavel, String> _f$contato = Field(
    'contato',
    _$contato,
  );
  static String _$email(Responsavel v) => v.email;
  static const Field<Responsavel, String> _f$email = Field('email', _$email);
  static bool _$ativo(Responsavel v) => v.ativo;
  static const Field<Responsavel, bool> _f$ativo = Field('ativo', _$ativo);
  static int? _$id(Responsavel v) => v.id;
  static const Field<Responsavel, int> _f$id = Field('id', _$id, opt: true);

  @override
  final MappableFields<Responsavel> fields = const {
    #nome: _f$nome,
    #cpf: _f$cpf,
    #contato: _f$contato,
    #email: _f$email,
    #ativo: _f$ativo,
    #id: _f$id,
  };

  static Responsavel _instantiate(DecodingData data) {
    return Responsavel(
      nome: data.dec(_f$nome),
      cpf: data.dec(_f$cpf),
      contato: data.dec(_f$contato),
      email: data.dec(_f$email),
      ativo: data.dec(_f$ativo),
      id: data.dec(_f$id),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Responsavel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Responsavel>(map);
  }

  static Responsavel fromJson(String json) {
    return ensureInitialized().decodeJson<Responsavel>(json);
  }
}

mixin ResponsavelMappable {
  String toJson() {
    return ResponsavelMapper.ensureInitialized().encodeJson<Responsavel>(
      this as Responsavel,
    );
  }

  Map<String, dynamic> toMap() {
    return ResponsavelMapper.ensureInitialized().encodeMap<Responsavel>(
      this as Responsavel,
    );
  }

  ResponsavelCopyWith<Responsavel, Responsavel, Responsavel> get copyWith =>
      _ResponsavelCopyWithImpl<Responsavel, Responsavel>(
        this as Responsavel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ResponsavelMapper.ensureInitialized().stringifyValue(
      this as Responsavel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ResponsavelMapper.ensureInitialized().equalsValue(
      this as Responsavel,
      other,
    );
  }

  @override
  int get hashCode {
    return ResponsavelMapper.ensureInitialized().hashValue(this as Responsavel);
  }
}

extension ResponsavelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Responsavel, $Out> {
  ResponsavelCopyWith<$R, Responsavel, $Out> get $asResponsavel =>
      $base.as((v, t, t2) => _ResponsavelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ResponsavelCopyWith<$R, $In extends Responsavel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? nome,
    String? cpf,
    String? contato,
    String? email,
    bool? ativo,
    int? id,
  });
  ResponsavelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ResponsavelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Responsavel, $Out>
    implements ResponsavelCopyWith<$R, Responsavel, $Out> {
  _ResponsavelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Responsavel> $mapper =
      ResponsavelMapper.ensureInitialized();
  @override
  $R call({
    String? nome,
    String? cpf,
    String? contato,
    String? email,
    bool? ativo,
    Object? id = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nome != null) #nome: nome,
      if (cpf != null) #cpf: cpf,
      if (contato != null) #contato: contato,
      if (email != null) #email: email,
      if (ativo != null) #ativo: ativo,
      if (id != $none) #id: id,
    }),
  );
  @override
  Responsavel $make(CopyWithData data) => Responsavel(
    nome: data.get(#nome, or: $value.nome),
    cpf: data.get(#cpf, or: $value.cpf),
    contato: data.get(#contato, or: $value.contato),
    email: data.get(#email, or: $value.email),
    ativo: data.get(#ativo, or: $value.ativo),
    id: data.get(#id, or: $value.id),
  );

  @override
  ResponsavelCopyWith<$R2, Responsavel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ResponsavelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

