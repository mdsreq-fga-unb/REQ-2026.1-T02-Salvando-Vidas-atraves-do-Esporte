// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'kimono.dart';

class CorKimonoMapper extends EnumMapper<CorKimono> {
  CorKimonoMapper._();

  static CorKimonoMapper? _instance;
  static CorKimonoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CorKimonoMapper._());
    }
    return _instance!;
  }

  static CorKimono fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CorKimono decode(dynamic value) {
    switch (value) {
      case r'azul':
        return CorKimono.azul;
      case r'branco':
        return CorKimono.branco;
      case r'preto':
        return CorKimono.preto;
      case r'rosa':
        return CorKimono.rosa;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CorKimono self) {
    switch (self) {
      case CorKimono.azul:
        return r'azul';
      case CorKimono.branco:
        return r'branco';
      case CorKimono.preto:
        return r'preto';
      case CorKimono.rosa:
        return r'rosa';
    }
  }
}

extension CorKimonoMapperExtension on CorKimono {
  String toValue() {
    CorKimonoMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CorKimono>(this) as String;
  }
}

class TamanhoKimonoMapper extends EnumMapper<TamanhoKimono> {
  TamanhoKimonoMapper._();

  static TamanhoKimonoMapper? _instance;
  static TamanhoKimonoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TamanhoKimonoMapper._());
    }
    return _instance!;
  }

  static TamanhoKimono fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TamanhoKimono decode(dynamic value) {
    switch (value) {
      case r'A0':
        return TamanhoKimono.a0;
      case r'A1':
        return TamanhoKimono.a1;
      case r'A2':
        return TamanhoKimono.a2;
      case r'A3':
        return TamanhoKimono.a3;
      case r'A4':
        return TamanhoKimono.a4;
      case r'A5':
        return TamanhoKimono.a5;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TamanhoKimono self) {
    switch (self) {
      case TamanhoKimono.a0:
        return r'A0';
      case TamanhoKimono.a1:
        return r'A1';
      case TamanhoKimono.a2:
        return r'A2';
      case TamanhoKimono.a3:
        return r'A3';
      case TamanhoKimono.a4:
        return r'A4';
      case TamanhoKimono.a5:
        return r'A5';
    }
  }
}

extension TamanhoKimonoMapperExtension on TamanhoKimono {
  String toValue() {
    TamanhoKimonoMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TamanhoKimono>(this) as String;
  }
}

class DoacaoMapper extends ClassMapperBase<Doacao> {
  DoacaoMapper._();

  static DoacaoMapper? _instance;
  static DoacaoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoacaoMapper._());
      CorKimonoMapper.ensureInitialized();
      TamanhoKimonoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Doacao';

  static int? _$id(Doacao v) => v.id;
  static const Field<Doacao, int> _f$id = Field('id', _$id, opt: true);
  static String _$doador(Doacao v) => v.doador;
  static const Field<Doacao, String> _f$doador = Field('doador', _$doador);
  static CorKimono _$cor(Doacao v) => v.cor;
  static const Field<Doacao, CorKimono> _f$cor = Field('cor', _$cor);
  static TamanhoKimono _$tamanho(Doacao v) => v.tamanho;
  static const Field<Doacao, TamanhoKimono> _f$tamanho = Field(
    'tamanho',
    _$tamanho,
  );
  static int _$quantidade(Doacao v) => v.quantidade;
  static const Field<Doacao, int> _f$quantidade = Field(
    'quantidade',
    _$quantidade,
  );
  static DateTime _$data(Doacao v) => v.data;
  static const Field<Doacao, DateTime> _f$data = Field('data', _$data);

  @override
  final MappableFields<Doacao> fields = const {
    #id: _f$id,
    #doador: _f$doador,
    #cor: _f$cor,
    #tamanho: _f$tamanho,
    #quantidade: _f$quantidade,
    #data: _f$data,
  };

  static Doacao _instantiate(DecodingData data) {
    return Doacao(
      id: data.dec(_f$id),
      doador: data.dec(_f$doador),
      cor: data.dec(_f$cor),
      tamanho: data.dec(_f$tamanho),
      quantidade: data.dec(_f$quantidade),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Doacao fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Doacao>(map);
  }

  static Doacao fromJson(String json) {
    return ensureInitialized().decodeJson<Doacao>(json);
  }
}

mixin DoacaoMappable {
  String toJson() {
    return DoacaoMapper.ensureInitialized().encodeJson<Doacao>(this as Doacao);
  }

  Map<String, dynamic> toMap() {
    return DoacaoMapper.ensureInitialized().encodeMap<Doacao>(this as Doacao);
  }

  DoacaoCopyWith<Doacao, Doacao, Doacao> get copyWith =>
      _DoacaoCopyWithImpl<Doacao, Doacao>(this as Doacao, $identity, $identity);
  @override
  String toString() {
    return DoacaoMapper.ensureInitialized().stringifyValue(this as Doacao);
  }

  @override
  bool operator ==(Object other) {
    return DoacaoMapper.ensureInitialized().equalsValue(this as Doacao, other);
  }

  @override
  int get hashCode {
    return DoacaoMapper.ensureInitialized().hashValue(this as Doacao);
  }
}

extension DoacaoValueCopy<$R, $Out> on ObjectCopyWith<$R, Doacao, $Out> {
  DoacaoCopyWith<$R, Doacao, $Out> get $asDoacao =>
      $base.as((v, t, t2) => _DoacaoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DoacaoCopyWith<$R, $In extends Doacao, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? doador,
    CorKimono? cor,
    TamanhoKimono? tamanho,
    int? quantidade,
    DateTime? data,
  });
  DoacaoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoacaoCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Doacao, $Out>
    implements DoacaoCopyWith<$R, Doacao, $Out> {
  _DoacaoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Doacao> $mapper = DoacaoMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? doador,
    CorKimono? cor,
    TamanhoKimono? tamanho,
    int? quantidade,
    DateTime? data,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (doador != null) #doador: doador,
      if (cor != null) #cor: cor,
      if (tamanho != null) #tamanho: tamanho,
      if (quantidade != null) #quantidade: quantidade,
      if (data != null) #data: data,
    }),
  );
  @override
  Doacao $make(CopyWithData data) => Doacao(
    id: data.get(#id, or: $value.id),
    doador: data.get(#doador, or: $value.doador),
    cor: data.get(#cor, or: $value.cor),
    tamanho: data.get(#tamanho, or: $value.tamanho),
    quantidade: data.get(#quantidade, or: $value.quantidade),
    data: data.get(#data, or: $value.data),
  );

  @override
  DoacaoCopyWith<$R2, Doacao, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DoacaoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PerdaMapper extends ClassMapperBase<Perda> {
  PerdaMapper._();

  static PerdaMapper? _instance;
  static PerdaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PerdaMapper._());
      CorKimonoMapper.ensureInitialized();
      TamanhoKimonoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Perda';

  static int? _$id(Perda v) => v.id;
  static const Field<Perda, int> _f$id = Field('id', _$id, opt: true);
  static CorKimono _$cor(Perda v) => v.cor;
  static const Field<Perda, CorKimono> _f$cor = Field('cor', _$cor);
  static TamanhoKimono _$tamanho(Perda v) => v.tamanho;
  static const Field<Perda, TamanhoKimono> _f$tamanho = Field(
    'tamanho',
    _$tamanho,
  );
  static int _$quantidade(Perda v) => v.quantidade;
  static const Field<Perda, int> _f$quantidade = Field(
    'quantidade',
    _$quantidade,
  );
  static String _$motivo(Perda v) => v.motivo;
  static const Field<Perda, String> _f$motivo = Field('motivo', _$motivo);
  static DateTime _$data(Perda v) => v.data;
  static const Field<Perda, DateTime> _f$data = Field('data', _$data);

  @override
  final MappableFields<Perda> fields = const {
    #id: _f$id,
    #cor: _f$cor,
    #tamanho: _f$tamanho,
    #quantidade: _f$quantidade,
    #motivo: _f$motivo,
    #data: _f$data,
  };

  static Perda _instantiate(DecodingData data) {
    return Perda(
      id: data.dec(_f$id),
      cor: data.dec(_f$cor),
      tamanho: data.dec(_f$tamanho),
      quantidade: data.dec(_f$quantidade),
      motivo: data.dec(_f$motivo),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Perda fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Perda>(map);
  }

  static Perda fromJson(String json) {
    return ensureInitialized().decodeJson<Perda>(json);
  }
}

mixin PerdaMappable {
  String toJson() {
    return PerdaMapper.ensureInitialized().encodeJson<Perda>(this as Perda);
  }

  Map<String, dynamic> toMap() {
    return PerdaMapper.ensureInitialized().encodeMap<Perda>(this as Perda);
  }

  PerdaCopyWith<Perda, Perda, Perda> get copyWith =>
      _PerdaCopyWithImpl<Perda, Perda>(this as Perda, $identity, $identity);
  @override
  String toString() {
    return PerdaMapper.ensureInitialized().stringifyValue(this as Perda);
  }

  @override
  bool operator ==(Object other) {
    return PerdaMapper.ensureInitialized().equalsValue(this as Perda, other);
  }

  @override
  int get hashCode {
    return PerdaMapper.ensureInitialized().hashValue(this as Perda);
  }
}

extension PerdaValueCopy<$R, $Out> on ObjectCopyWith<$R, Perda, $Out> {
  PerdaCopyWith<$R, Perda, $Out> get $asPerda =>
      $base.as((v, t, t2) => _PerdaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PerdaCopyWith<$R, $In extends Perda, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    CorKimono? cor,
    TamanhoKimono? tamanho,
    int? quantidade,
    String? motivo,
    DateTime? data,
  });
  PerdaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PerdaCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Perda, $Out>
    implements PerdaCopyWith<$R, Perda, $Out> {
  _PerdaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Perda> $mapper = PerdaMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    CorKimono? cor,
    TamanhoKimono? tamanho,
    int? quantidade,
    String? motivo,
    DateTime? data,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (cor != null) #cor: cor,
      if (tamanho != null) #tamanho: tamanho,
      if (quantidade != null) #quantidade: quantidade,
      if (motivo != null) #motivo: motivo,
      if (data != null) #data: data,
    }),
  );
  @override
  Perda $make(CopyWithData data) => Perda(
    id: data.get(#id, or: $value.id),
    cor: data.get(#cor, or: $value.cor),
    tamanho: data.get(#tamanho, or: $value.tamanho),
    quantidade: data.get(#quantidade, or: $value.quantidade),
    motivo: data.get(#motivo, or: $value.motivo),
    data: data.get(#data, or: $value.data),
  );

  @override
  PerdaCopyWith<$R2, Perda, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PerdaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EmprestimoMapper extends ClassMapperBase<Emprestimo> {
  EmprestimoMapper._();

  static EmprestimoMapper? _instance;
  static EmprestimoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmprestimoMapper._());
      CorKimonoMapper.ensureInitialized();
      TamanhoKimonoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Emprestimo';

  static int? _$id(Emprestimo v) => v.id;
  static const Field<Emprestimo, int> _f$id = Field('id', _$id, opt: true);
  static int _$alunoId(Emprestimo v) => v.alunoId;
  static const Field<Emprestimo, int> _f$alunoId = Field(
    'alunoId',
    _$alunoId,
    key: r'aluno_id',
  );
  static CorKimono _$cor(Emprestimo v) => v.cor;
  static const Field<Emprestimo, CorKimono> _f$cor = Field('cor', _$cor);
  static TamanhoKimono _$tamanho(Emprestimo v) => v.tamanho;
  static const Field<Emprestimo, TamanhoKimono> _f$tamanho = Field(
    'tamanho',
    _$tamanho,
  );
  static DateTime _$data(Emprestimo v) => v.data;
  static const Field<Emprestimo, DateTime> _f$data = Field('data', _$data);
  static DateTime? _$dataDevolucao(Emprestimo v) => v.dataDevolucao;
  static const Field<Emprestimo, DateTime> _f$dataDevolucao = Field(
    'dataDevolucao',
    _$dataDevolucao,
    key: r'data_devolucao',
    opt: true,
  );

  @override
  final MappableFields<Emprestimo> fields = const {
    #id: _f$id,
    #alunoId: _f$alunoId,
    #cor: _f$cor,
    #tamanho: _f$tamanho,
    #data: _f$data,
    #dataDevolucao: _f$dataDevolucao,
  };

  static Emprestimo _instantiate(DecodingData data) {
    return Emprestimo(
      id: data.dec(_f$id),
      alunoId: data.dec(_f$alunoId),
      cor: data.dec(_f$cor),
      tamanho: data.dec(_f$tamanho),
      data: data.dec(_f$data),
      dataDevolucao: data.dec(_f$dataDevolucao),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Emprestimo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Emprestimo>(map);
  }

  static Emprestimo fromJson(String json) {
    return ensureInitialized().decodeJson<Emprestimo>(json);
  }
}

mixin EmprestimoMappable {
  String toJson() {
    return EmprestimoMapper.ensureInitialized().encodeJson<Emprestimo>(
      this as Emprestimo,
    );
  }

  Map<String, dynamic> toMap() {
    return EmprestimoMapper.ensureInitialized().encodeMap<Emprestimo>(
      this as Emprestimo,
    );
  }

  EmprestimoCopyWith<Emprestimo, Emprestimo, Emprestimo> get copyWith =>
      _EmprestimoCopyWithImpl<Emprestimo, Emprestimo>(
        this as Emprestimo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EmprestimoMapper.ensureInitialized().stringifyValue(
      this as Emprestimo,
    );
  }

  @override
  bool operator ==(Object other) {
    return EmprestimoMapper.ensureInitialized().equalsValue(
      this as Emprestimo,
      other,
    );
  }

  @override
  int get hashCode {
    return EmprestimoMapper.ensureInitialized().hashValue(this as Emprestimo);
  }
}

extension EmprestimoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Emprestimo, $Out> {
  EmprestimoCopyWith<$R, Emprestimo, $Out> get $asEmprestimo =>
      $base.as((v, t, t2) => _EmprestimoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EmprestimoCopyWith<$R, $In extends Emprestimo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    int? alunoId,
    CorKimono? cor,
    TamanhoKimono? tamanho,
    DateTime? data,
    DateTime? dataDevolucao,
  });
  EmprestimoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EmprestimoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Emprestimo, $Out>
    implements EmprestimoCopyWith<$R, Emprestimo, $Out> {
  _EmprestimoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Emprestimo> $mapper =
      EmprestimoMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    int? alunoId,
    CorKimono? cor,
    TamanhoKimono? tamanho,
    DateTime? data,
    Object? dataDevolucao = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (alunoId != null) #alunoId: alunoId,
      if (cor != null) #cor: cor,
      if (tamanho != null) #tamanho: tamanho,
      if (data != null) #data: data,
      if (dataDevolucao != $none) #dataDevolucao: dataDevolucao,
    }),
  );
  @override
  Emprestimo $make(CopyWithData data) => Emprestimo(
    id: data.get(#id, or: $value.id),
    alunoId: data.get(#alunoId, or: $value.alunoId),
    cor: data.get(#cor, or: $value.cor),
    tamanho: data.get(#tamanho, or: $value.tamanho),
    data: data.get(#data, or: $value.data),
    dataDevolucao: data.get(#dataDevolucao, or: $value.dataDevolucao),
  );

  @override
  EmprestimoCopyWith<$R2, Emprestimo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EmprestimoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EstoqueMapper extends ClassMapperBase<Estoque> {
  EstoqueMapper._();

  static EstoqueMapper? _instance;
  static EstoqueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EstoqueMapper._());
      CorKimonoMapper.ensureInitialized();
      TamanhoKimonoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Estoque';

  static CorKimono _$cor(Estoque v) => v.cor;
  static const Field<Estoque, CorKimono> _f$cor = Field('cor', _$cor);
  static TamanhoKimono _$tamanho(Estoque v) => v.tamanho;
  static const Field<Estoque, TamanhoKimono> _f$tamanho = Field(
    'tamanho',
    _$tamanho,
  );
  static int _$quantidadeDisponivel(Estoque v) => v.quantidadeDisponivel;
  static const Field<Estoque, int> _f$quantidadeDisponivel = Field(
    'quantidadeDisponivel',
    _$quantidadeDisponivel,
    key: r'quantidade_disponivel',
  );

  @override
  final MappableFields<Estoque> fields = const {
    #cor: _f$cor,
    #tamanho: _f$tamanho,
    #quantidadeDisponivel: _f$quantidadeDisponivel,
  };

  static Estoque _instantiate(DecodingData data) {
    return Estoque(
      cor: data.dec(_f$cor),
      tamanho: data.dec(_f$tamanho),
      quantidadeDisponivel: data.dec(_f$quantidadeDisponivel),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Estoque fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Estoque>(map);
  }

  static Estoque fromJson(String json) {
    return ensureInitialized().decodeJson<Estoque>(json);
  }
}

mixin EstoqueMappable {
  String toJson() {
    return EstoqueMapper.ensureInitialized().encodeJson<Estoque>(
      this as Estoque,
    );
  }

  Map<String, dynamic> toMap() {
    return EstoqueMapper.ensureInitialized().encodeMap<Estoque>(
      this as Estoque,
    );
  }

  EstoqueCopyWith<Estoque, Estoque, Estoque> get copyWith =>
      _EstoqueCopyWithImpl<Estoque, Estoque>(
        this as Estoque,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EstoqueMapper.ensureInitialized().stringifyValue(this as Estoque);
  }

  @override
  bool operator ==(Object other) {
    return EstoqueMapper.ensureInitialized().equalsValue(
      this as Estoque,
      other,
    );
  }

  @override
  int get hashCode {
    return EstoqueMapper.ensureInitialized().hashValue(this as Estoque);
  }
}

extension EstoqueValueCopy<$R, $Out> on ObjectCopyWith<$R, Estoque, $Out> {
  EstoqueCopyWith<$R, Estoque, $Out> get $asEstoque =>
      $base.as((v, t, t2) => _EstoqueCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EstoqueCopyWith<$R, $In extends Estoque, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({CorKimono? cor, TamanhoKimono? tamanho, int? quantidadeDisponivel});
  EstoqueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EstoqueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Estoque, $Out>
    implements EstoqueCopyWith<$R, Estoque, $Out> {
  _EstoqueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Estoque> $mapper =
      EstoqueMapper.ensureInitialized();
  @override
  $R call({
    CorKimono? cor,
    TamanhoKimono? tamanho,
    int? quantidadeDisponivel,
  }) => $apply(
    FieldCopyWithData({
      if (cor != null) #cor: cor,
      if (tamanho != null) #tamanho: tamanho,
      if (quantidadeDisponivel != null)
        #quantidadeDisponivel: quantidadeDisponivel,
    }),
  );
  @override
  Estoque $make(CopyWithData data) => Estoque(
    cor: data.get(#cor, or: $value.cor),
    tamanho: data.get(#tamanho, or: $value.tamanho),
    quantidadeDisponivel: data.get(
      #quantidadeDisponivel,
      or: $value.quantidadeDisponivel,
    ),
  );

  @override
  EstoqueCopyWith<$R2, Estoque, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EstoqueCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

