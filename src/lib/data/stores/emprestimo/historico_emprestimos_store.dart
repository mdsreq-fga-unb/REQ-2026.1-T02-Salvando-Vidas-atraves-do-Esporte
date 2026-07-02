import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

part 'historico_emprestimos_store.g.dart';
part 'historico_emprestimos_store.mapper.dart';

/// Representa uma entrada unificada no histórico (empréstimo ou devolução).
@MappableClass()
class HistoricoItem with HistoricoItemMappable {
  final Emprestimo emprestimo;
  final Aluno? aluno;
  final LocalUser? voluntario;

  HistoricoItem({
    required this.emprestimo,
    this.aluno,
    this.voluntario,
  });
}

@MappableClass()
class HistoricoEmprestimosState with HistoricoEmprestimosStateMappable {
  final List<HistoricoItem> itens;
  final List<HistoricoItem> itensFiltrados;
  final String filtroTipo; // 'todos' | 'emprestimo' | 'devolucao'

  HistoricoEmprestimosState({
    required this.itens,
    required this.itensFiltrados,
    this.filtroTipo = 'todos',
  });
}

@Riverpod()
class HistoricoEmprestimosStore extends _$HistoricoEmprestimosStore {
  String _filtroTipo = 'todos';

  @override
  Future<HistoricoEmprestimosState> build() async {
    final kimonoService = ref.read(kimonoServiceProvider);
    final alunoService = ref.read(alunoServiceProvider);
    final userService = ref.read(userServiceProvider);

    final emprestimos = await kimonoService.listarEmprestimos();
    final alunos = await alunoService.listarAlunos();
    final voluntarios = await userService.listUsers();

    final Map<int, Aluno> alunosMap = {
      for (final a in alunos) if (a.id != null) a.id!: a,
    };
    final Map<String, LocalUser> voluntariosMap = {
      for (final v in voluntarios) if (v.id != null) v.id!: v,
    };

    // Gera um HistoricoItem para cada empréstimo.
    // Se tiver dataDevolucao, também aparece como devolução (mesmos dados).
    // A ordenação é feita pela data mais recente primeiro.
    final itens = emprestimos.map((emp) {
      return HistoricoItem(
        emprestimo: emp,
        aluno: alunosMap[emp.alunoId],
        // voluntario: voluntariosMap[emp.voluntarioId], // descomente quando o campo existir no model
      );
    }).toList()
      ..sort((a, b) {
        final dataA = a.emprestimo.dataDevolucao ?? a.emprestimo.data;
        final dataB = b.emprestimo.dataDevolucao ?? b.emprestimo.data;
        return dataB.compareTo(dataA);
      });

    return HistoricoEmprestimosState(
      itens: itens,
      itensFiltrados: itens,
      filtroTipo: 'todos',
    );
  }

  void updateFiltroTipo(String tipo) {
    _filtroTipo = tipo;
    final data = state.value!;

    final filtrado = data.itens.where((item) {
      if (tipo == 'emprestimo') return item.emprestimo.dataDevolucao == null;
      if (tipo == 'devolucao') return item.emprestimo.dataDevolucao != null;
      return true;
    }).toList();

    state = AsyncValue.data(
      data.copyWith(itensFiltrados: filtrado, filtroTipo: tipo),
    );
  }
}