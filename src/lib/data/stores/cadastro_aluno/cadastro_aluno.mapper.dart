// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cadastro_aluno.dart';

class CadastroAlunoStateMapper extends ClassMapperBase<CadastroAlunoState> {
  CadastroAlunoStateMapper._();

  static CadastroAlunoStateMapper? _instance;
  static CadastroAlunoStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CadastroAlunoStateMapper._());
      TipoSanguineoMapper.ensureInitialized();
      FaixaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CadastroAlunoState';

  static String _$nome(CadastroAlunoState v) => v.nome;
  static const Field<CadastroAlunoState, String> _f$nome = Field(
    'nome',
    _$nome,
    opt: true,
    def: '',
  );
  static String? _$apelido(CadastroAlunoState v) => v.apelido;
  static const Field<CadastroAlunoState, String> _f$apelido = Field(
    'apelido',
    _$apelido,
    opt: true,
  );
  static bool _$usarApelidoComoReferencia(CadastroAlunoState v) =>
      v.usarApelidoComoReferencia;
  static const Field<CadastroAlunoState, bool> _f$usarApelidoComoReferencia =
      Field(
        'usarApelidoComoReferencia',
        _$usarApelidoComoReferencia,
        key: r'usar_apelido_como_referencia',
        opt: true,
        def: false,
      );
  static String _$cpf(CadastroAlunoState v) => v.cpf;
  static const Field<CadastroAlunoState, String> _f$cpf = Field(
    'cpf',
    _$cpf,
    opt: true,
    def: '',
  );
  static String _$contato(CadastroAlunoState v) => v.contato;
  static const Field<CadastroAlunoState, String> _f$contato = Field(
    'contato',
    _$contato,
    opt: true,
    def: '',
  );
  static String _$contatoEmergencia(CadastroAlunoState v) =>
      v.contatoEmergencia;
  static const Field<CadastroAlunoState, String> _f$contatoEmergencia = Field(
    'contatoEmergencia',
    _$contatoEmergencia,
    key: r'contato_emergencia',
    opt: true,
    def: '',
  );
  static String _$email(CadastroAlunoState v) => v.email;
  static const Field<CadastroAlunoState, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static DateTime? _$nascimento(CadastroAlunoState v) => v.nascimento;
  static const Field<CadastroAlunoState, DateTime> _f$nascimento = Field(
    'nascimento',
    _$nascimento,
    opt: true,
  );
  static TipoSanguineo? _$tipoSanguineo(CadastroAlunoState v) =>
      v.tipoSanguineo;
  static const Field<CadastroAlunoState, TipoSanguineo> _f$tipoSanguineo =
      Field(
        'tipoSanguineo',
        _$tipoSanguineo,
        key: r'tipo_sanguineo',
        opt: true,
      );
  static Faixa? _$faixa(CadastroAlunoState v) => v.faixa;
  static const Field<CadastroAlunoState, Faixa> _f$faixa = Field(
    'faixa',
    _$faixa,
    opt: true,
  );
  static int _$grau(CadastroAlunoState v) => v.grau;
  static const Field<CadastroAlunoState, int> _f$grau = Field(
    'grau',
    _$grau,
    opt: true,
    def: 0,
  );
  static String _$idFicha(CadastroAlunoState v) => v.idFicha;
  static const Field<CadastroAlunoState, String> _f$idFicha = Field(
    'idFicha',
    _$idFicha,
    key: r'id_ficha',
    opt: true,
    def: '',
  );
  static String _$nomeResponsavel(CadastroAlunoState v) => v.nomeResponsavel;
  static const Field<CadastroAlunoState, String> _f$nomeResponsavel = Field(
    'nomeResponsavel',
    _$nomeResponsavel,
    key: r'nome_responsavel',
    opt: true,
    def: '',
  );
  static String _$cpfResponsavel(CadastroAlunoState v) => v.cpfResponsavel;
  static const Field<CadastroAlunoState, String> _f$cpfResponsavel = Field(
    'cpfResponsavel',
    _$cpfResponsavel,
    key: r'cpf_responsavel',
    opt: true,
    def: '',
  );
  static String _$contatoResponsavel(CadastroAlunoState v) =>
      v.contatoResponsavel;
  static const Field<CadastroAlunoState, String> _f$contatoResponsavel = Field(
    'contatoResponsavel',
    _$contatoResponsavel,
    key: r'contato_responsavel',
    opt: true,
    def: '',
  );
  static String _$emailResponsavel(CadastroAlunoState v) => v.emailResponsavel;
  static const Field<CadastroAlunoState, String> _f$emailResponsavel = Field(
    'emailResponsavel',
    _$emailResponsavel,
    key: r'email_responsavel',
    opt: true,
    def: '',
  );
  static bool _$dirty(CadastroAlunoState v) => v.dirty;
  static const Field<CadastroAlunoState, bool> _f$dirty = Field(
    'dirty',
    _$dirty,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<CadastroAlunoState> fields = const {
    #nome: _f$nome,
    #apelido: _f$apelido,
    #usarApelidoComoReferencia: _f$usarApelidoComoReferencia,
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

  static CadastroAlunoState _instantiate(DecodingData data) {
    return CadastroAlunoState(
      nome: data.dec(_f$nome),
      apelido: data.dec(_f$apelido),
      usarApelidoComoReferencia: data.dec(_f$usarApelidoComoReferencia),
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

  static CadastroAlunoState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CadastroAlunoState>(map);
  }

  static CadastroAlunoState fromJson(String json) {
    return ensureInitialized().decodeJson<CadastroAlunoState>(json);
  }
}

mixin CadastroAlunoStateMappable {
  String toJson() {
    return CadastroAlunoStateMapper.ensureInitialized()
        .encodeJson<CadastroAlunoState>(this as CadastroAlunoState);
  }

  Map<String, dynamic> toMap() {
    return CadastroAlunoStateMapper.ensureInitialized()
        .encodeMap<CadastroAlunoState>(this as CadastroAlunoState);
  }

  CadastroAlunoStateCopyWith<
    CadastroAlunoState,
    CadastroAlunoState,
    CadastroAlunoState
  >
  get copyWith =>
      _CadastroAlunoStateCopyWithImpl<CadastroAlunoState, CadastroAlunoState>(
        this as CadastroAlunoState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CadastroAlunoStateMapper.ensureInitialized().stringifyValue(
      this as CadastroAlunoState,
    );
  }

  @override
  bool operator ==(Object other) {
    return CadastroAlunoStateMapper.ensureInitialized().equalsValue(
      this as CadastroAlunoState,
      other,
    );
  }

  @override
  int get hashCode {
    return CadastroAlunoStateMapper.ensureInitialized().hashValue(
      this as CadastroAlunoState,
    );
  }
}

extension CadastroAlunoStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CadastroAlunoState, $Out> {
  CadastroAlunoStateCopyWith<$R, CadastroAlunoState, $Out>
  get $asCadastroAlunoState => $base.as(
    (v, t, t2) => _CadastroAlunoStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CadastroAlunoStateCopyWith<
  $R,
  $In extends CadastroAlunoState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? nome,
    String? apelido,
    bool? usarApelidoComoReferencia,
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
  CadastroAlunoStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CadastroAlunoStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CadastroAlunoState, $Out>
    implements CadastroAlunoStateCopyWith<$R, CadastroAlunoState, $Out> {
  _CadastroAlunoStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CadastroAlunoState> $mapper =
      CadastroAlunoStateMapper.ensureInitialized();
  @override
  $R call({
    String? nome,
    Object? apelido = $none,
    bool? usarApelidoComoReferencia,
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
      if (nome != null) #nome: nome,
      if (apelido != $none) #apelido: apelido,
      if (usarApelidoComoReferencia != null)
        #usarApelidoComoReferencia: usarApelidoComoReferencia,
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
  CadastroAlunoState $make(CopyWithData data) => CadastroAlunoState(
    nome: data.get(#nome, or: $value.nome),
    apelido: data.get(#apelido, or: $value.apelido),
    usarApelidoComoReferencia: data.get(
      #usarApelidoComoReferencia,
      or: $value.usarApelidoComoReferencia,
    ),
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
  CadastroAlunoStateCopyWith<$R2, CadastroAlunoState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CadastroAlunoStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

