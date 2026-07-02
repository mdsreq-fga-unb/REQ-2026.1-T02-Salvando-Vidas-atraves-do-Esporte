import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

part 'home_store.g.dart';
part 'home_store.mapper.dart';

typedef AlunoHome = (Aluno aluno, int? turma, int? ultimaPresenca);

enum OrderBy { nome, ultimaPresenca }

@Riverpod()
class HomeStore extends _$HomeStore {
  OrderBy _orderBy = OrderBy.ultimaPresenca;
  bool _ascending = false;

  @override
  Future<HomeState> build() async {
    state = const AsyncLoading();

    final alunos = await ref.read(alunoServiceProvider).listarAlunos();
    final turmas = await ref.read(turmaServiceProvider).listarTurmas();
    final presencas = await ref
        .read(presencaServiceProvider)
        .obterUltimasPresencas();

    // Contagem de ativos e inativos
    final alunosAtivos = alunos.where((a) => a.ativo).toList();
    final totalAtivos = alunosAtivos.length;
    final totalInativos = alunos.where((a) => !a.ativo).length;

    final alunosHome = alunosAtivos
        .map<AlunoHome>(
          (aluno) => (
            aluno,
            aluno.idTurma,
            presencas
                .firstWhereOrNull((presenca) => presenca.alunoId == aluno.id)
                ?.diasDesdeUltimaPresenca,
          ),
        )
        .toList();
    
    _sortAlunos(alunosHome);

    // Alunos em evasão: 14 dias ou mais sem presença OU nunca tiveram presença
    final alertasEvasao = alunosHome.where((a) {
      final dias = a.$3;
      return (dias == null) || (dias >= 14);
    }).length;

    return HomeState(
      alunos: alunosAtivos,
      alunosHome: alunosHome,
      totalTurmas: turmas.length,
      totalAlunos: alunos.length,
      totalAtivos: totalAtivos,
      totalInativos: totalInativos,
      kimonosDisponiveis: 0,
      alertasEvasao: alertasEvasao,
      orderBy: _orderBy,
      ascending: _ascending,
    );
  }

  void toggleOrder(OrderBy field) {
    if (_orderBy == field) {
      _ascending = !_ascending;
    } else {
      _orderBy = field;
      _ascending = field == OrderBy.nome; // Nome padrão ascendente, Presença padrão descendente
    }
    
    if (state.hasValue) {
      final currentAlunos = List<AlunoHome>.from(state.value!.alunosHome);
      _sortAlunos(currentAlunos);
      state = AsyncData(state.value!.copyWith(
        alunosHome: currentAlunos,
        orderBy: _orderBy,
        ascending: _ascending,
      ));
    }
  }

  void _sortAlunos(List<AlunoHome> list) {
    if (_orderBy == OrderBy.nome) {
      list.sort((a, b) => _ascending 
        ? a.$1.nome.compareTo(b.$1.nome)
        : b.$1.nome.compareTo(a.$1.nome));
    } else {
      list.sort((a, b) {
        final valA = a.$3 ?? 1000;
        final valB = b.$3 ?? 1000;
        return _ascending ? valA.compareTo(valB) : valB.compareTo(valA);
      });
    }
  }
}

@MappableClass()
class HomeState with HomeStateMappable {
  final List<Aluno> alunos;
  final List<AlunoHome> alunosHome;
  final int totalTurmas;
  final int totalAlunos;
  final int totalAtivos;
  final int totalInativos;
  final int kimonosDisponiveis;
  final int alertasEvasao;
  final OrderBy orderBy;
  final bool ascending;

  HomeState({
    required this.alunos,
    required this.alunosHome,
    required this.totalTurmas,
    this.totalAlunos = 0,
    this.totalAtivos = 0,
    this.totalInativos = 0,
    this.kimonosDisponiveis = 0,
    this.alertasEvasao = 0,
    this.orderBy = OrderBy.ultimaPresenca,
    this.ascending = false,
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
