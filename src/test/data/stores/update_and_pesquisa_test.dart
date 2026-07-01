import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/data/stores/update_aluno/update_aluno.dart';
import 'package:salvando_vidas/data/stores/update_voluntario/update_voluntario_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';

Aluno criarAlunoTeste({required int id, required String nome, required bool ativo, int? idResponsavel}) {
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
    ativo: ativo,
    federado: false,
    idTurma: 1,
    idResponsavel: idResponsavel,
  );
}

class FakeUserServiceUP extends Fake implements UserService {
  @override
  LocalUser? get localUser => LocalUser(
        id: 'vol-1',
        role: Role.voluntario,
        nome: 'Voluntario Teste',
        telefone: '11987654321',
        cpf: '52998224725',
        email: 'vol@teste.com',
        funcao: 'Professor',
        faixa: Faixa.preta,
      );
}

class FakeAlunoServiceUP extends Fake implements AlunoService {
  @override
  Future<List<Aluno>> listarAlunos() async => [
        criarAlunoTeste(id: 1, nome: 'Ana Aluno', ativo: true, idResponsavel: 10),
        criarAlunoTeste(id: 2, nome: 'Beto Aluno', ativo: false),
      ];

  @override
  Future<List<Responsavel>> listarResponsaveis() async => [
        Responsavel(id: 10, nome: 'Resp 10', cpf: '07481138096', contato: '11987654321', email: 'resp@teste.com', ativo: true),
      ];

  @override
  Future<Aluno> atualizaAluno(int id, Map<String, dynamic> data) async {
    return criarAlunoTeste(id: id, nome: 'Atualizado', ativo: data['ativo'] ?? true);
  }
}

void main() {
  group('UpdateAluno Store Tests', () {
    test('build and updates', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final aluno = criarAlunoTeste(id: 1, nome: 'Orig', ativo: true);
      final resp = Responsavel(id: 10, nome: 'Resp Orig', cpf: '52998224725', contato: '11987654321', email: 'r@t.com', ativo: true);

      final provider = updateAlunoProvider(aluno, resp);
      final notifier = container.read(provider.notifier);

      expect(container.read(provider).nomeError, isNull); // igual ao original

      notifier.updateNome('');
      expect(container.read(provider).nomeError, isNotNull);

      notifier.updateNome('Novo Nome');
      notifier.updateCPF('52998224725');
      notifier.updateContato('11987654321');
      notifier.updateContatoEmergencia('11987654322');
      notifier.updateEmail('novo@t.com');
      notifier.updateNascimento(DateTime(2012, 1, 1));
      notifier.updateTipoSanguineo(TipoSanguineo.aPositivo);
      notifier.updateFaixa(Faixa.cinza);
      notifier.updateIdFicha('50');

      notifier.updateNomeResponsavel('Novo Resp');
      notifier.updateCPFResponsavel('52998224725');
      notifier.updateContatoResponsavel('11987654323');
      notifier.updateEmailResponsavel('nr@t.com');

      final state = container.read(provider);
      expect(state.aluno.nome, 'Novo Nome');
      expect(state.responsavel.nome, 'Novo Resp');
      expect(state.diffAluno(state.aluno), isNotEmpty);
      expect(state.estaValido, isTrue);
      expect(state.temResponsavel, isTrue);

      notifier.updateIdFicha('abc');
      expect(container.read(provider).idFichaError, isNotNull);
    });
  });

  group('UpdateVoluntario Store Tests', () {
    test('build and updates', () {
      final container = ProviderContainer(
        overrides: [
          userServiceProvider.overrideWithValue(FakeUserServiceUP()),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(updateVoluntarioProvider.notifier);
      expect(container.read(updateVoluntarioProvider).podeCadastrar, isTrue);

      notifier.updateNome('Vol Modificado');
      notifier.updateEmail('mod@t.com');
      notifier.updateTelefone('11987654322');
      notifier.updateSenha('novasenha');
      notifier.updateCpf('52998224725');
      notifier.updateFuncao('Coordenador');
      notifier.updateFaixa(Faixa.marrom);

      final state = container.read(updateVoluntarioProvider);
      expect(state.podeCadastrar, isTrue);
      expect(state.diff['p_nome'], 'Vol Modificado');

      notifier.updateNome('');
      expect(container.read(updateVoluntarioProvider).nomeError, isNotNull);
      notifier.updateEmail('inv');
      expect(container.read(updateVoluntarioProvider).emailError, isNotNull);
      notifier.updateTelefone('1');
      expect(container.read(updateVoluntarioProvider).telefoneError, isNotNull);
      notifier.updateCpf('2');
      expect(container.read(updateVoluntarioProvider).cpfError, isNotNull);
      notifier.updateFuncao('');
      expect(container.read(updateVoluntarioProvider).funcaoError, isNotNull);
    });
  });

  group('PesquisaAluno Store Tests', () {
    test('build, filtrar e ativar/inativar', () async {
      final container = ProviderContainer(
        overrides: [
          alunoServiceProvider.overrideWithValue(FakeAlunoServiceUP()),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(pesquisaAlunoProvider.future);
      expect(state.alunosFiltrados.length, 1); // Ana (ativa)
      expect(state.responsaveis[1]?.nome, 'Resp 10');

      final notifier = container.read(pesquisaAlunoProvider.notifier);
      notifier.toggleMostrarInativos();
      expect(container.read(pesquisaAlunoProvider).value?.alunosFiltrados.length, 2);

      notifier.filtrarAlunos('beto');
      expect(container.read(pesquisaAlunoProvider).value?.alunosFiltrados.length, 1);

      await notifier.reativarAluno(2);
      expect(container.read(pesquisaAlunoProvider).value?.alunos.firstWhere((a) => a.id == 2).ativo, isTrue);

      await notifier.inativarAluno(1);
      expect(container.read(pesquisaAlunoProvider).value?.alunos.firstWhere((a) => a.id == 1).ativo, isFalse);
    });
  });
}
