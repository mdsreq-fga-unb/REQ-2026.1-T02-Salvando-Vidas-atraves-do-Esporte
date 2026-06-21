// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_aluno.dart';

class UpdateAlunoStateMapper extends ClassMapperBase<UpdateAlunoState> {
  UpdateAlunoStateMapper._();

  static UpdateAlunoStateMapper? _instance;
  static UpdateAlunoStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateAlunoStateMapper._());
      AlunoMapper.ensureInitialized();
      ResponsavelMapper.ensureInitialized();
      TipoSanguineoMapper.ensureInitialized();
      FaixaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateAlunoState';

  static Aluno _$alunoOriginal(UpdateAlunoState v) => v.alunoOriginal;
  static const Field<UpdateAlunoState, Aluno> _f$alunoOriginal = Field(
    'alunoOriginal',
    _$alunoOriginal,
    key: r'aluno_original',
  );
  static Responsavel? _$responsavelOriginal(UpdateAlunoState v) =>
      v.responsavelOriginal;
  static const Field<UpdateAlunoState, Responsavel> _f$responsavelOriginal =
      Field(
        'responsavelOriginal',
        _$responsavelOriginal,
        key: r'responsavel_original',
      );
  static String _$nome(UpdateAlunoState v) => v.nome;
  static const Field<UpdateAlunoState, String> _f$nome = Field(
    'nome',
    _$nome,
    opt: true,
    def: '',
  );
  static String _$cpf(UpdateAlunoState v) => v.cpf;
  static const Field<UpdateAlunoState, String> _f$cpf = Field(
    'cpf',
    _$cpf,
    opt: true,
    def: '',
  );
  static String _$contato(UpdateAlunoState v) => v.contato;
  static const Field<UpdateAlunoState, String> _f$contato = Field(
    'contato',
    _$contato,
    opt: true,
    def: '',
  );
  static String _$contatoEmergencia(UpdateAlunoState v) => v.contatoEmergencia;
  static const Field<UpdateAlunoState, String> _f$contatoEmergencia = Field(
    'contatoEmergencia',
    _$contatoEmergencia,
    key: r'contato_emergencia',
    opt: true,
    def: '',
  );
  static String _$email(UpdateAlunoState v) => v.email;
  static const Field<UpdateAlunoState, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static DateTime? _$nascimento(UpdateAlunoState v) => v.nascimento;
  static const Field<UpdateAlunoState, DateTime> _f$nascimento = Field(
    'nascimento',
    _$nascimento,
    opt: true,
  );
  static TipoSanguineo? _$tipoSanguineo(UpdateAlunoState v) => v.tipoSanguineo;
  static const Field<UpdateAlunoState, TipoSanguineo> _f$tipoSanguineo = Field(
    'tipoSanguineo',
    _$tipoSanguineo,
    key: r'tipo_sanguineo',
    opt: true,
  );
  static Faixa? _$faixa(UpdateAlunoState v) => v.faixa;
  static const Field<UpdateAlunoState, Faixa> _f$faixa = Field(
    'faixa',
    _$faixa,
    opt: true,
  );
  static int _$grau(UpdateAlunoState v) => v.grau;
  static const Field<UpdateAlunoState, int> _f$grau = Field(
    'grau',
    _$grau,
    opt: true,
    def: 0,
  );
  static String _$idFicha(UpdateAlunoState v) => v.idFicha;
  static const Field<UpdateAlunoState, String> _f$idFicha = Field(
    'idFicha',
    _$idFicha,
    key: r'id_ficha',
    opt: true,
    def: '',
  );
  static String _$nomeResponsavel(UpdateAlunoState v) => v.nomeResponsavel;
  static const Field<UpdateAlunoState, String> _f$nomeResponsavel = Field(
    'nomeResponsavel',
    _$nomeResponsavel,
    key: r'nome_responsavel',
    opt: true,
    def: '',
  );
  static String _$cpfResponsavel(UpdateAlunoState v) => v.cpfResponsavel;
  static const Field<UpdateAlunoState, String> _f$cpfResponsavel = Field(
    'cpfResponsavel',
    _$cpfResponsavel,
    key: r'cpf_responsavel',
    opt: true,
    def: '',
  );
  static String _$contatoResponsavel(UpdateAlunoState v) =>
      v.contatoResponsavel;
  static const Field<UpdateAlunoState, String> _f$contatoResponsavel = Field(
    'contatoResponsavel',
    _$contatoResponsavel,
    key: r'contato_responsavel',
    opt: true,
    def: '',
  );
  static String _$emailResponsavel(UpdateAlunoState v) => v.emailResponsavel;
  static const Field<UpdateAlunoState, String> _f$emailResponsavel = Field(
    'emailResponsavel',
    _$emailResponsavel,
    key: r'email_responsavel',
    opt: true,
    def: '',
  );
  static bool _$dirty(UpdateAlunoState v) => v.dirty;
  static const Field<UpdateAlunoState, bool> _f$dirty = Field(
    'dirty',
    _$dirty,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<UpdateAlunoState> fields = const {
    #alunoOriginal: _f$alunoOriginal,
    #responsavelOriginal: _f$responsavelOriginal,
    #nome: _f$nome,
    #cpf: _f$cpf,
    #contato: _f$contato,
    #contatoEmergencia: _f$contatoEmergencia,
    #email: _f$email,
    #nascimento: _f$nascimento,
    #tipoSanguineo: _f$tipoSanguineo,
    #faixa: _f$faixa,
    #grau: _f$grau,
    #idFicha: _f$idFicha,
    #nomeResponsavel: _f$nomeResponsavel,
    #cpfResponsavel: _f$cpfResponsavel,
    #contatoResponsavel: _f$contatoResponsavel,
    #emailResponsavel: _f$emailResponsavel,
    #dirty: _f$dirty,
  };

  static UpdateAlunoState _instantiate(DecodingData data) {
    return UpdateAlunoState(
      alunoOriginal: data.dec(_f$alunoOriginal),
      responsavelOriginal: data.dec(_f$responsavelOriginal),
      nome: data.dec(_f$nome),
      cpf: data.dec(_f$cpf),
      contato: data.dec(_f$contato),
      contatoEmergencia: data.dec(_f$contatoEmergencia),
      email: data.dec(_f$email),
      nascimento: data.dec(_f$nascimento),
      tipoSanguineo: data.dec(_f$tipoSanguineo),
      faixa: data.dec(_f$faixa),
      grau: data.dec(_f$grau),
      idFicha: data.dec(_f$idFicha),
      nomeResponsavel: data.dec(_f$nomeResponsavel),
      cpfResponsavel: data.dec(_f$cpfResponsavel),
      contatoResponsavel: data.dec(_f$contatoResponsavel),
      emailResponsavel: data.dec(_f$emailResponsavel),
      dirty: data.dec(_f$dirty),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateAlunoState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateAlunoState>(map);
  }

  static UpdateAlunoState fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateAlunoState>(json);
  }
}

mixin UpdateAlunoStateMappable {
  String toJson() {
    return UpdateAlunoStateMapper.ensureInitialized()
        .encodeJson<UpdateAlunoState>(this as UpdateAlunoState);
  }

  Map<String, dynamic> toMap() {
    return UpdateAlunoStateMapper.ensureInitialized()
        .encodeMap<UpdateAlunoState>(this as UpdateAlunoState);
  }

  UpdateAlunoStateCopyWith<UpdateAlunoState, UpdateAlunoState, UpdateAlunoState>
  get copyWith =>
      _UpdateAlunoStateCopyWithImpl<UpdateAlunoState, UpdateAlunoState>(
        this as UpdateAlunoState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UpdateAlunoStateMapper.ensureInitialized().stringifyValue(
      this as UpdateAlunoState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UpdateAlunoStateMapper.ensureInitialized().equalsValue(
      this as UpdateAlunoState,
      other,
    );
  }

  @override
  int get hashCode {
    return UpdateAlunoStateMapper.ensureInitialized().hashValue(
      this as UpdateAlunoState,
    );
  }
}

extension UpdateAlunoStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateAlunoState, $Out> {
  UpdateAlunoStateCopyWith<$R, UpdateAlunoState, $Out>
  get $asUpdateAlunoState =>
      $base.as((v, t, t2) => _UpdateAlunoStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UpdateAlunoStateCopyWith<$R, $In extends UpdateAlunoState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AlunoCopyWith<$R, Aluno, Aluno> get alunoOriginal;
  ResponsavelCopyWith<$R, Responsavel, Responsavel>? get responsavelOriginal;
  $R call({
    Aluno? alunoOriginal,
    Responsavel? responsavelOriginal,
    String? nome,
    String? cpf,
    String? contato,
    String? contatoEmergencia,
    String? email,
    DateTime? nascimento,
    TipoSanguineo? tipoSanguineo,
    Faixa? faixa,
    int? grau,
    String? idFicha,
    String? nomeResponsavel,
    String? cpfResponsavel,
    String? contatoResponsavel,
    String? emailResponsavel,
    bool? dirty,
  });
  UpdateAlunoStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UpdateAlunoStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateAlunoState, $Out>
    implements UpdateAlunoStateCopyWith<$R, UpdateAlunoState, $Out> {
  _UpdateAlunoStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateAlunoState> $mapper =
      UpdateAlunoStateMapper.ensureInitialized();
  @override
  AlunoCopyWith<$R, Aluno, Aluno> get alunoOriginal =>
      $value.alunoOriginal.copyWith.$chain((v) => call(alunoOriginal: v));
  @override
  ResponsavelCopyWith<$R, Responsavel, Responsavel>? get responsavelOriginal =>
      $value.responsavelOriginal?.copyWith.$chain(
        (v) => call(responsavelOriginal: v),
      );
  @override
  $R call({
    Aluno? alunoOriginal,
    Object? responsavelOriginal = $none,
    String? nome,
    String? cpf,
    String? contato,
    String? contatoEmergencia,
    String? email,
    Object? nascimento = $none,
    Object? tipoSanguineo = $none,
    Object? faixa = $none,
    int? grau,
    String? idFicha,
    String? nomeResponsavel,
    String? cpfResponsavel,
    String? contatoResponsavel,
    String? emailResponsavel,
    bool? dirty,
  }) => $apply(
    FieldCopyWithData({
      if (alunoOriginal != null) #alunoOriginal: alunoOriginal,
      if (responsavelOriginal != $none)
        #responsavelOriginal: responsavelOriginal,
      if (nome != null) #nome: nome,
      if (cpf != null) #cpf: cpf,
      if (contato != null) #contato: contato,
      if (contatoEmergencia != null) #contatoEmergencia: contatoEmergencia,
      if (email != null) #email: email,
      if (nascimento != $none) #nascimento: nascimento,
      if (tipoSanguineo != $none) #tipoSanguineo: tipoSanguineo,
      if (faixa != $none) #faixa: faixa,
      if (grau != null) #grau: grau,
      if (idFicha != null) #idFicha: idFicha,
      if (nomeResponsavel != null) #nomeResponsavel: nomeResponsavel,
      if (cpfResponsavel != null) #cpfResponsavel: cpfResponsavel,
      if (contatoResponsavel != null) #contatoResponsavel: contatoResponsavel,
      if (emailResponsavel != null) #emailResponsavel: emailResponsavel,
      if (dirty != null) #dirty: dirty,
    }),
  );
  @override
  UpdateAlunoState $make(CopyWithData data) => UpdateAlunoState(
    alunoOriginal: data.get(#alunoOriginal, or: $value.alunoOriginal),
    responsavelOriginal: data.get(
      #responsavelOriginal,
      or: $value.responsavelOriginal,
    ),
    nome: data.get(#nome, or: $value.nome),
    cpf: data.get(#cpf, or: $value.cpf),
    contato: data.get(#contato, or: $value.contato),
    contatoEmergencia: data.get(
      #contatoEmergencia,
      or: $value.contatoEmergencia,
    ),
    email: data.get(#email, or: $value.email),
    nascimento: data.get(#nascimento, or: $value.nascimento),
    tipoSanguineo: data.get(#tipoSanguineo, or: $value.tipoSanguineo),
    faixa: data.get(#faixa, or: $value.faixa),
    grau: data.get(#grau, or: $value.grau),
    idFicha: data.get(#idFicha, or: $value.idFicha),
    nomeResponsavel: data.get(#nomeResponsavel, or: $value.nomeResponsavel),
    cpfResponsavel: data.get(#cpfResponsavel, or: $value.cpfResponsavel),
    contatoResponsavel: data.get(
      #contatoResponsavel,
      or: $value.contatoResponsavel,
    ),
    emailResponsavel: data.get(#emailResponsavel, or: $value.emailResponsavel),
    dirty: data.get(#dirty, or: $value.dirty),
  );

  @override
  UpdateAlunoStateCopyWith<$R2, UpdateAlunoState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UpdateAlunoStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

