// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'registro_kimonos_store.dart';

class RegistroKimonosStateMapper extends ClassMapperBase<RegistroKimonosState> {
  RegistroKimonosStateMapper._();

  static RegistroKimonosStateMapper? _instance;
  static RegistroKimonosStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegistroKimonosStateMapper._());
      TamanhoKimonoMapper.ensureInitialized();
      CorKimonoMapper.ensureInitialized();
      EstoqueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RegistroKimonosState';

  static TamanhoKimono? _$tamanhoDoacao(RegistroKimonosState v) =>
      v.tamanhoDoacao;
  static const Field<RegistroKimonosState, TamanhoKimono> _f$tamanhoDoacao =
      Field(
        'tamanhoDoacao',
        _$tamanhoDoacao,
        key: r'tamanho_doacao',
        opt: true,
      );
  static CorKimono? _$corDoacao(RegistroKimonosState v) => v.corDoacao;
  static const Field<RegistroKimonosState, CorKimono> _f$corDoacao = Field(
    'corDoacao',
    _$corDoacao,
    key: r'cor_doacao',
    opt: true,
  );
  static String _$doador(RegistroKimonosState v) => v.doador;
  static const Field<RegistroKimonosState, String> _f$doador = Field(
    'doador',
    _$doador,
    opt: true,
    def: '',
  );
  static String _$qtdDoada(RegistroKimonosState v) => v.qtdDoada;
  static const Field<RegistroKimonosState, String> _f$qtdDoada = Field(
    'qtdDoada',
    _$qtdDoada,
    key: r'qtd_doada',
    opt: true,
    def: '',
  );
  static Estoque? _$kimonoPerdido(RegistroKimonosState v) => v.kimonoPerdido;
  static const Field<RegistroKimonosState, Estoque> _f$kimonoPerdido = Field(
    'kimonoPerdido',
    _$kimonoPerdido,
    key: r'kimono_perdido',
    opt: true,
  );
  static String _$motivo(RegistroKimonosState v) => v.motivo;
  static const Field<RegistroKimonosState, String> _f$motivo = Field(
    'motivo',
    _$motivo,
    opt: true,
    def: '',
  );
  static String _$qtdPerdida(RegistroKimonosState v) => v.qtdPerdida;
  static const Field<RegistroKimonosState, String> _f$qtdPerdida = Field(
    'qtdPerdida',
    _$qtdPerdida,
    key: r'qtd_perdida',
    opt: true,
    def: '',
  );

  @override
  final MappableFields<RegistroKimonosState> fields = const {
    #tamanhoDoacao: _f$tamanhoDoacao,
    #corDoacao: _f$corDoacao,
    #doador: _f$doador,
    #qtdDoada: _f$qtdDoada,
    #kimonoPerdido: _f$kimonoPerdido,
    #motivo: _f$motivo,
    #qtdPerdida: _f$qtdPerdida,
  };

  static RegistroKimonosState _instantiate(DecodingData data) {
    return RegistroKimonosState(
      tamanhoDoacao: data.dec(_f$tamanhoDoacao),
      corDoacao: data.dec(_f$corDoacao),
      doador: data.dec(_f$doador),
      qtdDoada: data.dec(_f$qtdDoada),
      kimonoPerdido: data.dec(_f$kimonoPerdido),
      motivo: data.dec(_f$motivo),
      qtdPerdida: data.dec(_f$qtdPerdida),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RegistroKimonosState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegistroKimonosState>(map);
  }

  static RegistroKimonosState fromJson(String json) {
    return ensureInitialized().decodeJson<RegistroKimonosState>(json);
  }
}

mixin RegistroKimonosStateMappable {
  String toJson() {
    return RegistroKimonosStateMapper.ensureInitialized()
        .encodeJson<RegistroKimonosState>(this as RegistroKimonosState);
  }

  Map<String, dynamic> toMap() {
    return RegistroKimonosStateMapper.ensureInitialized()
        .encodeMap<RegistroKimonosState>(this as RegistroKimonosState);
  }

  RegistroKimonosStateCopyWith<
    RegistroKimonosState,
    RegistroKimonosState,
    RegistroKimonosState
  >
  get copyWith =>
      _RegistroKimonosStateCopyWithImpl<
        RegistroKimonosState,
        RegistroKimonosState
      >(this as RegistroKimonosState, $identity, $identity);
  @override
  String toString() {
    return RegistroKimonosStateMapper.ensureInitialized().stringifyValue(
      this as RegistroKimonosState,
    );
  }

  @override
  bool operator ==(Object other) {
    return RegistroKimonosStateMapper.ensureInitialized().equalsValue(
      this as RegistroKimonosState,
      other,
    );
  }

  @override
  int get hashCode {
    return RegistroKimonosStateMapper.ensureInitialized().hashValue(
      this as RegistroKimonosState,
    );
  }
}

extension RegistroKimonosStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegistroKimonosState, $Out> {
  RegistroKimonosStateCopyWith<$R, RegistroKimonosState, $Out>
  get $asRegistroKimonosState => $base.as(
    (v, t, t2) => _RegistroKimonosStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RegistroKimonosStateCopyWith<
  $R,
  $In extends RegistroKimonosState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  EstoqueCopyWith<$R, Estoque, Estoque>? get kimonoPerdido;
  $R call({
    TamanhoKimono? tamanhoDoacao,
    CorKimono? corDoacao,
    String? doador,
    String? qtdDoada,
    Estoque? kimonoPerdido,
    String? motivo,
    String? qtdPerdida,
  });
  RegistroKimonosStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RegistroKimonosStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegistroKimonosState, $Out>
    implements RegistroKimonosStateCopyWith<$R, RegistroKimonosState, $Out> {
  _RegistroKimonosStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegistroKimonosState> $mapper =
      RegistroKimonosStateMapper.ensureInitialized();
  @override
  EstoqueCopyWith<$R, Estoque, Estoque>? get kimonoPerdido =>
      $value.kimonoPerdido?.copyWith.$chain((v) => call(kimonoPerdido: v));
  @override
  $R call({
    Object? tamanhoDoacao = $none,
    Object? corDoacao = $none,
    String? doador,
    String? qtdDoada,
    Object? kimonoPerdido = $none,
    String? motivo,
    String? qtdPerdida,
  }) => $apply(
    FieldCopyWithData({
      if (tamanhoDoacao != $none) #tamanhoDoacao: tamanhoDoacao,
      if (corDoacao != $none) #corDoacao: corDoacao,
      if (doador != null) #doador: doador,
      if (qtdDoada != null) #qtdDoada: qtdDoada,
      if (kimonoPerdido != $none) #kimonoPerdido: kimonoPerdido,
      if (motivo != null) #motivo: motivo,
      if (qtdPerdida != null) #qtdPerdida: qtdPerdida,
    }),
  );
  @override
  RegistroKimonosState $make(CopyWithData data) => RegistroKimonosState(
    tamanhoDoacao: data.get(#tamanhoDoacao, or: $value.tamanhoDoacao),
    corDoacao: data.get(#corDoacao, or: $value.corDoacao),
    doador: data.get(#doador, or: $value.doador),
    qtdDoada: data.get(#qtdDoada, or: $value.qtdDoada),
    kimonoPerdido: data.get(#kimonoPerdido, or: $value.kimonoPerdido),
    motivo: data.get(#motivo, or: $value.motivo),
    qtdPerdida: data.get(#qtdPerdida, or: $value.qtdPerdida),
  );

  @override
  RegistroKimonosStateCopyWith<$R2, RegistroKimonosState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RegistroKimonosStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

