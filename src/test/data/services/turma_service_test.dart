import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';

import '../../mocks/supabase_client.mocks.dart';
import '../../mocks/supabase_fakes.dart';

void main() {
  late TurmaService turmaService;
  late MockSupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    turmaService = TurmaService(mockSupabaseClient);
  });

  final turmaSimuladoJson = {
    'id': 1,
    'nome': 'Turma de Jiu-Jitsu',
    'descricao': 'Treino focado em fundamentos',
    'faixa_etaria': 'infantil',
    'horario_inicio': '08:00:00',
    'horario_fim': '09:30:00',
    'ativo': true,
    'e_segunda': true,
    'e_terca': false,
    'e_quarta': true,
    'e_quinta': false,
    'e_sexta': true,
    'e_sabado': false,
    'e_domingo': false,
  };

  group('TurmaService -', () {
    test('deve contar a quantidade de alunos de uma turma com sucesso', () async {
      final alunosSimulados = [
        {'id': 101, 'id_turma': 1},
        {'id': 102, 'id_turma': 1},
        {'id': 103, 'id_turma': 1},
      ];

      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder(alunosSimulados));

      final quantidade = await turmaService.contarAlunos(1);
      expect(quantidade, 3);
    });

    test('deve listar as turmas e atribuir a quantidade de alunos com sucesso', () async {
      when(mockSupabaseClient.from('turmas'))
          .thenAnswer((_) => FakeQueryBuilder([turmaSimuladoJson]));

      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([
                {'id': 101, 'id_turma': 1},
                {'id': 102, 'id_turma': 1},
              ]));

      final resultado = await turmaService.listarTurmas();

      expect(resultado, isA<List<Turma>>());
      expect(resultado.length, 1);
      expect(resultado.first.nome, 'Turma de Jiu-Jitsu');
      expect(resultado.first.qtdAlunos, 2);
    });

    test('deve atualizar turma com sucesso', () async {
      when(mockSupabaseClient.from('turmas'))
          .thenAnswer((_) => FakeQueryBuilder([]));

      await turmaService.atualizaTurma(1, {'nome': 'Novo Nome'});
      verify(mockSupabaseClient.from('turmas')).called(1);
    });

    test('turmaServiceProvider build', () {
      final container = ProviderContainer(
        overrides: [
          supabaseClientProvider.overrideWithValue(mockSupabaseClient),
        ],
      );
      addTearDown(container.dispose);

      final service = container.read(turmaServiceProvider);
      expect(service, isNotNull);
    });
  });
}