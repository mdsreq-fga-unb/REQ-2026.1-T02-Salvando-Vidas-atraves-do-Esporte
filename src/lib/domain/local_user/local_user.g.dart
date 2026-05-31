// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
  id: json['id'] as String,
  role: $enumDecode(_$RoleEnumMap, json['role']),
  nome: json['nome'] as String,
  telefone: json['telefone'] as String,
  cpf: json['cpf'] as String,
);

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
  'id': instance.id,
  'role': _$RoleEnumMap[instance.role]!,
  'nome': instance.nome,
  'telefone': instance.telefone,
  'cpf': instance.cpf,
};

const _$RoleEnumMap = {Role.voluntario: 'voluntario', Role.admin: 'admin'};
