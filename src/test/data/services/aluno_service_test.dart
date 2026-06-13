import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

import '../../mocks/supabase_client.mocks.dart';
import '../../mocks/supabase_fakes.dart';

void main() {
  late AlunoService alunoService;
  late MockSupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    alunoService = AlunoService(mockSupabaseClient);
  });

  final alunoSimuladoJson = {
    'id': 1,
    'nome': 'Lucas Oliveira',
    'cpf': '123.456.789-00',
    'email': 'lucas@email.com',
    'faixa': 'branca', // O dart_mappable lê o nome da enum
    'grau': 1,
    'tipo_sanguineo': 'a_positivo', // caseStyle: CaseStyle.snakeCase
    'nascimento': '2000-01-01T00:00:00.000', // Formato de data comum para o banco
    'data_entrada': '2026-06-13T00:00:00.000',
    'ativo': true,
    'federado': false,
    'id_turma': 2,
    
  };

  group('AlunoService -', () {
    
    test('deve listar todos os alunos com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([alunoSimuladoJson]));

      // 2. ACT
      final resultado = await alunoService.listarAlunos();

      // 3. ASSERT
      expect(resultado, isA<List<Aluno>>());
      expect(resultado.length, 1);
      expect(resultado.first.nome, 'Lucas Oliveira');
    });

    test('deve listar alunos de uma turma específica com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([alunoSimuladoJson]));

      // 2. ACT
      final resultado = await alunoService.listarAlunosTurma(2);

      // 3. ASSERT
      expect(resultado, isA<List<Aluno>>());
      expect(resultado.length, 1);
    });

  });
}
