import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/data/stores/home/home_store.dart';
import 'package:salvando_vidas/data/stores/registro_kimonos/registro_kimonos_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/domain/presenca/presenca.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';

Aluno criarAlunoTeste({
  required int id,
  required String nome,
  required DateTime nascimento,
  required bool ativo,
  int? idTurma,
  int? idResponsavel,
}) {
  return Aluno(
    id: id,
    nome: nome,
    cpf: '52998224725',
    nascimento: nascimento,
    email: 'aluno$id@teste.com',
    faixa: Faixa.branca,
    grau: 0,
    tipoSanguineo: TipoSanguineo.oPositivo,
    dataEntrada: DateTime(2025, 1, 1),
    ativo: ativo,
    federado: false,
    idTurma: idTurma,
    idResponsavel: idResponsavel,
  );
}

class FakeAlunoServiceHome extends Fake implements AlunoService {
  @override
  Future<List<Aluno>> listarAlunos() async {
    final hoje = DateTime.now();
    final niverProximo = DateTime(hoje.year - 10, hoje.month, hoje.day).add(const Duration(days: 2));
    final niverPassado = DateTime(hoje.year - 10, hoje.month, hoje.day).subtract(const Duration(days: 5));

    return [
      criarAlunoTeste(id: 1, nome: 'Lucas Silva', nascimento: niverProximo, ativo: true, idTurma: 1),
      criarAlunoTeste(id: 2, nome: 'Ana Santos', nascimento: niverPassado, ativo: true, idTurma: 1),
      criarAlunoTeste(id: 3, nome: 'Inativo', nascimento: hoje, ativo: false, idTurma: 1),
    ];
  }
}

class FakeTurmaServiceHome extends Fake implements TurmaService {
  @override
  Future<List<Turma>> listarTurmas() async => [
        Turma(
          id: 1,
          nome: 'Turma A',
          descricao: '',
          faixaEtaria: FaixaEtaria.infantil,
          horarioInicio: DateTime.now(),
          horarioFim: DateTime.now(),
          ativo: true,
          eSegunda: true,
          eTerca: false,
          eQuarta: false,
          eQuinta: false,
          eSexta: false,
          eSabado: false,
          eDomingo: false,
        ),
      ];
}

class FakePresencaServiceHome extends Fake implements PresencaService {
  @override
  Future<List<UltimaPresenca>> obterUltimasPresencas() async => [
        UltimaPresenca(alunoId: 1, alunoNome: 'Lucas Silva', dataUltimaPresenca: DateTime.now(), diasDesdeUltimaPresenca: 3),
        UltimaPresenca(alunoId: 2, alunoNome: 'Ana Santos', dataUltimaPresenca: DateTime.now(), diasDesdeUltimaPresenca: 20),
      ];
}

void main() {
  group('HomeStore & RegistroKimonosStore Tests', () {
    test('RegistroKimonosStore methods & getters', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(registroKimonosStoreProvider.notifier);
      expect(container.read(registroKimonosStoreProvider).doacaoValida, isFalse);

      notifier.updateTamanhoDoacao(TamanhoKimono.a1);
      notifier.updateCorDoacao(CorKimono.azul);
      notifier.updateDoador('Empresa X');
      notifier.updateQtdDoada('10');

      final state = container.read(registroKimonosStoreProvider);
      expect(state.doacaoValida, isTrue);
      expect(state.doacao.quantidade, 10);

      // Perda
      expect(state.perdaValida, isFalse);
      notifier.updateKimonoPerdido(Estoque(cor: CorKimono.preto, tamanho: TamanhoKimono.a2, quantidadeDisponivel: 5));
      notifier.updateMotivo('Rasgou na competição');
      notifier.updateQtdPerdida('1');

      final statePerda = container.read(registroKimonosStoreProvider);
      expect(statePerda.perdaValida, isTrue);
      expect(statePerda.perda.motivo, 'Rasgou na competição');

      notifier.reset();
      expect(container.read(registroKimonosStoreProvider).doador, '');
    });

    test('HomeStore build, sort and aniversariantes', () async {
      final container = ProviderContainer(
        overrides: [
          alunoServiceProvider.overrideWithValue(FakeAlunoServiceHome()),
          turmaServiceProvider.overrideWithValue(FakeTurmaServiceHome()),
          presencaServiceProvider.overrideWithValue(FakePresencaServiceHome()),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(homeStoreProvider.future);
      expect(state.totalAtivos, 2);
      expect(state.totalInativos, 1);
      expect(state.alertasEvasao, 1); // Ana Santos com 20 dias

      final niver = state.proximoAniversariante;
      expect(niver.length, 1);
      expect(niver.first.aluno.nome, 'Lucas Silva');

      final notifier = container.read(homeStoreProvider.notifier);
      notifier.toggleOrder(OrderBy.nome);
      expect(container.read(homeStoreProvider).value?.orderBy, OrderBy.nome);

      notifier.toggleOrder(OrderBy.nome); // toggle asc/desc
      expect(container.read(homeStoreProvider).value?.ascending, false);

      notifier.toggleOrder(OrderBy.ultimaPresenca);
      expect(container.read(homeStoreProvider).value?.orderBy, OrderBy.ultimaPresenca);
    });
  });
}
