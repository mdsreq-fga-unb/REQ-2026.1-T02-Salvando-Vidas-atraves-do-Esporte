// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'aluno.dart';

class AlunoMapper extends ClassMapperBase<Aluno> {
  AlunoMapper._();

  static AlunoMapper? _instance;
  static AlunoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlunoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Aluno';

  static String _$nome(Aluno v) => v.nome;
  static const Field<Aluno, String> _f$nome = Field('nome', _$nome);
  static String _$cpf(Aluno v) => v.cpf;
  static const Field<Aluno, String> _f$cpf = Field('cpf', _$cpf);
  static DateTime _$nascimento(Aluno v) => v.nascimento;
  static const Field<Aluno, DateTime> _f$nascimento = Field(
    'nascimento',
    _$nascimento,
  );
  static String _$email(Aluno v) => v.email;
  static const Field<Aluno, String> _f$email = Field('email', _$email);
  static Faixa _$faixa(Aluno v) => v.faixa;
  static const Field<Aluno, Faixa> _f$faixa = Field('faixa', _$faixa);
  static int _$grau(Aluno v) => v.grau;
  static const Field<Aluno, int> _f$grau = Field('grau', _$grau);
  static DateTime _$dataEntrada(Aluno v) => v.dataEntrada;
  static const Field<Aluno, DateTime> _f$dataEntrada = Field(
    'dataEntrada',
    _$dataEntrada,
    key: r'data_entrada',
  );
  static bool _$ativo(Aluno v) => v.ativo;
  static const Field<Aluno, bool> _f$ativo = Field('ativo', _$ativo);
  static bool _$federado(Aluno v) => v.federado;
  static const Field<Aluno, bool> _f$federado = Field('federado', _$federado);
  static BigInt? _$id(Aluno v) => v.id;
  static const Field<Aluno, BigInt> _f$id = Field('id', _$id, opt: true);
  static String? _$contato(Aluno v) => v.contato;
  static const Field<Aluno, String> _f$contato = Field(
    'contato',
    _$contato,
    opt: true,
  );
  static String? _$contatoEmergencia(Aluno v) => v.contatoEmergencia;
  static const Field<Aluno, String> _f$contatoEmergencia = Field(
    'contatoEmergencia',
    _$contatoEmergencia,
    key: r'contato_emergencia',
    opt: true,
  );
  static String? _$linkFoto(Aluno v) => v.linkFoto;
  static const Field<Aluno, String> _f$linkFoto = Field(
    'linkFoto',
    _$linkFoto,
    key: r'link_foto',
    opt: true,
  );
  static BigInt? _$idResponsavel(Aluno v) => v.idResponsavel;
  static const Field<Aluno, BigInt> _f$idResponsavel = Field(
    'idResponsavel',
    _$idResponsavel,
    key: r'id_responsavel',
    opt: true,
  );
  static BigInt? _$idTurma(Aluno v) => v.idTurma;
  static const Field<Aluno, BigInt> _f$idTurma = Field(
    'idTurma',
    _$idTurma,
    key: r'id_turma',
    opt: true,
  );

  @override
  final MappableFields<Aluno> fields = const {
    #nome: _f$nome,
    #cpf: _f$cpf,
    #nascimento: _f$nascimento,
    #email: _f$email,
    #faixa: _f$faixa,
    #grau: _f$grau,
    #dataEntrada: _f$dataEntrada,
    #ativo: _f$ativo,
    #federado: _f$federado,
    #id: _f$id,
    #contato: _f$contato,
    #contatoEmergencia: _f$contatoEmergencia,
    #linkFoto: _f$linkFoto,
    #idResponsavel: _f$idResponsavel,
    #idTurma: _f$idTurma,
  };
  @override
  final bool ignoreNull = true;

  static Aluno _instantiate(DecodingData data) {
    return Aluno(
      nome: data.dec(_f$nome),
      cpf: data.dec(_f$cpf),
      nascimento: data.dec(_f$nascimento),
      email: data.dec(_f$email),
      faixa: data.dec(_f$faixa),
      grau: data.dec(_f$grau),
      dataEntrada: data.dec(_f$dataEntrada),
      ativo: data.dec(_f$ativo),
      federado: data.dec(_f$federado),
      id: data.dec(_f$id),
      contato: data.dec(_f$contato),
      contatoEmergencia: data.dec(_f$contatoEmergencia),
      linkFoto: data.dec(_f$linkFoto),
      idResponsavel: data.dec(_f$idResponsavel),
      idTurma: data.dec(_f$idTurma),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Aluno fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Aluno>(map);
  }

  static Aluno fromJson(String json) {
    return ensureInitialized().decodeJson<Aluno>(json);
  }
}

mixin AlunoMappable {
  String toJson() {
    return AlunoMapper.ensureInitialized().encodeJson<Aluno>(this as Aluno);
  }

  Map<String, dynamic> toMap() {
    return AlunoMapper.ensureInitialized().encodeMap<Aluno>(this as Aluno);
  }

  AlunoCopyWith<Aluno, Aluno, Aluno> get copyWith =>
      _AlunoCopyWithImpl<Aluno, Aluno>(this as Aluno, $identity, $identity);
  @override
  String toString() {
    return AlunoMapper.ensureInitialized().stringifyValue(this as Aluno);
  }

  @override
  bool operator ==(Object other) {
    return AlunoMapper.ensureInitialized().equalsValue(this as Aluno, other);
  }

  @override
  int get hashCode {
    return AlunoMapper.ensureInitialized().hashValue(this as Aluno);
  }
}

extension AlunoValueCopy<$R, $Out> on ObjectCopyWith<$R, Aluno, $Out> {
  AlunoCopyWith<$R, Aluno, $Out> get $asAluno =>
      $base.as((v, t, t2) => _AlunoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AlunoCopyWith<$R, $In extends Aluno, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? nome,
    String? cpf,
    DateTime? nascimento,
    String? email,
    Faixa? faixa,
    int? grau,
    DateTime? dataEntrada,
    bool? ativo,
    bool? federado,
    BigInt? id,
    String? contato,
    String? contatoEmergencia,
    String? linkFoto,
    BigInt? idResponsavel,
    BigInt? idTurma,
  });
  AlunoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AlunoCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Aluno, $Out>
    implements AlunoCopyWith<$R, Aluno, $Out> {
  _AlunoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Aluno> $mapper = AlunoMapper.ensureInitialized();
  @override
  $R call({
    String? nome,
    String? cpf,
    DateTime? nascimento,
    String? email,
    Faixa? faixa,
    int? grau,
    DateTime? dataEntrada,
    bool? ativo,
    bool? federado,
    Object? id = $none,
    Object? contato = $none,
    Object? contatoEmergencia = $none,
    Object? linkFoto = $none,
    Object? idResponsavel = $none,
    Object? idTurma = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nome != null) #nome: nome,
      if (cpf != null) #cpf: cpf,
      if (nascimento != null) #nascimento: nascimento,
      if (email != null) #email: email,
      if (faixa != null) #faixa: faixa,
      if (grau != null) #grau: grau,
      if (dataEntrada != null) #dataEntrada: dataEntrada,
      if (ativo != null) #ativo: ativo,
      if (federado != null) #federado: federado,
      if (id != $none) #id: id,
      if (contato != $none) #contato: contato,
      if (contatoEmergencia != $none) #contatoEmergencia: contatoEmergencia,
      if (linkFoto != $none) #linkFoto: linkFoto,
      if (idResponsavel != $none) #idResponsavel: idResponsavel,
      if (idTurma != $none) #idTurma: idTurma,
    }),
  );
  @override
  Aluno $make(CopyWithData data) => Aluno(
    nome: data.get(#nome, or: $value.nome),
    cpf: data.get(#cpf, or: $value.cpf),
    nascimento: data.get(#nascimento, or: $value.nascimento),
    email: data.get(#email, or: $value.email),
    faixa: data.get(#faixa, or: $value.faixa),
    grau: data.get(#grau, or: $value.grau),
    dataEntrada: data.get(#dataEntrada, or: $value.dataEntrada),
    ativo: data.get(#ativo, or: $value.ativo),
    federado: data.get(#federado, or: $value.federado),
    id: data.get(#id, or: $value.id),
    contato: data.get(#contato, or: $value.contato),
    contatoEmergencia: data.get(
      #contatoEmergencia,
      or: $value.contatoEmergencia,
    ),
    linkFoto: data.get(#linkFoto, or: $value.linkFoto),
    idResponsavel: data.get(#idResponsavel, or: $value.idResponsavel),
    idTurma: data.get(#idTurma, or: $value.idTurma),
  );

  @override
  AlunoCopyWith<$R2, Aluno, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AlunoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

