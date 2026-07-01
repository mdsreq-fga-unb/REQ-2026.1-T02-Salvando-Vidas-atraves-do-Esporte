import 'package:dart_mappable/dart_mappable.dart';

import '../helpers.dart';

part 'kimono.mapper.dart';

@MappableEnum()
enum CorKimono { azul, branco, preto, rosa }

extension CorKimonoExt on CorKimono {
  String get nomeVisivel => switch (this) {
    CorKimono.azul => "Azul",
    CorKimono.branco => "Branco",
    CorKimono.preto => "Preto",
    CorKimono.rosa => "Rosa",
  };
}

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum TamanhoKimono { a0, a1, a2, a3, a4, a5 }

extension TamanhoKimonoExt on TamanhoKimono {
  String get nomeVisivel => switch (this) {
    TamanhoKimono.a0 => "A0",
    TamanhoKimono.a1 => "A1",
    TamanhoKimono.a2 => "A2",
    TamanhoKimono.a3 => "A3",
    TamanhoKimono.a4 => "A4",
    TamanhoKimono.a5 => "A5",
  };
}

@MappableClass()
class Doacao with DoacaoMappable {
  final int? id;
  final String doador;
  final CorKimono cor;
  final TamanhoKimono tamanho;
  final int quantidade;

  @MappableClass(hook: HookData())
  final DateTime data;

  Doacao({
    this.id,
    required this.doador,
    required this.cor,
    required this.tamanho,
    required this.quantidade,
    required this.data,
  });

  static final fromMap = DoacaoMapper.fromMap;
  static final fromJson = DoacaoMapper.fromJson;
}

@MappableClass()
class Perda with PerdaMappable {
  final int? id;
  final CorKimono cor;
  final TamanhoKimono tamanho;
  final int quantidade;
  final String motivo;

  @MappableClass(hook: HookData())
  final DateTime data;

  Perda({
    this.id,
    required this.cor,
    required this.tamanho,
    required this.quantidade,
    required this.motivo,
    required this.data,
  });

  static final fromMap = PerdaMapper.fromMap;
  static final fromJson = PerdaMapper.fromJson;
}

@MappableClass()
class Emprestimo with EmprestimoMappable {
  final int? id;
  final int alunoId;
  final CorKimono cor;
  final TamanhoKimono tamanho;

  @MappableClass(hook: HookData())
  final DateTime data;

  @MappableClass(hook: HookData())
  final DateTime? dataDevolucao;

  Emprestimo({
    this.id,
    required this.alunoId,
    required this.cor,
    required this.tamanho,
    required this.data,
    this.dataDevolucao,
  });

  static final fromMap = EmprestimoMapper.fromMap;
  static final fromJson = EmprestimoMapper.fromJson;
}

@MappableClass()
class Estoque with EstoqueMappable {
  final CorKimono cor;
  final TamanhoKimono tamanho;
  final int quantidadeDisponivel;
  Estoque({
    required this.cor,
    required this.tamanho,
    required this.quantidadeDisponivel,
  });

  static final fromMap = EstoqueMapper.fromMap;
  static final fromJson = EstoqueMapper.fromJson;
}
