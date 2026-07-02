import 'package:dart_mappable/dart_mappable.dart';

import '../helpers.dart';

part 'turma.mapper.dart';

@MappableEnum()
enum FaixaEtaria { infantil, adulto }

@MappableClass()
class Turma with TurmaMappable {
  final int id;
  final String nome;
  final String descricao;
  final FaixaEtaria faixaEtaria;

  @MappableField(hook: HookHorario())
  final DateTime horarioInicio;

  @MappableField(hook: HookHorario())
  final DateTime horarioFim;

  final bool ativo;
  final bool eSegunda;
  final bool eTerca;
  final bool eQuarta;
  final bool eQuinta;
  final bool eSexta;
  final bool eSabado;
  final bool eDomingo;
  int? qtdAlunos;

  Turma({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.faixaEtaria,
    required this.horarioInicio,
    required this.horarioFim,
    required this.ativo,
    required this.eSegunda,
    required this.eTerca,
    required this.eQuarta,
    required this.eQuinta,
    required this.eSexta,
    required this.eSabado,
    required this.eDomingo,
    this.qtdAlunos,
  });

  String get horarioFormatado {
    final dias = <String>[];
    if (eSegunda) dias.add('Segunda');
    if (eTerca) dias.add('Terça');
    if (eQuarta) dias.add('Quarta');
    if (eQuinta) dias.add('Quinta');
    if (eSexta) dias.add('Sexta');
    if (eSabado) dias.add('Sábado');
    if (eDomingo) dias.add('Domingo');

    String diasFormatados = '';
    if (dias.isEmpty) {
      diasFormatados = 'Sem dias definidos';
    } else if (dias.length == 1) {
      diasFormatados = dias.first;
    } else {
      final ultimoDia = dias.removeLast();
      diasFormatados = '${dias.join(', ')} e $ultimoDia';
    }

    final hrInicio =
        '${horarioInicio.hour.toString().padLeft(2, '0')}:${horarioInicio.minute.toString().padLeft(2, '0')}';
    final hrFim =
        '${horarioFim.hour.toString().padLeft(2, '0')}:${horarioFim.minute.toString().padLeft(2, '0')}';

    if (dias.isEmpty && diasFormatados == 'Sem dias definidos') {
      return '$hrInicio-$hrFim';
    }

    return '$diasFormatados. $hrInicio-$hrFim';
  }

  static final fromMap = TurmaMapper.fromMap;
  static final fromJson = TurmaMapper.fromJson;
}
