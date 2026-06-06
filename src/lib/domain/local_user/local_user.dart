import 'package:dart_mappable/dart_mappable.dart';

part 'local_user.mapper.dart';

@MappableEnum()
enum Role { voluntario, admin }

@MappableClass()
class LocalUser with LocalUserMappable {
  final String? id;
  final Role role;
  final String nome;
  final String telefone;
  final String cpf;
  final String email;
  final String? senha;

  const LocalUser({
    this.id,
    required this.role,
    required this.nome,
    required this.telefone,
    required this.cpf,
    required this.email,
    this.senha,
  });

  static final fromMap = LocalUserMapper.fromMap;
  static final fromJson = LocalUserMapper.fromJson;
}
