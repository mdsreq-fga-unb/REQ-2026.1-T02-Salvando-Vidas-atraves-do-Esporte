import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:collection/collection.dart';

part 'pesquisa_aluno_store.g.dart';
part 'pesquisa_aluno_store.mapper.dart';

@MappableClass()
class PesquisaAlunoState with PesquisaAlunoStateMappable {
  List<Aluno> alunos;
  List<Aluno> alunosFiltrados;
  Map<int, Responsavel> responsaveis;

  PesquisaAlunoState({
    required this.alunos,
    required this.alunosFiltrados,
    required this.responsaveis,
  });
}

@riverpod
class PesquisaAluno extends _$PesquisaAluno {
  @override
  Future<PesquisaAlunoState> build() async {
    final service = ref.read(alunoServiceProvider);
    final alunos = await service.listarAlunos();
    final res = await service.listarResponsaveis();

    final Map<int, Responsavel> responsaveis = {};
    for (final r in res) {
      final idAluno = alunos
          .firstWhereOrNull(
            (aluno) =>
                aluno.idResponsavel != null && aluno.idResponsavel == r.id,
          )
          ?.id;
      responsaveis[idAluno ?? 0] = r;
    }

    return PesquisaAlunoState(
      alunos: alunos,
      alunosFiltrados: alunos,
      responsaveis: responsaveis,
    );
  }

  void filtrarAlunos(String filtro) {
    final data = state.value!;

    final filtrado = data.alunos.where((aluno) {
      final nomeAluno = aluno.nome.toLowerCase();
      final busca = filtro.trim().toLowerCase();
      return nomeAluno.contains(busca);
    }).toList();

    state = AsyncValue.data(data.copyWith(alunosFiltrados: filtrado));
  }
}
