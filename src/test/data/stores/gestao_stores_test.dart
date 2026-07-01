import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/data/stores/gestao_emprestimos/gestao_emprestimos_store.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

Aluno criarAlunoTeste({required int id, required String nome}) {
  return Aluno(
    id: id,
    nome: nome,
    cpf: '52998224725',
    nascimento: DateTime(2010, 1, 1),
    email: 'aluno$id@teste.com',
    faixa: Faixa.branca,
    grau: 0,
    tipoSanguineo: TipoSanguineo.oPositivo,
    dataEntrada: DateTime(2025, 1, 1),
    ativo: true,
    federado: false,
    idTurma: 1,
  );
}

class FakeKimonoService extends Fake implements KimonoService {
  @override
  Future<List<Estoque>> obterEstoque() async => [
        Estoque(cor: CorKimono.azul, tamanho: TamanhoKimono.a1, quantidadeDisponivel: 5),
        Estoque(cor: CorKimono.branco, tamanho: TamanhoKimono.a2, quantidadeDisponivel: 2),
      ];

  @override
  Future<List<Doacao>> listarDoacoes() async => [];

  @override
  Future<List<Perda>> listarPerdas() async => [];

  @override
  Future<List<Emprestimo>> listarEmprestimos() async => [];
}

class FakeAlunoService extends Fake implements AlunoService {
  @override
  Future<List<Aluno>> listarAlunos() async => [
        criarAlunoTeste(id: 1, nome: 'Lucas Silva'),
        criarAlunoTeste(id: 2, nome: 'Pedro Santos'),
      ];
}

void main() {
  group('Gestao Stores Tests', () {
    test('GestaoKimonosStore build', () async {
      final container = ProviderContainer(
        overrides: [
          kimonoServiceProvider.overrideWithValue(FakeKimonoService()),
          alunoServiceProvider.overrideWithValue(FakeAlunoService()),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(gestaoKimonosStoreProvider.future);
      expect(state.estoque.length, 2);
      expect(state.alunos.length, 2);
      expect(state.alunos[1]?.nome, 'Lucas Silva');
    });

    test('GestaoEmprestimosStore filtros e updates', () async {
      final container = ProviderContainer(
        overrides: [
          kimonoServiceProvider.overrideWithValue(FakeKimonoService()),
          alunoServiceProvider.overrideWithValue(FakeAlunoService()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(gestaoEmprestimosStoreProvider.future);
      final notifier = container.read(gestaoEmprestimosStoreProvider.notifier);

      // Filtro aluno
      notifier.updateFiltroAluno('lucas');
      expect(container.read(gestaoEmprestimosStoreProvider).value?.alunosFiltrados.length, 1);

      // Filtro cor
      notifier.updateFiltroCor(CorKimono.azul);
      expect(container.read(gestaoEmprestimosStoreProvider).value?.estoqueFiltrado.length, 1);

      // Filtro tamanho
      notifier.updateFiltroTamanho(TamanhoKimono.a1);
      expect(container.read(gestaoEmprestimosStoreProvider).value?.estoqueFiltrado.length, 1);

      // Limpar filtros e testar cor/tamanho que não existem juntos
      notifier.updateFiltroCor(CorKimono.rosa);
      expect(container.read(gestaoEmprestimosStoreProvider).value?.estoqueFiltrado.length, 0);

      notifier.updateFiltroCor(null);
      notifier.updateFiltroTamanho(null);
      expect(container.read(gestaoEmprestimosStoreProvider).value?.estoqueFiltrado.length, 2);

      // Update kimono
      final e = Estoque(cor: CorKimono.azul, tamanho: TamanhoKimono.a1, quantidadeDisponivel: 5);
      notifier.updateKimono(e);
      expect(container.read(gestaoEmprestimosStoreProvider).value?.kimono, e);
    });
  });
}
