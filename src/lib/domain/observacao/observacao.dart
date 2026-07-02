import 'package:dart_mappable/dart_mappable.dart';
import '../helpers.dart';

part 'observacao.mapper.dart';

@MappableClass()
class Observacao with ObservacaoMappable {
  final int? id;
  final String voluntario;
  final String observacao;
  final int turmaId;

  @MappableField(hook: HookData())
  final DateTime data;

  Observacao({
    this.id,
    required this.voluntario,
    required this.observacao,
    required this.turmaId,
    required this.data,
  });

  static final fromMap = ObservacaoMapper.fromMap;
  static final fromJson = ObservacaoMapper.fromJson;
}
