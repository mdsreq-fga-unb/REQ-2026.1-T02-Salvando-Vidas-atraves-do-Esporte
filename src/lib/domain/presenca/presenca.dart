import 'package:json_annotation/json_annotation.dart';
import 'package:salvando_vidas/domain/converters.dart';

part 'presenca.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class Presenca {
  final BigInt? id;
  final BigInt alunoId;
  final BigInt? turmaId;
  final String? userId;

  @DateConverter()
  final DateTime data;

  Presenca({
    required this.alunoId,
    required this.data,
    this.id,
    this.turmaId,
    this.userId,
  });

  factory Presenca.fromJson(Map<String, dynamic> json) =>
      _$PresencaFromJson(json);
  Map<String, dynamic> toJson() => _$PresencaToJson(this);
}
