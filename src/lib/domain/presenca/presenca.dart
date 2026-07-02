import 'package:dart_mappable/dart_mappable.dart';
import '../helpers.dart';

part 'presenca.mapper.dart';

@MappableClass()
class Presenca with PresencaMappable {
  final int? id;
  final int alunoId;
  final int turmaId;

  @MappableField(hook: HookData())
  final DateTime data;

  Presenca({
    this.id,
    required this.alunoId,
    required this.turmaId,
    required this.data,
  });

  static final fromMap = PresencaMapper.fromMap;
  static final fromJson = PresencaMapper.fromJson;
}

@MappableClass()
class UltimaPresenca with UltimaPresencaMappable {
  final int alunoId;
  final String alunoNome;

  @MappableField(hook: HookData())
  final DateTime? dataUltimaPresenca;

  final int? diasDesdeUltimaPresenca;

  UltimaPresenca({
    required this.alunoId,
    required this.alunoNome,
    required this.dataUltimaPresenca,
    required this.diasDesdeUltimaPresenca,
  });

  static final fromMap = UltimaPresencaMapper.fromMap;
  static final fromJson = UltimaPresencaMapper.fromJson;
}
