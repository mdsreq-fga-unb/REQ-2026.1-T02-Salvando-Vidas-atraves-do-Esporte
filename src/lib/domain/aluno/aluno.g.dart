// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aluno _$AlunoFromJson(Map<String, dynamic> json) => Aluno(
  nome: json['nome'] as String,
  cpf: json['cpf'] as String,
  nascimento: const DateConverter().fromJson(json['nascimento'] as String),
  email: json['email'] as String,
  faixa: $enumDecode(_$FaixaEnumMap, json['faixa']),
  grau: (json['grau'] as num).toInt(),
  dataEntrada: const DateConverter().fromJson(json['data_entrada'] as String),
  ativo: json['ativo'] as bool,
  federado: json['federado'] as bool,
  id: json['id'] == null ? null : BigInt.parse(json['id'] as String),
  contato: json['contato'] as String?,
  contatoEmergencia: json['contato_emergencia'] as String?,
  linkFoto: json['link_foto'] as String?,
  idResponsavel: json['id_responsavel'] == null
      ? null
      : BigInt.parse(json['id_responsavel'] as String),
  idTurma: json['id_turma'] == null
      ? null
      : BigInt.parse(json['id_turma'] as String),
);

Map<String, dynamic> _$AlunoToJson(Aluno instance) => <String, dynamic>{
  'id': ?instance.id?.toString(),
  'nome': instance.nome,
  'cpf': instance.cpf,
  'contato': ?instance.contato,
  'contato_emergencia': ?instance.contatoEmergencia,
  'email': instance.email,
  'faixa': _$FaixaEnumMap[instance.faixa]!,
  'grau': instance.grau,
  'link_foto': ?instance.linkFoto,
  'id_responsavel': ?instance.idResponsavel?.toString(),
  'id_turma': ?instance.idTurma?.toString(),
  'ativo': instance.ativo,
  'federado': instance.federado,
  'data_entrada': const DateConverter().toJson(instance.dataEntrada),
  'nascimento': const DateConverter().toJson(instance.nascimento),
};

const _$FaixaEnumMap = {
  Faixa.branca: 'branca',
  Faixa.cinza: 'cinza',
  Faixa.amarela: 'amarela',
  Faixa.laranja: 'laranja',
  Faixa.verde: 'verde',
  Faixa.azul: 'azul',
  Faixa.roxa: 'roxa',
  Faixa.marrom: 'marrom',
  Faixa.preta: 'preta',
};
