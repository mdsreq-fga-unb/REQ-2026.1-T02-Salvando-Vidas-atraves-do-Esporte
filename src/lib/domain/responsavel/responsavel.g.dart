// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responsavel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Responsavel _$ResponsavelFromJson(Map<String, dynamic> json) => Responsavel(
  nome: json['nome'] as String,
  cpf: json['cpf'] as String,
  contato: json['contato'] as String,
  email: json['email'] as String,
  id: json['id'] == null ? null : BigInt.parse(json['id'] as String),
);

Map<String, dynamic> _$ResponsavelToJson(Responsavel instance) =>
    <String, dynamic>{
      'id': ?instance.id?.toString(),
      'nome': instance.nome,
      'cpf': instance.cpf,
      'contato': instance.contato,
      'email': instance.email,
    };
