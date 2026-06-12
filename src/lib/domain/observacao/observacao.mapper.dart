// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'observacao.dart';

class ObservacaoMapper extends ClassMapperBase<Observacao> {
  ObservacaoMapper._();

  static ObservacaoMapper? _instance;
  static ObservacaoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObservacaoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Observacao';

  static int? _$id(Observacao v) => v.id;
  static const Field<Observacao, int> _f$id = Field('id', _$id, opt: true);
  static String _$voluntario(Observacao v) => v.voluntario;
  static const Field<Observacao, String> _f$voluntario = Field(
    'voluntario',
    _$voluntario,
  );
  static String _$observacao(Observacao v) => v.observacao;
  static const Field<Observacao, String> _f$observacao = Field(
    'observacao',
    _$observacao,
  );
  static int _$turmaId(Observacao v) => v.turmaId;
  static const Field<Observacao, int> _f$turmaId = Field(
    'turmaId',
    _$turmaId,
    key: r'turma_id',
  );
  static DateTime _$data(Observacao v) => v.data;
  static const Field<Observacao, DateTime> _f$data = Field(
    'data',
    _$data,
    hook: HookData(),
  );

  @override
  final MappableFields<Observacao> fields = const {
    #id: _f$id,
    #voluntario: _f$voluntario,
    #observacao: _f$observacao,
    #turmaId: _f$turmaId,
    #data: _f$data,
  };
  @override
  final bool ignoreNull = true;

  static Observacao _instantiate(DecodingData data) {
    return Observacao(
      id: data.dec(_f$id),
      voluntario: data.dec(_f$voluntario),
      observacao: data.dec(_f$observacao),
      turmaId: data.dec(_f$turmaId),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Observacao fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Observacao>(map);
  }

  static Observacao fromJson(String json) {
    return ensureInitialized().decodeJson<Observacao>(json);
  }
}

mixin ObservacaoMappable {
  String toJson() {
    return ObservacaoMapper.ensureInitialized().encodeJson<Observacao>(
      this as Observacao,
    );
  }

  Map<String, dynamic> toMap() {
    return ObservacaoMapper.ensureInitialized().encodeMap<Observacao>(
      this as Observacao,
    );
  }

  ObservacaoCopyWith<Observacao, Observacao, Observacao> get copyWith =>
      _ObservacaoCopyWithImpl<Observacao, Observacao>(
        this as Observacao,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ObservacaoMapper.ensureInitialized().stringifyValue(
      this as Observacao,
    );
  }

  @override
  bool operator ==(Object other) {
    return ObservacaoMapper.ensureInitialized().equalsValue(
      this as Observacao,
      other,
    );
  }

  @override
  int get hashCode {
    return ObservacaoMapper.ensureInitialized().hashValue(this as Observacao);
  }
}

extension ObservacaoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Observacao, $Out> {
  ObservacaoCopyWith<$R, Observacao, $Out> get $asObservacao =>
      $base.as((v, t, t2) => _ObservacaoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ObservacaoCopyWith<$R, $In extends Observacao, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? voluntario,
    String? observacao,
    int? turmaId,
    DateTime? data,
  });
  ObservacaoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObservacaoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Observacao, $Out>
    implements ObservacaoCopyWith<$R, Observacao, $Out> {
  _ObservacaoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Observacao> $mapper =
      ObservacaoMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? voluntario,
    String? observacao,
    int? turmaId,
    DateTime? data,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (voluntario != null) #voluntario: voluntario,
      if (observacao != null) #observacao: observacao,
      if (turmaId != null) #turmaId: turmaId,
      if (data != null) #data: data,
    }),
  );
  @override
  Observacao $make(CopyWithData data) => Observacao(
    id: data.get(#id, or: $value.id),
    voluntario: data.get(#voluntario, or: $value.voluntario),
    observacao: data.get(#observacao, or: $value.observacao),
    turmaId: data.get(#turmaId, or: $value.turmaId),
    data: data.get(#data, or: $value.data),
  );

  @override
  ObservacaoCopyWith<$R2, Observacao, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ObservacaoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

