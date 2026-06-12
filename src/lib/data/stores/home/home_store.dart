import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

part 'home_store.g.dart';
part 'home_store.mapper.dart';

@Riverpod(keepAlive: true)
class HomeStore extends _$HomeStore {
  @override
  Future<HomeState> build() async {
    state = const AsyncLoading();

    final alunos = await ref.read(alunoServiceProvider).listarAlunos();
    final turmas = await ref.read(turmaServiceProvider).listarTurmas();

    return HomeState(
      alunos: alunos,
      totalTurmas: turmas.length,
      kimonosDisponiveis: 0,
    );
  }
}

@MappableClass()
class HomeState with HomeStateMappable {
  final List<Aluno> alunos;
  final int totalTurmas;
  final int kimonosDisponiveis;

  HomeState({
    required this.alunos,
    required this.totalTurmas,
    required this.kimonosDisponiveis,
  });

  List<({Aluno aluno, int dias})> get proximoAniversariante {
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);

    final alunosComDiasParaNiver = alunos.map((aluno) {
      DateTime aniversarioEsteAno = DateTime(
        hoje.year,
        aluno.nascimento.month,
        aluno.nascimento.day,
      );

      if (aniversarioEsteAno.isBefore(hoje)) {
        aniversarioEsteAno = DateTime(
          hoje.year + 1,
          aluno.nascimento.month,
          aluno.nascimento.day,
        );
      }

      final diasRestantes = aniversarioEsteAno.difference(hoje).inDays;

      return (aluno: aluno, dias: diasRestantes);
    });

    final aniversariantes = alunosComDiasParaNiver
        .where((item) => item.dias >= 0 && item.dias <= 7)
        .toList();

    aniversariantes.sort((a, b) => a.dias.compareTo(b.dias));

    return aniversariantes;
  }
}
