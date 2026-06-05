import 'package:json_annotation/json_annotation.dart';

import '../converters.dart';

part 'aluno.g.dart';

enum Faixa { branca, cinza, amarela, laranja, verde, azul, roxa, marrom, preta }

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class Aluno {
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

  @DateConverter()
  final DateTime dataEntrada;

  @DateConverter()
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

  factory Aluno.fromJson(Map<String, dynamic> json) => _$AlunoFromJson(json);
  Map<String, dynamic> toJson() => _$AlunoToJson(this);
}
