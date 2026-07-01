// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'presenca.dart';

class PresencaMapper extends ClassMapperBase<Presenca> {
  PresencaMapper._();

  static PresencaMapper? _instance;
  static PresencaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PresencaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Presenca';

  static int? _$id(Presenca v) => v.id;
  static const Field<Presenca, int> _f$id = Field('id', _$id, opt: true);
  static int _$alunoId(Presenca v) => v.alunoId;
  static const Field<Presenca, int> _f$alunoId = Field(
    'alunoId',
    _$alunoId,
    key: r'aluno_id',
  );
  static int _$turmaId(Presenca v) => v.turmaId;
  static const Field<Presenca, int> _f$turmaId = Field(
    'turmaId',
    _$turmaId,
    key: r'turma_id',
  );
  static DateTime _$data(Presenca v) => v.data;
  static const Field<Presenca, DateTime> _f$data = Field(
    'data',
    _$data,
    hook: HookData(),
  );

  @override
  final MappableFields<Presenca> fields = const {
    #id: _f$id,
    #alunoId: _f$alunoId,
    #turmaId: _f$turmaId,
    #data: _f$data,
  };

  static Presenca _instantiate(DecodingData data) {
    return Presenca(
      id: data.dec(_f$id),
      alunoId: data.dec(_f$alunoId),
      turmaId: data.dec(_f$turmaId),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Presenca fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Presenca>(map);
  }

  static Presenca fromJson(String json) {
    return ensureInitialized().decodeJson<Presenca>(json);
  }
}

mixin PresencaMappable {
  String toJson() {
    return PresencaMapper.ensureInitialized().encodeJson<Presenca>(
      this as Presenca,
    );
  }

  Map<String, dynamic> toMap() {
    return PresencaMapper.ensureInitialized().encodeMap<Presenca>(
      this as Presenca,
    );
  }

  PresencaCopyWith<Presenca, Presenca, Presenca> get copyWith =>
      _PresencaCopyWithImpl<Presenca, Presenca>(
        this as Presenca,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PresencaMapper.ensureInitialized().stringifyValue(this as Presenca);
  }

  @override
  bool operator ==(Object other) {
    return PresencaMapper.ensureInitialized().equalsValue(
      this as Presenca,
      other,
    );
  }

  @override
  int get hashCode {
    return PresencaMapper.ensureInitialized().hashValue(this as Presenca);
  }
}

extension PresencaValueCopy<$R, $Out> on ObjectCopyWith<$R, Presenca, $Out> {
  PresencaCopyWith<$R, Presenca, $Out> get $asPresenca =>
      $base.as((v, t, t2) => _PresencaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PresencaCopyWith<$R, $In extends Presenca, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, int? alunoId, int? turmaId, DateTime? data});
  PresencaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PresencaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Presenca, $Out>
    implements PresencaCopyWith<$R, Presenca, $Out> {
  _PresencaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Presenca> $mapper =
      PresencaMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, int? alunoId, int? turmaId, DateTime? data}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (alunoId != null) #alunoId: alunoId,
          if (turmaId != null) #turmaId: turmaId,
          if (data != null) #data: data,
        }),
      );
  @override
  Presenca $make(CopyWithData data) => Presenca(
    id: data.get(#id, or: $value.id),
    alunoId: data.get(#alunoId, or: $value.alunoId),
    turmaId: data.get(#turmaId, or: $value.turmaId),
    data: data.get(#data, or: $value.data),
  );

  @override
  PresencaCopyWith<$R2, Presenca, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PresencaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UltimaPresencaMapper extends ClassMapperBase<UltimaPresenca> {
  UltimaPresencaMapper._();

  static UltimaPresencaMapper? _instance;
  static UltimaPresencaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UltimaPresencaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UltimaPresenca';

  static int _$alunoId(UltimaPresenca v) => v.alunoId;
  static const Field<UltimaPresenca, int> _f$alunoId = Field(
    'alunoId',
    _$alunoId,
    key: r'aluno_id',
  );
  static String _$alunoNome(UltimaPresenca v) => v.alunoNome;
  static const Field<UltimaPresenca, String> _f$alunoNome = Field(
    'alunoNome',
    _$alunoNome,
    key: r'aluno_nome',
  );
  static DateTime? _$dataUltimaPresenca(UltimaPresenca v) =>
      v.dataUltimaPresenca;
  static const Field<UltimaPresenca, DateTime> _f$dataUltimaPresenca = Field(
    'dataUltimaPresenca',
    _$dataUltimaPresenca,
    key: r'data_ultima_presenca',
    hook: HookData(),
  );
  static int? _$diasDesdeUltimaPresenca(UltimaPresenca v) =>
      v.diasDesdeUltimaPresenca;
  static const Field<UltimaPresenca, int> _f$diasDesdeUltimaPresenca = Field(
    'diasDesdeUltimaPresenca',
    _$diasDesdeUltimaPresenca,
    key: r'dias_desde_ultima_presenca',
  );

  @override
  final MappableFields<UltimaPresenca> fields = const {
    #alunoId: _f$alunoId,
    #alunoNome: _f$alunoNome,
    #dataUltimaPresenca: _f$dataUltimaPresenca,
    #diasDesdeUltimaPresenca: _f$diasDesdeUltimaPresenca,
  };

  static UltimaPresenca _instantiate(DecodingData data) {
    return UltimaPresenca(
      alunoId: data.dec(_f$alunoId),
      alunoNome: data.dec(_f$alunoNome),
      dataUltimaPresenca: data.dec(_f$dataUltimaPresenca),
      diasDesdeUltimaPresenca: data.dec(_f$diasDesdeUltimaPresenca),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UltimaPresenca fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UltimaPresenca>(map);
  }

  static UltimaPresenca fromJson(String json) {
    return ensureInitialized().decodeJson<UltimaPresenca>(json);
  }
}

mixin UltimaPresencaMappable {
  String toJson() {
    return UltimaPresencaMapper.ensureInitialized().encodeJson<UltimaPresenca>(
      this as UltimaPresenca,
    );
  }

  Map<String, dynamic> toMap() {
    return UltimaPresencaMapper.ensureInitialized().encodeMap<UltimaPresenca>(
      this as UltimaPresenca,
    );
  }

  UltimaPresencaCopyWith<UltimaPresenca, UltimaPresenca, UltimaPresenca>
  get copyWith => _UltimaPresencaCopyWithImpl<UltimaPresenca, UltimaPresenca>(
    this as UltimaPresenca,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UltimaPresencaMapper.ensureInitialized().stringifyValue(
      this as UltimaPresenca,
    );
  }

  @override
  bool operator ==(Object other) {
    return UltimaPresencaMapper.ensureInitialized().equalsValue(
      this as UltimaPresenca,
      other,
    );
  }

  @override
  int get hashCode {
    return UltimaPresencaMapper.ensureInitialized().hashValue(
      this as UltimaPresenca,
    );
  }
}

extension UltimaPresencaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UltimaPresenca, $Out> {
  UltimaPresencaCopyWith<$R, UltimaPresenca, $Out> get $asUltimaPresenca =>
      $base.as((v, t, t2) => _UltimaPresencaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UltimaPresencaCopyWith<$R, $In extends UltimaPresenca, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? alunoId,
    String? alunoNome,
    DateTime? dataUltimaPresenca,
    int? diasDesdeUltimaPresenca,
  });
  UltimaPresencaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UltimaPresencaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UltimaPresenca, $Out>
    implements UltimaPresencaCopyWith<$R, UltimaPresenca, $Out> {
  _UltimaPresencaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UltimaPresenca> $mapper =
      UltimaPresencaMapper.ensureInitialized();
  @override
  $R call({
    int? alunoId,
    String? alunoNome,
    Object? dataUltimaPresenca = $none,
    Object? diasDesdeUltimaPresenca = $none,
  }) => $apply(
    FieldCopyWithData({
      if (alunoId != null) #alunoId: alunoId,
      if (alunoNome != null) #alunoNome: alunoNome,
      if (dataUltimaPresenca != $none) #dataUltimaPresenca: dataUltimaPresenca,
      if (diasDesdeUltimaPresenca != $none)
        #diasDesdeUltimaPresenca: diasDesdeUltimaPresenca,
    }),
  );
  @override
  UltimaPresenca $make(CopyWithData data) => UltimaPresenca(
    alunoId: data.get(#alunoId, or: $value.alunoId),
    alunoNome: data.get(#alunoNome, or: $value.alunoNome),
    dataUltimaPresenca: data.get(
      #dataUltimaPresenca,
      or: $value.dataUltimaPresenca,
    ),
    diasDesdeUltimaPresenca: data.get(
      #diasDesdeUltimaPresenca,
      or: $value.diasDesdeUltimaPresenca,
    ),
  );

  @override
  UltimaPresencaCopyWith<$R2, UltimaPresenca, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UltimaPresencaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

