import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:riverpod/riverpod.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/emprestimo/historico_emprestimos_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

import 'historico_emprestimos_store_test.mocks.dart';

@GenerateMocks([KimonoService, AlunoService, UserService])
void main() {
  group('HistoricoEmprestimosStore Tests', () {
    late MockKimonoService mockKimonoService;
    late MockAlunoService mockAlunoService;
    late MockUserService mockUserService;
    late ProviderContainer container;

    setUp(() {
      mockKimonoService = MockKimonoService();
      mockAlunoService = MockAlunoService();
      mockUserService = MockUserService();

      container = ProviderContainer(
        overrides: [
          kimonoServiceProvider.overrideWithValue(mockKimonoService),
          alunoServiceProvider.overrideWithValue(mockAlunoService),
          userServiceProvider.overrideWithValue(mockUserService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('build e updateFiltroTipo cobrindo empréstimos e devoluções', () async {
      final emp1 = Emprestimo(
        id: 1,
        alunoId: 10,
        data: DateTime(2026, 1, 1),
        tamanho: TamanhoKimono.a1,
        cor: CorKimono.azul,
      );
      final emp2 = Emprestimo(
        id: 2,
        alunoId: 20,
        data: DateTime(2026, 1, 5),
        dataDevolucao: DateTime(2026, 1, 10),
        tamanho: TamanhoKimono.a2,
        cor: CorKimono.branco,
      );

      final aluno1 = Aluno(
        id: 10,
        nome: 'Aluno 10',
        cpf: '52998224725',
        nascimento: DateTime(2010, 1, 1),
        email: 'a10@t.com',
        faixa: Faixa.branca,
        grau: 0,
        tipoSanguineo: TipoSanguineo.oPositivo,
        dataEntrada: DateTime(2025, 1, 1),
        ativo: true,
        federado: false,
        idTurma: 1,
      );

      final vol1 = LocalUser(id: '100', nome: 'Vol', email: 'vol@t.com', role: Role.voluntario, telefone: '11987654321', faixa: Faixa.branca);

      when(mockKimonoService.listarEmprestimos()).thenAnswer((_) async => [emp1, emp2]);
      when(mockAlunoService.listarAlunos()).thenAnswer((_) async => [aluno1]);
      when(mockUserService.listUsers()).thenAnswer((_) async => [vol1]);

      final state = await container.read(historicoEmprestimosStoreProvider.future);
      expect(state.itens.length, 2);
      expect(state.filtroTipo, 'todos');

      final notifier = container.read(historicoEmprestimosStoreProvider.notifier);

      // Filtro emprestimo (dataDevolucao == null)
      notifier.updateFiltroTipo('emprestimo');
      final sEmprestimo = container.read(historicoEmprestimosStoreProvider).value!;
      expect(sEmprestimo.filtroTipo, 'emprestimo');
      expect(sEmprestimo.itensFiltrados.length, 1);
      expect(sEmprestimo.itensFiltrados.first.emprestimo.id, 1);

      // Filtro devolucao (dataDevolucao != null)
      notifier.updateFiltroTipo('devolucao');
      final sDevolucao = container.read(historicoEmprestimosStoreProvider).value!;
      expect(sDevolucao.filtroTipo, 'devolucao');
      expect(sDevolucao.itensFiltrados.length, 1);
      expect(sDevolucao.itensFiltrados.first.emprestimo.id, 2);

      // Filtro todos
      notifier.updateFiltroTipo('todos');
      expect(container.read(historicoEmprestimosStoreProvider).value!.itensFiltrados.length, 2);
    });
  });
}
