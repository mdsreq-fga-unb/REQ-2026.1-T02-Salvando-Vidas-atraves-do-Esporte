import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

part 'presenca_store.g.dart';
part 'presenca_store.mapper.dart';

@MappableClass()
class PresencaState with PresencaStateMappable {
  final List<Aluno> alunos;
  final List<LocalUser> usuarios;

  final LocalUser? professor;
  final Map<int, bool> presenca;
  final DateTime data;

  PresencaState({
    required this.alunos,
    required this.usuarios,
    this.professor,
    required this.presenca,
    required this.data,
  });

  bool get eValido => professor != null;
}

@riverpod
class PresencaStore extends _$PresencaStore {
  @override
  Future<PresencaState> build(int id) async {
    state = const AsyncLoading();

    final alunoService = ref.read(alunoServiceProvider);
    final userService = ref.read(userServiceProvider);
    final presencaService = ref.read(presencaServiceProvider);
    final data = DateTime.now();

    final alunos = await alunoService.listarAlunosTurma(id);
    final usuarios = await userService.listUsers();

    final observacao = await presencaService.obterObservacao(id, data);

    LocalUser? professor;

    if (observacao != null) {
      professor = usuarios.firstWhere(
        (user) => user.id == observacao.voluntario,
      );
    }

    final presencaAnterior = await presencaService.listarPresencas(id, data);

    final presenca = {for (final aluno in alunos) aluno.id!: false};

    for (var value in presencaAnterior) {
      presenca[value.alunoId] = true;
    }

    return PresencaState(
      alunos: alunos,
      usuarios: usuarios,
      professor: professor,
      presenca: presenca,
      data: data,
    );
  }

  void updateProfessor(LocalUser user) {
    state = AsyncValue.data(state.value!.copyWith(professor: user));
  }

  void updateData(DateTime data) async {
    final dados = state.value!;

    state = AsyncValue.data(dados.copyWith(data: data));

    final alunoService = ref.read(alunoServiceProvider);
    final userService = ref.read(userServiceProvider);
    final presencaService = ref.read(presencaServiceProvider);

    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final alunos = await alunoService.listarAlunosTurma(id);
      final usuarios = await userService.listUsers();
      final observacao = await presencaService.obterObservacao(id, data);

      LocalUser? professor;

      if (observacao != null) {
        professor = usuarios.firstWhere(
          (user) => user.id == observacao.voluntario,
        );
      }

      final presencaAnterior = await presencaService.listarPresencas(id, data);

      final presenca = {for (final aluno in alunos) aluno.id!: false};

      for (var value in presencaAnterior) {
        presenca[value.alunoId] = true;
      }

      return dados.copyWith(
        professor: professor,
        presenca: presenca,
        data: data,
      );
    });
  }

  void togglePresenca(int id) {
    final presenca = state.value!.presenca;
    if (presenca[id] != null) {
      presenca[id] = !presenca[id]!;
    }
    state = AsyncValue.data(state.value!.copyWith(presenca: presenca));
  }
}
