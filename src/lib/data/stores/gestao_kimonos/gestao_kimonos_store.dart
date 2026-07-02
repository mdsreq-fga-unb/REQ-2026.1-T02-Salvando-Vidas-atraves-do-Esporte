import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

part 'gestao_kimonos_store.g.dart';
part 'gestao_kimonos_store.mapper.dart';

@MappableClass()
class GestaoKimonosState with GestaoKimonosStateMappable {
  final List<Estoque> estoque;
  final List<Doacao> doacoes;
  final List<Perda> perdas;
  final List<Emprestimo> emprestimos;
  final Map<int, Aluno> alunos;

  GestaoKimonosState({
    required this.estoque,
    required this.doacoes,
    required this.perdas,
    required this.emprestimos,
    required this.alunos,
  });
}

@Riverpod(keepAlive: true)
class GestaoKimonosStore extends _$GestaoKimonosStore {
  @override
  Future<GestaoKimonosState> build() async {
    final kimonoService = ref.read(kimonoServiceProvider);
    final alunoService = ref.read(alunoServiceProvider);

    final alunos = await alunoService.listarAlunos();
    final Map<int, Aluno> alunosIndexados = {};

    for (final aluno in alunos) {
      alunosIndexados[aluno.id ?? -1] = aluno;
    }

    final estoque = await kimonoService.obterEstoque();
    final doacoes = await kimonoService.listarDoacoes();
    final perdas = await kimonoService.listarPerdas();
    final emprestimos = await kimonoService.listarEmprestimos();

    return GestaoKimonosState(
      estoque: estoque,
      doacoes: doacoes,
      perdas: perdas,
      emprestimos: emprestimos,
      alunos: alunosIndexados,
    );
  }
}
