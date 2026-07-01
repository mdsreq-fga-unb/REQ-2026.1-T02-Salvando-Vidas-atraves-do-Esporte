import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';

part 'turmas_store.g.dart';

@Riverpod()
class TurmasStore extends _$TurmasStore {
  @override
  Future<List<Turma>> build() async {
    state = const AsyncLoading();

    final alunoService = ref.watch(turmaServiceProvider);

    return await alunoService.listarTurmas();
  }
}
