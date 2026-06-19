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
  bool mostrarInativos;

  PesquisaAlunoState({
    required this.alunos,
    required this.alunosFiltrados,
    required this.responsaveis,
    this.mostrarInativos = false,
  });
}

@riverpod
class PesquisaAluno extends _$PesquisaAluno {
  String _filtroAtual = '';

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
      alunosFiltrados: alunos.where((a) => a.ativo).toList(),
      responsaveis: responsaveis,
      mostrarInativos: false,
    );
  }

  void filtrarAlunos(String filtro) {
    _filtroAtual = filtro;
    _aplicarFiltro();
  }

  void toggleMostrarInativos() {
    final data = state.value!;
    final novoValor = !data.mostrarInativos;
    state = AsyncValue.data(data.copyWith(mostrarInativos: novoValor));
    _aplicarFiltro();
  }

  void _aplicarFiltro() {
    final data = state.value!;
    final busca = _filtroAtual.trim().toLowerCase();

    final filtrado = data.alunos.where((aluno) {
      final nomeAluno = aluno.nome.toLowerCase();
      final nomeOk = nomeAluno.contains(busca);
      final ativoOk = data.mostrarInativos ? true : aluno.ativo;
      return nomeOk && ativoOk;
    }).toList();

    state = AsyncValue.data(data.copyWith(alunosFiltrados: filtrado));
  }

  Future<void> reativarAluno(int idAluno) async {
    final service = ref.read(alunoServiceProvider);
    await service.atualizaAluno(idAluno, {'ativo': true});

    final data = state.value!;
    final alunosAtualizados = data.alunos.map((a) {
      return a.id == idAluno ? a.copyWith(ativo: true) : a;
    }).toList();

    state = AsyncValue.data(data.copyWith(alunos: alunosAtualizados));
    _aplicarFiltro();
  }

  Future<void> inativarAluno(int idAluno) async {
    final service = ref.read(alunoServiceProvider);
    await service.atualizaAluno(idAluno, {'ativo': false});

    final data = state.value!;
    final alunosAtualizados = data.alunos.map((a) {
      return a.id == idAluno ? a.copyWith(ativo: false) : a;
    }).toList();

    state = AsyncValue.data(data.copyWith(alunos: alunosAtualizados));
    _aplicarFiltro();
  }
}
