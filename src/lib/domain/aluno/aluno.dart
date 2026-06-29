import 'package:dart_mappable/dart_mappable.dart';

import '../helpers.dart';

part 'aluno.mapper.dart';

@MappableEnum()
enum Faixa { branca, cinza, amarela, laranja, verde, azul, roxa, marrom, preta }

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum TipoSanguineo {
  aPositivo,
  aNegativo,
  bPositivo,
  bNegativo,
  abPositivo,
  abNegativo,
  oPositivo,
  oNegativo,
}

extension FaixaExt on Faixa {
  String get nomeVisivel {
    switch (this) {
      case Faixa.branca:
        return 'Branca';
      case Faixa.cinza:
        return 'Cinza';
      case Faixa.amarela:
        return 'Amarela';
      case Faixa.laranja:
        return 'Laranja';
      case Faixa.verde:
        return 'Verde';
      case Faixa.azul:
        return 'Azul';
      case Faixa.roxa:
        return 'Roxa';
      case Faixa.marrom:
        return 'Marrom';
      case Faixa.preta:
        return 'Preta';
    }
  }
}

extension TipoSanguineoExt on TipoSanguineo {
  String get nomeVisivel {
    switch (this) {
      case TipoSanguineo.aPositivo:
        return 'A+';
      case TipoSanguineo.aNegativo:
        return 'A-';
      case TipoSanguineo.bPositivo:
        return 'B+';
      case TipoSanguineo.bNegativo:
        return 'B-';
      case TipoSanguineo.abPositivo:
        return 'AB+';
      case TipoSanguineo.abNegativo:
        return 'AB-';
      case TipoSanguineo.oPositivo:
        return 'O+';
      case TipoSanguineo.oNegativo:
        return 'O-';
    }
  }
}

@MappableClass()
class Aluno with AlunoMappable {
  final int? id;
  final String nome;
  final String? apelido;
  final bool usarApelidoComoReferencia;
  final String cpf;
  final String? contato;
  final String? contatoEmergencia;
  final String email;
  final Faixa faixa;
  final int grau;
  final TipoSanguineo tipoSanguineo;
  final String? linkFoto;
  final int? idResponsavel;
  final int? idTurma;
  final bool ativo;
  final bool federado;
  final int? idFicha;

  @MappableClass(hook: HookData())
  final DateTime dataEntrada;

  @MappableClass(hook: HookData())
  final DateTime nascimento;

  String get nomeReferencia {
    if (usarApelidoComoReferencia && apelido != null && apelido!.trim().isNotEmpty) {
      return apelido!.trim();
    }
    return nome;
  }

  Aluno({
    required this.nome,
    required this.cpf,
    required this.nascimento,
    required this.email,
    required this.faixa,
    required this.grau,
    required this.tipoSanguineo,
    required this.dataEntrada,
    required this.ativo,
    required this.federado,
    this.apelido,
    this.usarApelidoComoReferencia = false,
    this.id,
    this.contato,
    this.contatoEmergencia,
    this.linkFoto,
    this.idResponsavel,
    this.idTurma,
    this.idFicha,
  });

  static final fromMap = AlunoMapper.fromMap;
  static final fromJson = AlunoMapper.fromJson;
}
