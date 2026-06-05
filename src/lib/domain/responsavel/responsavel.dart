import 'package:json_annotation/json_annotation.dart';

part 'responsavel.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class Responsavel {
  final BigInt? id;
  final String nome;
  final String cpf;
  final String contato;
  final String email;

  Responsavel({
    required this.nome,
    required this.cpf,
    required this.contato,
    required this.email,
    this.id,
  });

  factory Responsavel.fromJson(Map<String, dynamic> json) =>
      _$ResponsavelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsavelToJson(this);
}
