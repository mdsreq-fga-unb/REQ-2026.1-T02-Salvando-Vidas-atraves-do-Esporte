import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import '../../mocks/supabase_client.mocks.dart';
import '../../mocks/supabase_fakes.dart';

void main() {
  late PresencaService presencaService;
  late MockSupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    presencaService = PresencaService(mockSupabaseClient);
  });

  final presencaJson = {
    'id': 1,
    'aluno_id': 10,
    'turma_id': 20,
    'data': '2026-01-01',
  };

  final obsJson = {
    'id': 1,
    'voluntario': 'Voluntário Teste',
    'observacao': 'Aula produtiva',
    'turma_id': 20,
    'data': '2026-01-01',
  };

  final ultimaPresencaJson = {
    'aluno_id': 10,
    'aluno_nome': 'Gabriel',
    'data_ultima_presenca': '2026-01-01',
    'dias_desde_ultima_presenca': 3,
  };

  group('PresencaService Tests', () {
    test('listarPresencas', () async {
      when(mockSupabaseClient.from('presencas'))
          .thenAnswer((_) => FakeQueryBuilder([presencaJson]));

      final list = await presencaService.listarPresencas(20, DateTime(2026, 1, 1));
      expect(list.length, 1);
      expect(list.first.alunoId, 10);
    });

    test('obterObservacao - com resultado e vazio', () async {
      when(mockSupabaseClient.from('observacoes'))
          .thenAnswer((_) => FakeQueryBuilder([obsJson]));

      final obs = await presencaService.obterObservacao(20, DateTime(2026, 1, 1));
      expect(obs?.voluntario, 'Voluntário Teste');

      // Teste vazio
      when(mockSupabaseClient.from('observacoes'))
          .thenAnswer((_) => FakeQueryBuilder([]));
      final obsVazio = await presencaService.obterObservacao(20, DateTime(2026, 1, 1));
      expect(obsVazio, isNull);
    });

    test('cadastrarPresenca', () async {
      when(mockSupabaseClient.rpc(any, params: anyNamed('params')))
          .thenAnswer((_) => FakeFilterBuilder<dynamic>([]));

      await presencaService.cadastrarPresenca(
        20,
        DateTime(2026, 1, 1),
        'Voluntário Teste',
        'Ótimo',
        [10, 11],
      );
    });

    test('obterUltimasPresencas', () async {
      when(mockSupabaseClient.from('dashboard_ultimas_presencas'))
          .thenAnswer((_) => FakeQueryBuilder([ultimaPresencaJson]));

      final list = await presencaService.obterUltimasPresencas();
      expect(list.length, 1);
      expect(list.first.alunoNome, 'Gabriel');
    });

    test('listarPresencasPorAluno', () async {
      when(mockSupabaseClient.from('presencas'))
          .thenAnswer((_) => FakeQueryBuilder([presencaJson]));

      final list = await presencaService.listarPresencasPorAluno(10);
      expect(list.length, 1);
      expect(list.first.alunoId, 10);
    });

    test('listarObservacoesPorTurma', () async {
      when(mockSupabaseClient.from('observacoes'))
          .thenAnswer((_) => FakeQueryBuilder([obsJson]));

      final list = await presencaService.listarObservacoesPorTurma(20);
      expect(list.length, 1);
      expect(list.first.voluntario, 'Voluntário Teste');
    });

    test('listarTodasPresencasPorTurma', () async {
      when(mockSupabaseClient.from('presencas'))
          .thenAnswer((_) => FakeQueryBuilder([presencaJson]));

      final list = await presencaService.listarTodasPresencasPorTurma(20);
      expect(list.length, 1);
      expect(list.first.turmaId, 20);
    });
  });
}


