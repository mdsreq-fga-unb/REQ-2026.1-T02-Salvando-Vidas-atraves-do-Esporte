import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/data/stores/theme/theme_store.dart';
import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/domain/observacao/observacao.dart';
import 'package:salvando_vidas/domain/presenca/presenca.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:shared_preferences/shared_preferences.dart';

Aluno criarAlunoTeste({required int id, required String nome, required int idTurma}) {
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
    idTurma: idTurma,
  );
}

class FakeTurmaServiceT extends Fake implements TurmaService {
  @override
  Future<List<Turma>> listarTurmas() async => [
        Turma(
          id: 1,
          nome: 'Turma Teste',
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

class FakeAlunoServiceT extends Fake implements AlunoService {
  @override
  Future<List<Aluno>> listarAlunosTurma(int idTurma) async => [
        criarAlunoTeste(id: 10, nome: 'Aluno 10', idTurma: idTurma),
        criarAlunoTeste(id: 11, nome: 'Aluno 11', idTurma: idTurma),
      ];
}

class FakeUserServiceT extends Fake implements UserService {
  @override
  Future<List<LocalUser>> listUsers() async => [
        LocalUser(
          id: 'prof-1',
          role: Role.voluntario,
          nome: 'Professor 1',
          telefone: '11987654321',
          cpf: '12345678901',
          email: 'prof1@teste.com',
          funcao: 'Professor',
          faixa: Faixa.preta,
        ),
        LocalUser(
          id: 'prof-2',
          role: Role.voluntario,
          nome: 'Professor 2',
          telefone: '11987654322',
          cpf: '12345678902',
          email: 'prof2@teste.com',
          funcao: 'Professor',
          faixa: Faixa.preta,
        ),
      ];
}

class FakePresencaServiceT extends Fake implements PresencaService {
  @override
  Future<Observacao?> obterObservacao(int idTurma, DateTime data) async {
    if (idTurma == 1) {
      return Observacao(id: 1, voluntario: 'prof-1', observacao: 'Boa aula', turmaId: 1, data: data);
    }
    return null;
  }

  @override
  Future<List<Presenca>> listarPresencas(int idTurma, DateTime data) async => [
        Presenca(id: 1, alunoId: 10, turmaId: idTurma, data: data),
      ];
}

void main() {
  group('ThemeStore Tests', () {
    test('build and toggle', () async {
      SharedPreferences.setMockInitialValues({'dark_mode': true});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initial = await container.read(themeStoreProvider.future);
      expect(initial, isTrue);

      final notifier = container.read(themeStoreProvider.notifier);
      await notifier.toggle();
      expect(container.read(themeStoreProvider).value, isFalse);
    });
  });

  group('TurmasStore Tests', () {
    test('build', () async {
      final container = ProviderContainer(
        overrides: [
          turmaServiceProvider.overrideWithValue(FakeTurmaServiceT()),
        ],
      );
      addTearDown(container.dispose);

      final turmas = await container.read(turmasStoreProvider.future);
      expect(turmas.length, 1);
      expect(turmas.first.nome, 'Turma Teste');
    });
  });

  group('PresencaStore Tests', () {
    test('build, updateProfessor, togglePresenca, updateData', () async {
      final container = ProviderContainer(
        overrides: [
          alunoServiceProvider.overrideWithValue(FakeAlunoServiceT()),
          userServiceProvider.overrideWithValue(FakeUserServiceT()),
          presencaServiceProvider.overrideWithValue(FakePresencaServiceT()),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(presencaStoreProvider(1).future);
      expect(state.eValido, isTrue);
      expect(state.professor?.nome, 'Professor 1');
      expect(state.presenca[10], isTrue); // veio do listarPresencas
      expect(state.presenca[11], isFalse);

      final notifier = container.read(presencaStoreProvider(1).notifier);
      notifier.togglePresenca(11);
      expect(container.read(presencaStoreProvider(1)).value?.presenca[11], isTrue);

      final prof2 = LocalUser(
        id: 'prof-2',
        role: Role.voluntario,
        nome: 'Professor 2',
        telefone: '11987654322',
        cpf: '12345678902',
        email: 'prof2@teste.com',
        funcao: 'Professor',
        faixa: Faixa.preta,
      );
      notifier.updateProfessor(prof2);
      expect(container.read(presencaStoreProvider(1)).value?.professor?.nome, 'Professor 2');

      // Testar updateData para turma sem observacao (id=2 para retornar null)
      final stateSemObs = await container.read(presencaStoreProvider(2).future);
      expect(stateSemObs.eValido, isFalse);

      final notifier2 = container.read(presencaStoreProvider(2).notifier);
      notifier2.updateData(DateTime(2026, 2, 2));
      await container.read(presencaStoreProvider(2).future);
      expect(container.read(presencaStoreProvider(2)).value?.data.month, 2);
    });
  });
}
