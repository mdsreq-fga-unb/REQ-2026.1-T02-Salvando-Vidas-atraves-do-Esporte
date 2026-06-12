import 'package:dart_mappable/dart_mappable.dart';

part 'responsavel.mapper.dart';

@MappableClass()
class Responsavel with ResponsavelMappable {
  final int? id;
  final String nome;
  final String cpf;
  final String contato;
  final String email;
  final bool ativo;

  Responsavel({
    required this.nome,
    required this.cpf,
    required this.contato,
    required this.email,
    required this.ativo,
    this.id,
  });

  static final fromMap = ResponsavelMapper.fromMap;
  static final fromJson = ResponsavelMapper.fromJson;
}
