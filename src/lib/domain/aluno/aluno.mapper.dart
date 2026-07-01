// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'aluno.dart';

class FaixaMapper extends EnumMapper<Faixa> {
  FaixaMapper._();

  static FaixaMapper? _instance;
  static FaixaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FaixaMapper._());
    }
    return _instance!;
  }

  static Faixa fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Faixa decode(dynamic value) {
    switch (value) {
      case r'branca':
        return Faixa.branca;
      case r'cinza':
        return Faixa.cinza;
      case r'amarela':
        return Faixa.amarela;
      case r'laranja':
        return Faixa.laranja;
      case r'verde':
        return Faixa.verde;
      case r'azul':
        return Faixa.azul;
      case r'roxa':
        return Faixa.roxa;
      case r'marrom':
        return Faixa.marrom;
      case r'preta':
        return Faixa.preta;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Faixa self) {
    switch (self) {
      case Faixa.branca:
        return r'branca';
      case Faixa.cinza:
        return r'cinza';
      case Faixa.amarela:
        return r'amarela';
      case Faixa.laranja:
        return r'laranja';
      case Faixa.verde:
        return r'verde';
      case Faixa.azul:
        return r'azul';
      case Faixa.roxa:
        return r'roxa';
      case Faixa.marrom:
        return r'marrom';
      case Faixa.preta:
        return r'preta';
    }
  }
}

extension FaixaMapperExtension on Faixa {
  String toValue() {
    FaixaMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Faixa>(this) as String;
  }
}

class TipoSanguineoMapper extends EnumMapper<TipoSanguineo> {
  TipoSanguineoMapper._();

  static TipoSanguineoMapper? _instance;
  static TipoSanguineoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TipoSanguineoMapper._());
    }
    return _instance!;
  }

  static TipoSanguineo fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TipoSanguineo decode(dynamic value) {
    switch (value) {
      case r'a_positivo':
        return TipoSanguineo.aPositivo;
      case r'a_negativo':
        return TipoSanguineo.aNegativo;
      case r'b_positivo':
        return TipoSanguineo.bPositivo;
      case r'b_negativo':
        return TipoSanguineo.bNegativo;
      case r'ab_positivo':
        return TipoSanguineo.abPositivo;
      case r'ab_negativo':
        return TipoSanguineo.abNegativo;
      case r'o_positivo':
        return TipoSanguineo.oPositivo;
      case r'o_negativo':
        return TipoSanguineo.oNegativo;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TipoSanguineo self) {
    switch (self) {
      case TipoSanguineo.aPositivo:
        return r'a_positivo';
      case TipoSanguineo.aNegativo:
        return r'a_negativo';
      case TipoSanguineo.bPositivo:
        return r'b_positivo';
      case TipoSanguineo.bNegativo:
        return r'b_negativo';
      case TipoSanguineo.abPositivo:
        return r'ab_positivo';
      case TipoSanguineo.abNegativo:
        return r'ab_negativo';
      case TipoSanguineo.oPositivo:
        return r'o_positivo';
      case TipoSanguineo.oNegativo:
        return r'o_negativo';
    }
  }
}

extension TipoSanguineoMapperExtension on TipoSanguineo {
  String toValue() {
    TipoSanguineoMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TipoSanguineo>(this) as String;
  }
}

class AlunoMapper extends ClassMapperBase<Aluno> {
  AlunoMapper._();

  static AlunoMapper? _instance;
  static AlunoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlunoMapper._());
      FaixaMapper.ensureInitialized();
      TipoSanguineoMapper.ensureInitialized();
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
  static TipoSanguineo _$tipoSanguineo(Aluno v) => v.tipoSanguineo;
  static const Field<Aluno, TipoSanguineo> _f$tipoSanguineo = Field(
    'tipoSanguineo',
    _$tipoSanguineo,
    key: r'tipo_sanguineo',
  );
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
  static bool _$pMedica1(Aluno v) => v.pMedica1;
  static const Field<Aluno, bool> _f$pMedica1 = Field(
    'pMedica1',
    _$pMedica1,
    key: r'p_medica1',
  );
  static bool _$pMedica2(Aluno v) => v.pMedica2;
  static const Field<Aluno, bool> _f$pMedica2 = Field(
    'pMedica2',
    _$pMedica2,
    key: r'p_medica2',
  );
  static bool _$pMedica3(Aluno v) => v.pMedica3;
  static const Field<Aluno, bool> _f$pMedica3 = Field(
    'pMedica3',
    _$pMedica3,
    key: r'p_medica3',
  );
  static bool _$pMedica4(Aluno v) => v.pMedica4;
  static const Field<Aluno, bool> _f$pMedica4 = Field(
    'pMedica4',
    _$pMedica4,
    key: r'p_medica4',
  );
  static bool _$pMedica5(Aluno v) => v.pMedica5;
  static const Field<Aluno, bool> _f$pMedica5 = Field(
    'pMedica5',
    _$pMedica5,
    key: r'p_medica5',
  );
  static String? _$apelido(Aluno v) => v.apelido;
  static const Field<Aluno, String> _f$apelido = Field(
    'apelido',
    _$apelido,
    opt: true,
  );
  static bool _$usarApelido(Aluno v) => v.usarApelido;
  static const Field<Aluno, bool> _f$usarApelido = Field(
    'usarApelido',
    _$usarApelido,
    key: r'usar_apelido',
    opt: true,
    def: false,
  );
  static int? _$id(Aluno v) => v.id;
  static const Field<Aluno, int> _f$id = Field('id', _$id, opt: true);
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
  static int? _$idResponsavel(Aluno v) => v.idResponsavel;
  static const Field<Aluno, int> _f$idResponsavel = Field(
    'idResponsavel',
    _$idResponsavel,
    key: r'id_responsavel',
    opt: true,
  );
  static int? _$idTurma(Aluno v) => v.idTurma;
  static const Field<Aluno, int> _f$idTurma = Field(
    'idTurma',
    _$idTurma,
    key: r'id_turma',
    opt: true,
  );
  static int? _$idFicha(Aluno v) => v.idFicha;
  static const Field<Aluno, int> _f$idFicha = Field(
    'idFicha',
    _$idFicha,
    key: r'id_ficha',
    opt: true,
  );
  static String? _$observacaoMedica(Aluno v) => v.observacaoMedica;
  static const Field<Aluno, String> _f$observacaoMedica = Field(
    'observacaoMedica',
    _$observacaoMedica,
    key: r'observacao_medica',
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
    #tipoSanguineo: _f$tipoSanguineo,
    #dataEntrada: _f$dataEntrada,
    #ativo: _f$ativo,
    #federado: _f$federado,
    #pMedica1: _f$pMedica1,
    #pMedica2: _f$pMedica2,
    #pMedica3: _f$pMedica3,
    #pMedica4: _f$pMedica4,
    #pMedica5: _f$pMedica5,
    #apelido: _f$apelido,
    #usarApelido: _f$usarApelido,
    #id: _f$id,
    #contato: _f$contato,
    #contatoEmergencia: _f$contatoEmergencia,
    #linkFoto: _f$linkFoto,
    #idResponsavel: _f$idResponsavel,
    #idTurma: _f$idTurma,
    #idFicha: _f$idFicha,
    #observacaoMedica: _f$observacaoMedica,
  };

  static Aluno _instantiate(DecodingData data) {
    return Aluno(
      nome: data.dec(_f$nome),
      cpf: data.dec(_f$cpf),
      nascimento: data.dec(_f$nascimento),
      email: data.dec(_f$email),
      faixa: data.dec(_f$faixa),
      grau: data.dec(_f$grau),
      tipoSanguineo: data.dec(_f$tipoSanguineo),
      dataEntrada: data.dec(_f$dataEntrada),
      ativo: data.dec(_f$ativo),
      federado: data.dec(_f$federado),
      pMedica1: data.dec(_f$pMedica1),
      pMedica2: data.dec(_f$pMedica2),
      pMedica3: data.dec(_f$pMedica3),
      pMedica4: data.dec(_f$pMedica4),
      pMedica5: data.dec(_f$pMedica5),
      apelido: data.dec(_f$apelido),
      usarApelido: data.dec(_f$usarApelido),
      id: data.dec(_f$id),
      contato: data.dec(_f$contato),
      contatoEmergencia: data.dec(_f$contatoEmergencia),
      linkFoto: data.dec(_f$linkFoto),
      idResponsavel: data.dec(_f$idResponsavel),
      idTurma: data.dec(_f$idTurma),
      idFicha: data.dec(_f$idFicha),
      observacaoMedica: data.dec(_f$observacaoMedica),
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
    TipoSanguineo? tipoSanguineo,
    DateTime? dataEntrada,
    bool? ativo,
    bool? federado,
    bool? pMedica1,
    bool? pMedica2,
    bool? pMedica3,
    bool? pMedica4,
    bool? pMedica5,
    String? apelido,
    bool? usarApelido,
    int? id,
    String? contato,
    String? contatoEmergencia,
    String? linkFoto,
    int? idResponsavel,
    int? idTurma,
    int? idFicha,
    String? observacaoMedica,
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
    TipoSanguineo? tipoSanguineo,
    DateTime? dataEntrada,
    bool? ativo,
    bool? federado,
    bool? pMedica1,
    bool? pMedica2,
    bool? pMedica3,
    bool? pMedica4,
    bool? pMedica5,
    Object? apelido = $none,
    bool? usarApelido,
    Object? id = $none,
    Object? contato = $none,
    Object? contatoEmergencia = $none,
    Object? linkFoto = $none,
    Object? idResponsavel = $none,
    Object? idTurma = $none,
    Object? idFicha = $none,
    Object? observacaoMedica = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nome != null) #nome: nome,
      if (cpf != null) #cpf: cpf,
      if (nascimento != null) #nascimento: nascimento,
      if (email != null) #email: email,
      if (faixa != null) #faixa: faixa,
      if (grau != null) #grau: grau,
      if (tipoSanguineo != null) #tipoSanguineo: tipoSanguineo,
      if (dataEntrada != null) #dataEntrada: dataEntrada,
      if (ativo != null) #ativo: ativo,
      if (federado != null) #federado: federado,
      if (pMedica1 != null) #pMedica1: pMedica1,
      if (pMedica2 != null) #pMedica2: pMedica2,
      if (pMedica3 != null) #pMedica3: pMedica3,
      if (pMedica4 != null) #pMedica4: pMedica4,
      if (pMedica5 != null) #pMedica5: pMedica5,
      if (apelido != $none) #apelido: apelido,
      if (usarApelido != null) #usarApelido: usarApelido,
      if (id != $none) #id: id,
      if (contato != $none) #contato: contato,
      if (contatoEmergencia != $none) #contatoEmergencia: contatoEmergencia,
      if (linkFoto != $none) #linkFoto: linkFoto,
      if (idResponsavel != $none) #idResponsavel: idResponsavel,
      if (idTurma != $none) #idTurma: idTurma,
      if (idFicha != $none) #idFicha: idFicha,
      if (observacaoMedica != $none) #observacaoMedica: observacaoMedica,
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
    tipoSanguineo: data.get(#tipoSanguineo, or: $value.tipoSanguineo),
    dataEntrada: data.get(#dataEntrada, or: $value.dataEntrada),
    ativo: data.get(#ativo, or: $value.ativo),
    federado: data.get(#federado, or: $value.federado),
    pMedica1: data.get(#pMedica1, or: $value.pMedica1),
    pMedica2: data.get(#pMedica2, or: $value.pMedica2),
    pMedica3: data.get(#pMedica3, or: $value.pMedica3),
    pMedica4: data.get(#pMedica4, or: $value.pMedica4),
    pMedica5: data.get(#pMedica5, or: $value.pMedica5),
    apelido: data.get(#apelido, or: $value.apelido),
    usarApelido: data.get(#usarApelido, or: $value.usarApelido),
    id: data.get(#id, or: $value.id),
    contato: data.get(#contato, or: $value.contato),
    contatoEmergencia: data.get(
      #contatoEmergencia,
      or: $value.contatoEmergencia,
    ),
    linkFoto: data.get(#linkFoto, or: $value.linkFoto),
    idResponsavel: data.get(#idResponsavel, or: $value.idResponsavel),
    idTurma: data.get(#idTurma, or: $value.idTurma),
    idFicha: data.get(#idFicha, or: $value.idFicha),
    observacaoMedica: data.get(#observacaoMedica, or: $value.observacaoMedica),
  );

  @override
  AlunoCopyWith<$R2, Aluno, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AlunoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

