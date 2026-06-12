import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

part 'presenca_store.g.dart';

@riverpod
class PresencaStore extends _$PresencaStore {
  @override
  Future<List<Aluno>> build(int id) async {
    state = const AsyncLoading();

    final alunoService = ref.watch(alunoServiceProvider);

    return await alunoService.listarAlunosTurma(id);
  }
}
