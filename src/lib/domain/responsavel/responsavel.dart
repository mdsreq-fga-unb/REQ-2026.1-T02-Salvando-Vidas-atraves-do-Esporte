import 'package:json_annotation/json_annotation.dart';

part 'responsavel.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Responsavel {
  final BigInt id;
  final String nome;
  final String cpf;
  final String contato;
  final String email;

  Responsavel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.contato,
    required this.email,
  });

  factory Responsavel.fromJson(Map<String, dynamic> json) =>
      _$ResponsavelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsavelToJson(this);
}
