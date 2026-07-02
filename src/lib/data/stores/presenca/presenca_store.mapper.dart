// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'presenca_store.dart';

class PresencaStateMapper extends ClassMapperBase<PresencaState> {
  PresencaStateMapper._();

  static PresencaStateMapper? _instance;
  static PresencaStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PresencaStateMapper._());
      AlunoMapper.ensureInitialized();
      LocalUserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PresencaState';

  static List<Aluno> _$alunos(PresencaState v) => v.alunos;
  static const Field<PresencaState, List<Aluno>> _f$alunos = Field(
    'alunos',
    _$alunos,
  );
  static List<LocalUser> _$usuarios(PresencaState v) => v.usuarios;
  static const Field<PresencaState, List<LocalUser>> _f$usuarios = Field(
    'usuarios',
    _$usuarios,
  );
  static LocalUser? _$professor(PresencaState v) => v.professor;
  static const Field<PresencaState, LocalUser> _f$professor = Field(
    'professor',
    _$professor,
    opt: true,
  );
  static Map<int, bool> _$presenca(PresencaState v) => v.presenca;
  static const Field<PresencaState, Map<int, bool>> _f$presenca = Field(
    'presenca',
    _$presenca,
  );
  static DateTime _$data(PresencaState v) => v.data;
  static const Field<PresencaState, DateTime> _f$data = Field('data', _$data);

  @override
  final MappableFields<PresencaState> fields = const {
    #alunos: _f$alunos,
    #usuarios: _f$usuarios,
    #professor: _f$professor,
    #presenca: _f$presenca,
    #data: _f$data,
  };

  static PresencaState _instantiate(DecodingData data) {
    return PresencaState(
      alunos: data.dec(_f$alunos),
      usuarios: data.dec(_f$usuarios),
      professor: data.dec(_f$professor),
      presenca: data.dec(_f$presenca),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PresencaState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PresencaState>(map);
  }

  static PresencaState fromJson(String json) {
    return ensureInitialized().decodeJson<PresencaState>(json);
  }
}

mixin PresencaStateMappable {
  String toJson() {
    return PresencaStateMapper.ensureInitialized().encodeJson<PresencaState>(
      this as PresencaState,
    );
  }

  Map<String, dynamic> toMap() {
    return PresencaStateMapper.ensureInitialized().encodeMap<PresencaState>(
      this as PresencaState,
    );
  }

  PresencaStateCopyWith<PresencaState, PresencaState, PresencaState>
  get copyWith => _PresencaStateCopyWithImpl<PresencaState, PresencaState>(
    this as PresencaState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PresencaStateMapper.ensureInitialized().stringifyValue(
      this as PresencaState,
    );
  }

  @override
  bool operator ==(Object other) {
    return PresencaStateMapper.ensureInitialized().equalsValue(
      this as PresencaState,
      other,
    );
  }

  @override
  int get hashCode {
    return PresencaStateMapper.ensureInitialized().hashValue(
      this as PresencaState,
    );
  }
}

extension PresencaStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PresencaState, $Out> {
  PresencaStateCopyWith<$R, PresencaState, $Out> get $asPresencaState =>
      $base.as((v, t, t2) => _PresencaStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PresencaStateCopyWith<$R, $In extends PresencaState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos;
  ListCopyWith<$R, LocalUser, LocalUserCopyWith<$R, LocalUser, LocalUser>>
  get usuarios;
  LocalUserCopyWith<$R, LocalUser, LocalUser>? get professor;
  MapCopyWith<$R, int, bool, ObjectCopyWith<$R, bool, bool>> get presenca;
  $R call({
    List<Aluno>? alunos,
    List<LocalUser>? usuarios,
    LocalUser? professor,
    Map<int, bool>? presenca,
    DateTime? data,
  });
  PresencaStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PresencaStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PresencaState, $Out>
    implements PresencaStateCopyWith<$R, PresencaState, $Out> {
  _PresencaStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PresencaState> $mapper =
      PresencaStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Aluno, AlunoCopyWith<$R, Aluno, Aluno>> get alunos =>
      ListCopyWith(
        $value.alunos,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(alunos: v),
      );
  @override
  ListCopyWith<$R, LocalUser, LocalUserCopyWith<$R, LocalUser, LocalUser>>
  get usuarios => ListCopyWith(
    $value.usuarios,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(usuarios: v),
  );
  @override
  LocalUserCopyWith<$R, LocalUser, LocalUser>? get professor =>
      $value.professor?.copyWith.$chain((v) => call(professor: v));
  @override
  MapCopyWith<$R, int, bool, ObjectCopyWith<$R, bool, bool>> get presenca =>
      MapCopyWith(
        $value.presenca,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(presenca: v),
      );
  @override
  $R call({
    List<Aluno>? alunos,
    List<LocalUser>? usuarios,
    Object? professor = $none,
    Map<int, bool>? presenca,
    DateTime? data,
  }) => $apply(
    FieldCopyWithData({
      if (alunos != null) #alunos: alunos,
      if (usuarios != null) #usuarios: usuarios,
      if (professor != $none) #professor: professor,
      if (presenca != null) #presenca: presenca,
      if (data != null) #data: data,
    }),
  );
  @override
  PresencaState $make(CopyWithData data) => PresencaState(
    alunos: data.get(#alunos, or: $value.alunos),
    usuarios: data.get(#usuarios, or: $value.usuarios),
    professor: data.get(#professor, or: $value.professor),
    presenca: data.get(#presenca, or: $value.presenca),
    data: data.get(#data, or: $value.data),
  );

  @override
  PresencaStateCopyWith<$R2, PresencaState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PresencaStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

