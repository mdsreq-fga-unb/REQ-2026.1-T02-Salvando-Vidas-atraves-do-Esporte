import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/presenca/historico_frequencia_provider.dart';
import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/domain/observacao/observacao.dart';
import 'package:salvando_vidas/domain/presenca/presenca.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';

class FakePresencaService extends Fake implements PresencaService {
  @override
  Future<List<Presenca>> listarPresencasPorAluno(int alunoId) async {
    return [
      Presenca(id: 1, alunoId: 10, turmaId: 20, data: DateTime(2026, 6, 29)),
    ];
  }

  @override
  Future<List<Observacao>> listarObservacoesPorTurma(int idTurma) async {
    return [
      Observacao(id: 1, voluntario: 'user-1', observacao: 'Boa aula', turmaId: 20, data: DateTime(2026, 6, 29)),
      Observacao(id: 2, voluntario: 'user-1', observacao: 'Falta', turmaId: 20, data: DateTime(2026, 6, 28)),
    ];
  }

  @override
  Future<List<Presenca>> listarTodasPresencasPorTurma(int idTurma) async {
    return [
      Presenca(id: 1, alunoId: 10, turmaId: 20, data: DateTime(2026, 6, 29)),
    ];
  }
}

class FakeUserService extends Fake implements UserService {
  @override
  Future<List<LocalUser>> listUsers() async {
    return [
      const LocalUser(
        id: 'user-1',
        nome: 'Professor Mestre',
        role: Role.voluntario,
        telefone: '1111',
        cpf: '111',
        email: 'prof@teste.com',
        funcao: 'Prof',
        faixa: Faixa.preta,
      ),
    ];
  }
}

class FakeAlunoService extends Fake implements AlunoService {
  @override
  Future<List<Aluno>> listarAlunosTurma(int id) async {
    return [
      Aluno(
        id: 10,
        nome: 'Gabriel Aluno',
        nascimento: DateTime(2010, 1, 1),
        cpf: '111.111.111-11',
        email: 'gabriel@email.com',
        idTurma: 20,
        faixa: Faixa.branca,
        grau: 1,
        tipoSanguineo: TipoSanguineo.aPositivo,
        dataEntrada: DateTime(2023, 1, 10),
        ativo: true,
        federado: false,
      ),
      Aluno(
        id: 11,
        nome: 'Lucas Aluno',
        nascimento: DateTime(2011, 1, 1),
        cpf: '222.222.222-22',
        email: 'lucas@email.com',
        idTurma: 20,
        faixa: Faixa.cinza,
        grau: 1,
        tipoSanguineo: TipoSanguineo.oPositivo,
        dataEntrada: DateTime(2023, 1, 10),
        ativo: true,
        federado: false,
      ),
    ];
  }
}

class FakeTurmasStore extends TurmasStore {
  @override
  Future<List<Turma>> build() async {
    return [
      Turma(
        id: 20,
        nome: 'Turma Juvenil',
        descricao: 'Desc',
        faixaEtaria: FaixaEtaria.infantil,
        horarioInicio: DateTime(2026, 1, 1, 10, 0),
        horarioFim: DateTime(2026, 1, 1, 11, 0),
        ativo: true,
        eSegunda: true,
        eTerca: false,
        eQuarta: true,
        eQuinta: false,
        eSexta: true,
        eSabado: false,
        eDomingo: false,
        qtdAlunos: 2,
      ),
    ];
  }
}

void main() {
  final alunoTeste = Aluno(
    id: 10,
    nome: 'Gabriel Aluno',
    nascimento: DateTime(2010, 1, 1),
    cpf: '111.111.111-11',
    email: 'gabriel@email.com',
    idTurma: 20,
    faixa: Faixa.branca,
    grau: 1,
    tipoSanguineo: TipoSanguineo.aPositivo,
    dataEntrada: DateTime(2023, 1, 10),
    ativo: true,
    federado: false,
  );

  test('historicoFrequenciaAlunoProvider calcula corretamente presença e percentual', () async {
    final container = ProviderContainer(
      overrides: [
        presencaServiceProvider.overrideWithValue(FakePresencaService()),
        userServiceProvider.overrideWithValue(FakeUserService()),
        turmasStoreProvider.overrideWith(() => FakeTurmasStore()),
      ],
    );
    addTearDown(container.dispose);

    final data = await container.read(historicoFrequenciaAlunoProvider(alunoTeste).future);

    expect(data.totalAulas, 2);
    expect(data.totalPresencas, 1);
    expect(data.totalAusencias, 1);
    expect(data.percentualFrequencia, 50.0);
    expect(data.itens.first.voluntarioNome, 'Professor Mestre');
    expect(data.itens.first.turmaNome, 'Turma Juvenil');
  });

  test('historicoFrequenciaTurmaProvider calcula resumo das sessões e alunos', () async {
    final container = ProviderContainer(
      overrides: [
        presencaServiceProvider.overrideWithValue(FakePresencaService()),
        userServiceProvider.overrideWithValue(FakeUserService()),
        alunoServiceProvider.overrideWithValue(FakeAlunoService()),
        turmasStoreProvider.overrideWith(() => FakeTurmasStore()),
      ],
    );
    addTearDown(container.dispose);

    final data = await container.read(historicoFrequenciaTurmaProvider(20).future);

    expect(data.turmaNome, 'Turma Juvenil');
    expect(data.sessoes.length, 2);
    expect(data.resumosAlunos.length, 2);
  });
}
