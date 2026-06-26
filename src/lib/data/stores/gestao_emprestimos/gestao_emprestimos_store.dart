import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

part 'gestao_emprestimos_store.g.dart';
part 'gestao_emprestimos_store.mapper.dart';

@MappableClass()
class GestaoEmprestimosState with GestaoEmprestimosStateMappable {
  final List<Aluno> alunos;
  final List<Aluno> alunosFiltrados;
  final List<Emprestimo> emprestimos;
  final List<Estoque> estoque;
  final List<Estoque> estoqueFiltrado;
  final TamanhoKimono? tamanho;
  final CorKimono? cor;
  final Estoque? kimono;

  GestaoEmprestimosState({
    required this.alunos,
    required this.alunosFiltrados,
    required this.emprestimos,
    required this.estoque,
    required this.estoqueFiltrado,
    this.tamanho,
    this.cor,
    this.kimono,
  });
}

@Riverpod()
class GestaoEmprestimosStore extends _$GestaoEmprestimosStore {
  String _filtroAluno = '';
  CorKimono? _filtroCor;
  TamanhoKimono? _filtroTamanho;

  @override
  Future<GestaoEmprestimosState> build() async {
    final alunoService = ref.read(alunoServiceProvider);
    final alunos = await alunoService.listarAlunos();

    final kimonoService = ref.read(kimonoServiceProvider);
    final emprestimos = await kimonoService.listarEmprestimos();
    final estoque = await kimonoService.obterEstoque();

    return GestaoEmprestimosState(
      alunos: alunos,
      alunosFiltrados: alunos,
      emprestimos: emprestimos,
      estoque: estoque,
      estoqueFiltrado: estoque,
    );
  }

  void updateFiltroAluno(String filtro) {
    _filtroAluno = filtro.trim().toLowerCase();
    final data = state.value!;

    final filtrado = data.alunos.where((aluno) {
      return aluno.nome.toLowerCase().contains(_filtroAluno);
    }).toList();

    state = AsyncValue.data(data.copyWith(alunosFiltrados: filtrado));
  }

  void updateFiltroCor(CorKimono? cor) {
    _filtroCor = cor;
    final data = state.value!;
    state = AsyncValue.data(data.copyWith(cor: cor));
    _filtrarEstoque();
  }

  void updateFiltroTamanho(TamanhoKimono? tamanho) {
    _filtroTamanho = tamanho;
    final data = state.value!;
    state = AsyncValue.data(data.copyWith(tamanho: tamanho));
    _filtrarEstoque();
  }

  void _filtrarEstoque() {
    final data = state.value!;

    final filtrado = data.estoque.where((kimono) {
      if (_filtroCor != null && kimono.cor != _filtroCor) {
        return false;
      }

      if (_filtroTamanho != null && kimono.tamanho != _filtroTamanho) {
        return false;
      }

      return true;
    }).toList();

    state = AsyncValue.data(data.copyWith(estoqueFiltrado: filtrado));
  }

  void updateKimono(Estoque kimono) {
    print(kimono.tamanho.nomeVisivel);
    final data = state.value!;
    state = AsyncValue.data(data.copyWith(kimono: kimono));
  }
}
