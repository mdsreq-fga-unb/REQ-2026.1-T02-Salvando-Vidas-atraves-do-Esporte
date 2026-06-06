import 'package:dart_mappable/dart_mappable.dart';
import '../helpers.dart';

part 'presenca.mapper.dart';

@MappableClass()
class Presenca with PresencaMappable {
  final BigInt? id;
  final BigInt alunoId;

  @MappableClass(hook: HookData())
  final DateTime data;

  Presenca({this.id, required this.alunoId, required this.data});
}
