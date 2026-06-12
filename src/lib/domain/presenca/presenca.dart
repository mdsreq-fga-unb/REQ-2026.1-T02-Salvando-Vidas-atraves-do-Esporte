import 'package:dart_mappable/dart_mappable.dart';
import '../helpers.dart';

part 'presenca.mapper.dart';

@MappableClass()
class Presenca with PresencaMappable {
  final int? id;
  final int alunoId;

  @MappableField(hook: HookData())
  final DateTime data;

  Presenca({this.id, required this.alunoId, required this.data});
}
