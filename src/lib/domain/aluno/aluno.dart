import 'package:dart_mappable/dart_mappable.dart';

import '../helpers.dart';

part 'aluno.mapper.dart';

enum Faixa { branca, cinza, amarela, laranja, verde, azul, roxa, marrom, preta }

@MappableClass()
class Aluno with AlunoMappable {
  final BigInt? id;
  final String nome;
  final String cpf;
  final String? contato;
  final String? contatoEmergencia;
  final String email;
  final Faixa faixa;
  final int grau;
  final String? linkFoto;
  final BigInt? idResponsavel;
  final BigInt? idTurma;
  final bool ativo;
  final bool federado;

  @MappableClass(hook: HookData())
  final DateTime dataEntrada;

  @MappableClass(hook: HookData())
  final DateTime nascimento;

  Aluno({
    required this.nome,
    required this.cpf,
    required this.nascimento,
    required this.email,
    required this.faixa,
    required this.grau,
    required this.dataEntrada,
    required this.ativo,
    required this.federado,
    this.id,
    this.contato,
    this.contatoEmergencia,
    this.linkFoto,
    this.idResponsavel,
    this.idTurma,
  });

  static final fromMap = AlunoMapper.fromMap;
  static final fromJson = AlunoMapper.fromJson;
}
