// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presenca.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Presenca _$PresencaFromJson(Map<String, dynamic> json) => Presenca(
  id: BigInt.parse(json['id'] as String),
  alunoId: BigInt.parse(json['aluno_id'] as String),
  data: const DateConverter().fromJson(json['data'] as String),
  turmaId: json['turma_id'] == null
      ? null
      : BigInt.parse(json['turma_id'] as String),
  userId: json['user_id'] as String?,
);

Map<String, dynamic> _$PresencaToJson(Presenca instance) => <String, dynamic>{
  'id': instance.id.toString(),
  'aluno_id': instance.alunoId.toString(),
  'turma_id': instance.turmaId?.toString(),
  'user_id': instance.userId,
  'data': const DateConverter().toJson(instance.data),
};
