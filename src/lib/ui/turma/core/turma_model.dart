class AlunoModel {
  final String nome;

  const AlunoModel({
    required this.nome,
  });
}

class TurmaModel {
  final String id;
  final String nome;
  final int totalAlunos;
  final String diasHorario;
  final String? descricao;
  final List<AlunoModel>? alunos;

  const TurmaModel({
    required this.id,
    required this.nome,
    required this.totalAlunos,
    required this.diasHorario,
    this.descricao,
    this.alunos,
  });
}

// Mock data com apenas duas turmas (Infantil e Adultos)
final List<TurmaModel> turmasMock = [
  TurmaModel(
    id: '1',
    nome: 'Turma Infantil',
    totalAlunos: 6,
    diasHorario: 'Terça e Quinta, 8h-10h',
    descricao: 'Categoria: Infantil',
    alunos: const [
      AlunoModel(nome: 'Pedro Ramos Sousa Reis'),
      AlunoModel(nome: 'Lucas Silva'),
      AlunoModel(nome: 'Mariana Costa'),
      AlunoModel(nome: 'João Felipe'),
      AlunoModel(nome: 'Ana Beatriz'),
      AlunoModel(nome: 'Matheus Oliveira'),
    ],
  ),
  TurmaModel(
    id: '2',
    nome: 'Turma Adultos',
    totalAlunos: 4,
    diasHorario: 'Segunda e Quarta, 19h-21h',
    descricao: 'Categoria: Adultos',
    alunos: const [
      AlunoModel(nome: 'Carlos Augusto'),
      AlunoModel(nome: 'Roberto Alves'),
      AlunoModel(nome: 'Fernanda Lima'),
      AlunoModel(nome: 'Rafael Souza'),
    ],
  ),
];