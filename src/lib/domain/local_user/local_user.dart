import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

enum Role { voluntario, admin }

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class LocalUser {
  final String? id;
  final Role role;
  final String nome;
  final String telefone;
  final String cpf;

  const LocalUser({
    required this.role,
    required this.nome,
    required this.telefone,
    required this.cpf,
    this.id,
  });

  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);
  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
