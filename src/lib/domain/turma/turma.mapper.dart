// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'turma.dart';

class FaixaEtariaMapper extends EnumMapper<FaixaEtaria> {
  FaixaEtariaMapper._();

  static FaixaEtariaMapper? _instance;
  static FaixaEtariaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FaixaEtariaMapper._());
    }
    return _instance!;
  }

  static FaixaEtaria fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  FaixaEtaria decode(dynamic value) {
    switch (value) {
      case r'infantil':
        return FaixaEtaria.infantil;
      case r'adulto':
        return FaixaEtaria.adulto;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(FaixaEtaria self) {
    switch (self) {
      case FaixaEtaria.infantil:
        return r'infantil';
      case FaixaEtaria.adulto:
        return r'adulto';
    }
  }
}

extension FaixaEtariaMapperExtension on FaixaEtaria {
  String toValue() {
    FaixaEtariaMapper.ensureInitialized();
    return MapperContainer.globals.toValue<FaixaEtaria>(this) as String;
  }
}

class TurmaMapper extends ClassMapperBase<Turma> {
  TurmaMapper._();

  static TurmaMapper? _instance;
  static TurmaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TurmaMapper._());
      FaixaEtariaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Turma';

  static int _$id(Turma v) => v.id;
  static const Field<Turma, int> _f$id = Field('id', _$id);
  static String _$nome(Turma v) => v.nome;
  static const Field<Turma, String> _f$nome = Field('nome', _$nome);
  static String _$descricao(Turma v) => v.descricao;
  static const Field<Turma, String> _f$descricao = Field(
    'descricao',
    _$descricao,
  );
  static FaixaEtaria _$faixaEtaria(Turma v) => v.faixaEtaria;
  static const Field<Turma, FaixaEtaria> _f$faixaEtaria = Field(
    'faixaEtaria',
    _$faixaEtaria,
    key: r'faixa_etaria',
  );
  static DateTime _$horarioInicio(Turma v) => v.horarioInicio;
  static const Field<Turma, DateTime> _f$horarioInicio = Field(
    'horarioInicio',
    _$horarioInicio,
    key: r'horario_inicio',
    hook: HookHorario(),
  );
  static DateTime _$horarioFim(Turma v) => v.horarioFim;
  static const Field<Turma, DateTime> _f$horarioFim = Field(
    'horarioFim',
    _$horarioFim,
    key: r'horario_fim',
    hook: HookHorario(),
  );
  static bool _$ativo(Turma v) => v.ativo;
  static const Field<Turma, bool> _f$ativo = Field('ativo', _$ativo);
  static bool _$eSegunda(Turma v) => v.eSegunda;
  static const Field<Turma, bool> _f$eSegunda = Field(
    'eSegunda',
    _$eSegunda,
    key: r'e_segunda',
  );
  static bool _$eTerca(Turma v) => v.eTerca;
  static const Field<Turma, bool> _f$eTerca = Field(
    'eTerca',
    _$eTerca,
    key: r'e_terca',
  );
  static bool _$eQuarta(Turma v) => v.eQuarta;
  static const Field<Turma, bool> _f$eQuarta = Field(
    'eQuarta',
    _$eQuarta,
    key: r'e_quarta',
  );
  static bool _$eQuinta(Turma v) => v.eQuinta;
  static const Field<Turma, bool> _f$eQuinta = Field(
    'eQuinta',
    _$eQuinta,
    key: r'e_quinta',
  );
  static bool _$eSexta(Turma v) => v.eSexta;
  static const Field<Turma, bool> _f$eSexta = Field(
    'eSexta',
    _$eSexta,
    key: r'e_sexta',
  );
  static bool _$eSabado(Turma v) => v.eSabado;
  static const Field<Turma, bool> _f$eSabado = Field(
    'eSabado',
    _$eSabado,
    key: r'e_sabado',
  );
  static bool _$eDomingo(Turma v) => v.eDomingo;
  static const Field<Turma, bool> _f$eDomingo = Field(
    'eDomingo',
    _$eDomingo,
    key: r'e_domingo',
  );
  static int? _$qtdAlunos(Turma v) => v.qtdAlunos;
  static const Field<Turma, int> _f$qtdAlunos = Field(
    'qtdAlunos',
    _$qtdAlunos,
    key: r'qtd_alunos',
    opt: true,
  );

  @override
  final MappableFields<Turma> fields = const {
    #id: _f$id,
    #nome: _f$nome,
    #descricao: _f$descricao,
    #faixaEtaria: _f$faixaEtaria,
    #horarioInicio: _f$horarioInicio,
    #horarioFim: _f$horarioFim,
    #ativo: _f$ativo,
    #eSegunda: _f$eSegunda,
    #eTerca: _f$eTerca,
    #eQuarta: _f$eQuarta,
    #eQuinta: _f$eQuinta,
    #eSexta: _f$eSexta,
    #eSabado: _f$eSabado,
    #eDomingo: _f$eDomingo,
    #qtdAlunos: _f$qtdAlunos,
  };
  @override
  final bool ignoreNull = true;

  static Turma _instantiate(DecodingData data) {
    return Turma(
      id: data.dec(_f$id),
      nome: data.dec(_f$nome),
      descricao: data.dec(_f$descricao),
      faixaEtaria: data.dec(_f$faixaEtaria),
      horarioInicio: data.dec(_f$horarioInicio),
      horarioFim: data.dec(_f$horarioFim),
      ativo: data.dec(_f$ativo),
      eSegunda: data.dec(_f$eSegunda),
      eTerca: data.dec(_f$eTerca),
      eQuarta: data.dec(_f$eQuarta),
      eQuinta: data.dec(_f$eQuinta),
      eSexta: data.dec(_f$eSexta),
      eSabado: data.dec(_f$eSabado),
      eDomingo: data.dec(_f$eDomingo),
      qtdAlunos: data.dec(_f$qtdAlunos),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Turma fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Turma>(map);
  }

  static Turma fromJson(String json) {
    return ensureInitialized().decodeJson<Turma>(json);
  }
}

mixin TurmaMappable {
  String toJson() {
    return TurmaMapper.ensureInitialized().encodeJson<Turma>(this as Turma);
  }

  Map<String, dynamic> toMap() {
    return TurmaMapper.ensureInitialized().encodeMap<Turma>(this as Turma);
  }

  TurmaCopyWith<Turma, Turma, Turma> get copyWith =>
      _TurmaCopyWithImpl<Turma, Turma>(this as Turma, $identity, $identity);
  @override
  String toString() {
    return TurmaMapper.ensureInitialized().stringifyValue(this as Turma);
  }

  @override
  bool operator ==(Object other) {
    return TurmaMapper.ensureInitialized().equalsValue(this as Turma, other);
  }

  @override
  int get hashCode {
    return TurmaMapper.ensureInitialized().hashValue(this as Turma);
  }
}

extension TurmaValueCopy<$R, $Out> on ObjectCopyWith<$R, Turma, $Out> {
  TurmaCopyWith<$R, Turma, $Out> get $asTurma =>
      $base.as((v, t, t2) => _TurmaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TurmaCopyWith<$R, $In extends Turma, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? nome,
    String? descricao,
    FaixaEtaria? faixaEtaria,
    DateTime? horarioInicio,
    DateTime? horarioFim,
    bool? ativo,
    bool? eSegunda,
    bool? eTerca,
    bool? eQuarta,
    bool? eQuinta,
    bool? eSexta,
    bool? eSabado,
    bool? eDomingo,
    int? qtdAlunos,
  });
  TurmaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TurmaCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Turma, $Out>
    implements TurmaCopyWith<$R, Turma, $Out> {
  _TurmaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Turma> $mapper = TurmaMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? nome,
    String? descricao,
    FaixaEtaria? faixaEtaria,
    DateTime? horarioInicio,
    DateTime? horarioFim,
    bool? ativo,
    bool? eSegunda,
    bool? eTerca,
    bool? eQuarta,
    bool? eQuinta,
    bool? eSexta,
    bool? eSabado,
    bool? eDomingo,
    Object? qtdAlunos = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (nome != null) #nome: nome,
      if (descricao != null) #descricao: descricao,
      if (faixaEtaria != null) #faixaEtaria: faixaEtaria,
      if (horarioInicio != null) #horarioInicio: horarioInicio,
      if (horarioFim != null) #horarioFim: horarioFim,
      if (ativo != null) #ativo: ativo,
      if (eSegunda != null) #eSegunda: eSegunda,
      if (eTerca != null) #eTerca: eTerca,
      if (eQuarta != null) #eQuarta: eQuarta,
      if (eQuinta != null) #eQuinta: eQuinta,
      if (eSexta != null) #eSexta: eSexta,
      if (eSabado != null) #eSabado: eSabado,
      if (eDomingo != null) #eDomingo: eDomingo,
      if (qtdAlunos != $none) #qtdAlunos: qtdAlunos,
    }),
  );
  @override
  Turma $make(CopyWithData data) => Turma(
    id: data.get(#id, or: $value.id),
    nome: data.get(#nome, or: $value.nome),
    descricao: data.get(#descricao, or: $value.descricao),
    faixaEtaria: data.get(#faixaEtaria, or: $value.faixaEtaria),
    horarioInicio: data.get(#horarioInicio, or: $value.horarioInicio),
    horarioFim: data.get(#horarioFim, or: $value.horarioFim),
    ativo: data.get(#ativo, or: $value.ativo),
    eSegunda: data.get(#eSegunda, or: $value.eSegunda),
    eTerca: data.get(#eTerca, or: $value.eTerca),
    eQuarta: data.get(#eQuarta, or: $value.eQuarta),
    eQuinta: data.get(#eQuinta, or: $value.eQuinta),
    eSexta: data.get(#eSexta, or: $value.eSexta),
    eSabado: data.get(#eSabado, or: $value.eSabado),
    eDomingo: data.get(#eDomingo, or: $value.eDomingo),
    qtdAlunos: data.get(#qtdAlunos, or: $value.qtdAlunos),
  );

  @override
  TurmaCopyWith<$R2, Turma, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TurmaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

