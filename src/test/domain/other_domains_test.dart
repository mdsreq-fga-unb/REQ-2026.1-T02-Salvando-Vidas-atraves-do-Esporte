import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/domain/helpers.dart';
import 'package:salvando_vidas/domain/observacao/observacao.dart';
import 'package:salvando_vidas/domain/presenca/presenca.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';

void main() {
  group('Helpers Tests', () {
    test('obterDiff', () {
      final orig = {'a': 1, 'b': 2};
      final atual = {'a': 1, 'b': 3, 'c': 4};
      final diff = obterDiff(orig, atual);
      expect(diff, {'b': 3, 'c': 4});
    });

    test('HookData beforeDecode and beforeEncode', () {
      const hook = HookData();
      expect(hook.beforeDecode('2026-05-20'), DateTime(2026, 5, 20));
      expect(hook.beforeDecode(123), isNull);

      final encoded = hook.beforeEncode(DateTime(2026, 5, 20));
      expect(encoded, '2026-05-20');
      expect(hook.beforeEncode('not a date'), isNull);
    });

    test('HookHorario beforeDecode and beforeEncode', () {
      const hook = HookHorario();
      final dt = hook.beforeDecode('14:30') as DateTime?;
      expect(dt?.hour, 14);
      expect(dt?.minute, 30);
      expect(hook.beforeDecode(123), isNull);

      final encoded = hook.beforeEncode(DateTime(1970, 1, 1, 8, 5));
      expect(encoded, '08:05');
      expect(hook.beforeEncode('not a date'), isNull);
    });
  });

  group('Observacao Domain Tests', () {
    test('serialization and properties', () {
      final now = DateTime(2026, 1, 1);
      final obs = Observacao(
        id: 1,
        voluntario: 'Carlos',
        observacao: 'Ótimo aluno',
        turmaId: 101,
        data: now,
      );

      final map = obs.toMap();
      final fromMap = Observacao.fromMap(map);
      expect(fromMap.voluntario, 'Carlos');
      expect(fromMap.observacao, 'Ótimo aluno');

      final json = obs.toJson();
      final fromJson = Observacao.fromJson(json);
      expect(fromJson.turmaId, 101);
    });
  });

  group('Presenca Domain Tests', () {
    test('Presenca serialization', () {
      final now = DateTime(2026, 1, 1);
      final presenca = Presenca(
        id: 1,
        alunoId: 10,
        turmaId: 20,
        data: now,
      );

      final map = presenca.toMap();
      final fromMap = Presenca.fromMap(map);
      expect(fromMap.alunoId, 10);

      final json = presenca.toJson();
      final fromJson = Presenca.fromJson(json);
      expect(fromJson.turmaId, 20);
    });

    test('UltimaPresenca serialization', () {
      final now = DateTime(2026, 1, 1);
      final ultima = UltimaPresenca(
        alunoId: 10,
        alunoNome: 'Ana',
        dataUltimaPresenca: now,
        diasDesdeUltimaPresenca: 2,
      );

      final map = ultima.toMap();
      final fromMap = UltimaPresenca.fromMap(map);
      expect(fromMap.alunoNome, 'Ana');

      final json = ultima.toJson();
      final fromJson = UltimaPresenca.fromJson(json);
      expect(fromJson.diasDesdeUltimaPresenca, 2);
    });
  });

  group('Turma Domain Tests', () {
    test('Turma serialization and horarioFormatado variations', () {
      final t1 = Turma(
        id: 1,
        nome: 'Jiu Jitsu Infantil',
        descricao: 'Iniciantes',
        faixaEtaria: FaixaEtaria.infantil,
        horarioInicio: DateTime(1970, 1, 1, 10, 0),
        horarioFim: DateTime(1970, 1, 1, 11, 30),
        ativo: true,
        eSegunda: true,
        eTerca: false,
        eQuarta: true,
        eQuinta: false,
        eSexta: true,
        eSabado: false,
        eDomingo: false,
        qtdAlunos: 15,
      );

      expect(t1.horarioFormatado, 'Segunda, Quarta e Sexta. 10:00-11:30');

      final map = t1.toMap();
      final fromMap = Turma.fromMap(map);
      expect(fromMap.nome, 'Jiu Jitsu Infantil');

      final json = t1.toJson();
      final fromJson = Turma.fromJson(json);
      expect(fromJson.faixaEtaria, FaixaEtaria.infantil);

      // Test with 1 day
      final t2 = Turma(
        id: 2,
        nome: 'Adulto',
        descricao: 'Avançado',
        faixaEtaria: FaixaEtaria.adulto,
        horarioInicio: DateTime(1970, 1, 1, 19, 0),
        horarioFim: DateTime(1970, 1, 1, 20, 30),
        ativo: true,
        eSegunda: false,
        eTerca: false,
        eQuarta: false,
        eQuinta: false,
        eSexta: false,
        eSabado: true,
        eDomingo: false,
      );
      expect(t2.horarioFormatado, 'Sábado. 19:00-20:30');

      // Test with 0 days
      final t3 = Turma(
        id: 3,
        nome: 'Domingo Extra',
        descricao: 'Extra',
        faixaEtaria: FaixaEtaria.adulto,
        horarioInicio: DateTime(1970, 1, 1, 8, 0),
        horarioFim: DateTime(1970, 1, 1, 9, 0),
        ativo: false,
        eSegunda: false,
        eTerca: false,
        eQuarta: false,
        eQuinta: false,
        eSexta: false,
        eSabado: false,
        eDomingo: false,
      );
      expect(t3.horarioFormatado, '08:00-09:00');
    });
  });
}
