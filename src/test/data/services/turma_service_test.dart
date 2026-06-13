import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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

  // JSON da nossa Turma Perfeita (usando snake_case para simular o banco)
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
      // 1. ARRANGE
      // Simulamos que a tabela de alunos devolveu 3 registros para a turma id = 1
      final alunosSimulados = [
        {'id': 101, 'id_turma': 1},
        {'id': 102, 'id_turma': 1},
        {'id': 103, 'id_turma': 1},
      ];

      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder(alunosSimulados));

      // 2. ACT
      final quantidade = await turmaService.contarAlunos(1);

      // 3. ASSERT
      // O FakeCountBuilder vai ler o .length da lista e devolver 3!
      expect(quantidade, 3);
    });

    test('deve listar as turmas e atribuir a quantidade de alunos com sucesso', () async {
      // 1. ARRANGE (O Desafio das Duas Tabelas)
      
      // Ensinamos o mock a responder a chamada da tabela 'turmas'
      when(mockSupabaseClient.from('turmas'))
          .thenAnswer((_) => FakeQueryBuilder([turmaSimuladoJson]));

      // Em seguida, ensinamos o mock a responder a chamada da tabela 'alunos'
      // Simulando que essa turma tem 2 alunos cadastrados
      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([
                {'id': 101, 'id_turma': 1},
                {'id': 102, 'id_turma': 1},
              ]));

      // 2. ACT
      final resultado = await turmaService.listarTurmas();

      // 3. ASSERT
      expect(resultado, isA<List<Turma>>());
      expect(resultado.length, 1);
      expect(resultado.first.nome, 'Turma de Jiu-Jitsu');
      
      // A Prova Final: Verifica se o loop "for" preencheu o campo de quantidade corretamente
      expect(resultado.first.qtdAlunos, 2);
    });

  });
}