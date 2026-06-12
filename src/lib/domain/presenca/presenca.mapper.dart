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
    #data: _f$data,
  };
  @override
  final bool ignoreNull = true;

  static Presenca _instantiate(DecodingData data) {
    return Presenca(
      id: data.dec(_f$id),
      alunoId: data.dec(_f$alunoId),
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
  $R call({int? id, int? alunoId, DateTime? data});
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
  $R call({Object? id = $none, int? alunoId, DateTime? data}) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (alunoId != null) #alunoId: alunoId,
      if (data != null) #data: data,
    }),
  );
  @override
  Presenca $make(CopyWithData data) => Presenca(
    id: data.get(#id, or: $value.id),
    alunoId: data.get(#alunoId, or: $value.alunoId),
    data: data.get(#data, or: $value.data),
  );

  @override
  PresencaCopyWith<$R2, Presenca, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PresencaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

