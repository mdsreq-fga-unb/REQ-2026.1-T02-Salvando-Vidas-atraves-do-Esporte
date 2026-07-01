import 'aluno.dart';

final List<Aluno> alunosMock = [
  Aluno(
    id: 1,
    nome: 'Pedro Ramos Sousa Reis',
    cpf: '123.456.789-10',
    contato: '1234-5678',
    email: 'pedro@email.com',
    faixa: Faixa.branca,
    grau: 1,
    tipoSanguineo: TipoSanguineo.aPositivo,
    dataEntrada: DateTime(2023, 1, 10),
    nascimento: DateTime(2004, 3, 12),
    ativo: true,
    federado: false,
    idFicha: 167,
    idTurma: 1,
    idResponsavel: 101, // Indica que tem responsável
  ),
  Aluno(
    id: 2,
    nome: 'Lucas Silva',
    cpf: '987.654.321-00',
    contato: '9876-5432',
    email: 'lucas@email.com',
    faixa: Faixa.azul,
    grau: 2,
    tipoSanguineo: TipoSanguineo.oPositivo,
    dataEntrada: DateTime(2022, 5, 20),
    nascimento: DateTime(1995, 8, 25),
    ativo: true,
    federado: true,
    idFicha: 168,
    idTurma: 2,
    idResponsavel: null, // Maior de idade
  ),
];
