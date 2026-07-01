import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';

import '../../mocks/supabase_client.mocks.dart';
import '../../mocks/supabase_fakes.dart';

void main() {
  late AlunoService alunoService;
  late MockSupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    alunoService = AlunoService(mockSupabaseClient);
  });

  final Map<String, Object> alunoSimuladoJson = <String, Object>{
    'id': 1,
    'nome': 'Lucas Oliveira',
    'cpf': '12345678900', // Sem pontos e traços
    'email': 'lucas@email.com',
    'faixa': 'branca', // O dart_mappable lê o nome da enum
    'grau': 1,
    'tipo_sanguineo': 'a_positivo', // caseStyle: CaseStyle.snakeCase
    'nascimento': '2000-01-01', // Apenas YYYY-MM-DD
    'data_entrada': '2026-06-13', // Apenas YYYY-MM-DD
    'ativo': true,
    'federado': false,
    'id_turma': 2,
    
    // --- CAMPOS MÉDICOS ADICIONADOS ---
    
    'p_medica1': false,
    'p_medica2': false,
    'p_medica3': false,
    'p_medica4': false,
    'p_medica5': false,
    'observacao_medica': 'Apto para o esporte, sem restrições.',
  };

  final responsavelSimuladoJson = {
  'id': 1,
  'nome': 'João Responsável',
  'cpf': '00011122233', // Sem pontos e traços
  'contato': '61999999999', // Sem parênteses, espaço ou traço
  'email': 'joao@email.com',
  'ativo': true,
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

    test('deve cadastrar um aluno com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([alunoSimuladoJson]));

      final alunoParaCadastrar = Aluno.fromMap(alunoSimuladoJson);

      // 2. ACT
      final resultado = await alunoService.cadastrarAluno(alunoParaCadastrar);

      // 3. ASSERT
      expect(resultado, isA<Aluno>());
      expect(resultado.nome, 'Lucas Oliveira');
    });

    test('deve atualizar um aluno com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([]));

      final dadosParaAtualizar = {'nome': 'Lucas Oliveira Editado'};

      // 2. ACT & ASSERT
      expect(
        () async => await alunoService.atualizaAluno(1, dadosParaAtualizar),
        returnsNormally,
      );
    });

    test('deve deletar um aluno com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('alunos'))
          .thenAnswer((_) => FakeQueryBuilder([]));

      // 2. ACT & ASSERT
      expect(
        () async => await alunoService.deletaAluno(1),
        returnsNormally,
      );
    });

    // --- TESTES DA ENTIDADE RESPONSÁVEL ---

    test('deve listar todos os responsaveis com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('responsaveis'))
          .thenAnswer((_) => FakeQueryBuilder([responsavelSimuladoJson]));

      // 2. ACT
      final resultado = await alunoService.listarResponsaveis();

      // 3. ASSERT
      expect(resultado, isA<List<Responsavel>>());
      expect(resultado.length, 1);
      expect(resultado.first.nome, 'João Responsável');
    });

    test('deve cadastrar um responsavel com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('responsaveis'))
          .thenAnswer((_) => FakeQueryBuilder([responsavelSimuladoJson]));

      final responsavelParaCadastrar = Responsavel.fromMap(responsavelSimuladoJson);

      // 2. ACT
      final resultado = await alunoService.cadastrarResponsavel(responsavelParaCadastrar);

      // 3. ASSERT
      expect(resultado, isA<Responsavel>());
      expect(resultado.nome, 'João Responsável');
    });

    test('deve atualizar um responsavel com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('responsaveis'))
          .thenAnswer((_) => FakeQueryBuilder([]));

      final dadosParaAtualizar = {'contato': '61988888888'}; // Sem pontuação também

      // 2. ACT & ASSERT
      expect(
        () async => await alunoService.atualizaResponsavel(1, dadosParaAtualizar),
        returnsNormally, // Valida se a função void executou sem crashes
      );
    });

    test('deve deletar um responsavel com sucesso', () async {
      // 1. ARRANGE
      when(mockSupabaseClient.from('responsaveis'))
          .thenAnswer((_) => FakeQueryBuilder([]));

      // 2. ACT & ASSERT
      expect(
        () async => await alunoService.deletaResponsavel(1),
        returnsNormally,
      );
    });

  });
}
