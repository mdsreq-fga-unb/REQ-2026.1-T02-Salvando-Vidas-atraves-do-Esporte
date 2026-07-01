import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import '../../mocks/supabase_client.mocks.dart';
import '../../mocks/supabase_fakes.dart';

void main() {
  late KimonoService kimonoService;
  late MockSupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    kimonoService = KimonoService(mockSupabaseClient);
  });

  final doacaoJson = {
    'id': 1,
    'doador': 'João',
    'cor': 'azul',
    'tamanho': 'A1',
    'quantidade': 2,
    'data': '2026-01-01',
  };

  final perdaJson = {
    'id': 1,
    'cor': 'branco',
    'tamanho': 'A2',
    'quantidade': 1,
    'motivo': 'Rasgado',
    'data': '2026-01-01',
  };

  final emprestimoJson = {
    'id': 1,
    'aluno_id': 10,
    'cor': 'preto',
    'tamanho': 'A3',
    'data': '2026-01-01',
    'data_devolucao': null,
  };

  final estoqueJson = {
    'cor': 'rosa',
    'tamanho': 'A0',
    'quantidade_disponivel': 5,
  };

  group('KimonoService Tests', () {
    test('cadastrarDoacao e listarDoacoes', () async {
      when(mockSupabaseClient.from('doacoes'))
          .thenAnswer((_) => FakeQueryBuilder([doacaoJson]));

      final doacao = Doacao(
        doador: 'João',
        cor: CorKimono.azul,
        tamanho: TamanhoKimono.a1,
        quantidade: 2,
        data: DateTime(2026, 1, 1),
      );

      final resCad = await kimonoService.cadastrarDoacao(doacao);
      expect(resCad.id, 1);
      expect(resCad.doador, 'João');

      final list = await kimonoService.listarDoacoes();
      expect(list.length, 1);
      expect(list.first.cor, CorKimono.azul);
    });

    test('cadastrarPerda e listarPerdas', () async {
      when(mockSupabaseClient.from('perdas'))
          .thenAnswer((_) => FakeQueryBuilder([perdaJson]));

      final perda = Perda(
        cor: CorKimono.branco,
        tamanho: TamanhoKimono.a2,
        quantidade: 1,
        motivo: 'Rasgado',
        data: DateTime(2026, 1, 1),
      );

      final resCad = await kimonoService.cadastrarPerda(perda);
      expect(resCad.id, 1);
      expect(resCad.motivo, 'Rasgado');

      final list = await kimonoService.listarPerdas();
      expect(list.length, 1);
      expect(list.first.tamanho, TamanhoKimono.a2);
    });

    test('cadastrarEmprestimo, listarEmprestimos e retornarEmprestimo', () async {
      when(mockSupabaseClient.from('emprestimos'))
          .thenAnswer((_) => FakeQueryBuilder([emprestimoJson]));

      final emp = Emprestimo(
        id: 1,
        alunoId: 10,
        cor: CorKimono.preto,
        tamanho: TamanhoKimono.a3,
        data: DateTime(2026, 1, 1),
      );

      final resCad = await kimonoService.cadastrarEmprestimo(emp);
      expect(resCad.id, 1);
      expect(resCad.alunoId, 10);

      final list = await kimonoService.listarEmprestimos();
      expect(list.length, 1);

      await kimonoService.retornarEmprestimo(emp);
    });

    test('obterEstoque', () async {
      when(mockSupabaseClient.from('estoque_kimonos'))
          .thenAnswer((_) => FakeQueryBuilder([estoqueJson]));

      final list = await kimonoService.obterEstoque();
      expect(list.length, 1);
      expect(list.first.quantidadeDisponivel, 5);
    });
  });
}
