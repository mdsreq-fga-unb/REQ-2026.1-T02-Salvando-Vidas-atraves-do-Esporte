import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/observacao/observacao.dart';

class RegistroFrequenciaItem {
  final DateTime data;
  final int turmaId;
  final String? turmaNome;
  final bool presente;
  final String? voluntarioId;
  final String? voluntarioNome;
  final String? observacao;

  RegistroFrequenciaItem({
    required this.data,
    required this.turmaId,
    this.turmaNome,
    required this.presente,
    this.voluntarioId,
    this.voluntarioNome,
    this.observacao,
  });
}

class HistoricoFrequenciaAlunoData {
  final Aluno aluno;
  final List<RegistroFrequenciaItem> itens;
  final int totalAulas;
  final int totalPresencas;
  final int totalAusencias;
  final double percentualFrequencia;

  HistoricoFrequenciaAlunoData({
    required this.aluno,
    required this.itens,
    required this.totalAulas,
    required this.totalPresencas,
    required this.totalAusencias,
    required this.percentualFrequencia,
  });
}

class SessaoAulaTurmaItem {
  final DateTime data;
  final String? voluntarioNome;
  final String? observacao;
  final int totalPresentes;
  final int totalAusentes;
  final double percentualPresenca;
  final List<Aluno> alunosPresentes;
  final List<Aluno> alunosAusentes;

  SessaoAulaTurmaItem({
    required this.data,
    this.voluntarioNome,
    this.observacao,
    required this.totalPresentes,
    required this.totalAusentes,
    required this.percentualPresenca,
    required this.alunosPresentes,
    required this.alunosAusentes,
  });
}

class ResumoFrequenciaAlunoTurma {
  final Aluno aluno;
  final int totalPresencas;
  final int totalAusencias;
  final double percentual;

  ResumoFrequenciaAlunoTurma({
    required this.aluno,
    required this.totalPresencas,
    required this.totalAusencias,
    required this.percentual,
  });
}

class HistoricoFrequenciaTurmaData {
  final int turmaId;
  final String turmaNome;
  final List<SessaoAulaTurmaItem> sessoes;
  final List<ResumoFrequenciaAlunoTurma> resumosAlunos;
  final double percentualMedioTurma;

  HistoricoFrequenciaTurmaData({
    required this.turmaId,
    required this.turmaNome,
    required this.sessoes,
    required this.resumosAlunos,
    required this.percentualMedioTurma,
  });
}

final historicoFrequenciaAlunoProvider = FutureProvider.autoDispose.family<HistoricoFrequenciaAlunoData, Aluno>((ref, aluno) async {
  final presencaService = ref.watch(presencaServiceProvider);
  final userService = ref.watch(userServiceProvider);
  final turmas = await ref.watch(turmasStoreProvider.future);

  final presencas = await presencaService.listarPresencasPorAluno(aluno.id!);
  final usuarios = await userService.listUsers();

  final Map<String, String> userNames = {
    for (final u in usuarios) if (u.id != null) u.id!: u.nome,
  };
  final Map<int, String> turmasNames = {
    for (final t in turmas) t.id: t.nome,
  };

  String formatData(DateTime d) =>
      '${d.year.toString().padLeft(4, "0")}-${d.month.toString().padLeft(2, "0")}-${d.day.toString().padLeft(2, "0")}';

  final Set<int> turmaIds = {
    if (aluno.idTurma != null) aluno.idTurma!,
    ...presencas.map((p) => p.turmaId),
  };

  final List<Observacao> todasObservacoes = [];
  for (final tid in turmaIds) {
    final obs = await presencaService.listarObservacoesPorTurma(tid);
    todasObservacoes.addAll(obs);
  }

  todasObservacoes.sort((a, b) => b.data.compareTo(a.data));

  final List<RegistroFrequenciaItem> itens = [];
  final Set<String> chavesProcessadas = {};

  for (final obs in todasObservacoes) {
    final dataStr = formatData(obs.data);
    final chave = '${obs.turmaId}_$dataStr';
    chavesProcessadas.add(chave);

    final p = presencas.firstWhereOrNull(
      (pItem) => pItem.turmaId == obs.turmaId && formatData(pItem.data) == dataStr,
    );

    itens.add(RegistroFrequenciaItem(
      data: obs.data,
      turmaId: obs.turmaId,
      turmaNome: turmasNames[obs.turmaId] ?? 'Turma #${obs.turmaId}',
      presente: p != null,
      voluntarioId: obs.voluntario,
      voluntarioNome: userNames[obs.voluntario] ?? 'Voluntário',
      observacao: obs.observacao,
    ));
  }

  for (final p in presencas) {
    final dataStr = formatData(p.data);
    final chave = '${p.turmaId}_$dataStr';
    if (!chavesProcessadas.contains(chave)) {
      itens.add(RegistroFrequenciaItem(
        data: p.data,
        turmaId: p.turmaId,
        turmaNome: turmasNames[p.turmaId] ?? 'Turma #${p.turmaId}',
        presente: true,
        observacao: 'Presença registrada',
      ));
    }
  }

  itens.sort((a, b) => b.data.compareTo(a.data));

  final totalAulas = itens.length;
  final totalPresencas = itens.where((i) => i.presente).length;
  final totalAusencias = totalAulas - totalPresencas;
  final percentual = totalAulas > 0 ? (totalPresencas / totalAulas) * 100 : 0.0;

  return HistoricoFrequenciaAlunoData(
    aluno: aluno,
    itens: itens,
    totalAulas: totalAulas,
    totalPresencas: totalPresencas,
    totalAusencias: totalAusencias,
    percentualFrequencia: percentual,
  );
});

final historicoFrequenciaTurmaProvider = FutureProvider.autoDispose.family<HistoricoFrequenciaTurmaData, int>((ref, turmaId) async {
  final presencaService = ref.watch(presencaServiceProvider);
  final alunoService = ref.watch(alunoServiceProvider);
  final userService = ref.watch(userServiceProvider);
  final turmas = await ref.watch(turmasStoreProvider.future);

  final turma = turmas.firstWhereOrNull((t) => t.id == turmaId);
  final turmaNome = turma?.nome ?? 'Turma #$turmaId';

  final alunos = await alunoService.listarAlunosTurma(turmaId);
  final observacoes = await presencaService.listarObservacoesPorTurma(turmaId);
  final todasPresencas = await presencaService.listarTodasPresencasPorTurma(turmaId);
  final usuarios = await userService.listUsers();

  final Map<String, String> userNames = {
    for (final u in usuarios) if (u.id != null) u.id!: u.nome,
  };

  String formatData(DateTime d) =>
      '${d.year.toString().padLeft(4, "0")}-${d.month.toString().padLeft(2, "0")}-${d.day.toString().padLeft(2, "0")}';

  observacoes.sort((a, b) => b.data.compareTo(a.data));

  final List<SessaoAulaTurmaItem> sessoes = [];

  for (final obs in observacoes) {
    final dataStr = formatData(obs.data);
    final presencasDaData = todasPresencas.where((p) => formatData(p.data) == dataStr).map((p) => p.alunoId).toSet();

    final presentes = alunos.where((a) => presencasDaData.contains(a.id)).toList();
    final ausentes = alunos.where((a) => !presencasDaData.contains(a.id)).toList();

    final totalP = presentes.length;
    final totalA = ausentes.length;
    final total = totalP + totalA;
    final perc = total > 0 ? (totalP / total) * 100 : 0.0;

    sessoes.add(SessaoAulaTurmaItem(
      data: obs.data,
      voluntarioNome: userNames[obs.voluntario] ?? 'Voluntário',
      observacao: obs.observacao,
      totalPresentes: totalP,
      totalAusentes: totalA,
      percentualPresenca: perc,
      alunosPresentes: presentes,
      alunosAusentes: ausentes,
    ));
  }

  final totalSessoes = observacoes.length;
  final List<ResumoFrequenciaAlunoTurma> resumosAlunos = [];

  for (final aluno in alunos) {
    final presencasDoAluno = todasPresencas.where((p) => p.alunoId == aluno.id).length;
    final ausencias = totalSessoes > presencasDoAluno ? totalSessoes - presencasDoAluno : 0;
    final perc = totalSessoes > 0 ? (presencasDoAluno / totalSessoes) * 100 : (presencasDoAluno > 0 ? 100.0 : 0.0);

    resumosAlunos.add(ResumoFrequenciaAlunoTurma(
      aluno: aluno,
      totalPresencas: presencasDoAluno,
      totalAusencias: ausencias,
      percentual: perc,
    ));
  }

  resumosAlunos.sort((a, b) => a.aluno.nomeReferencia.compareTo(b.aluno.nomeReferencia));

  double mediaTurma = 0.0;
  if (resumosAlunos.isNotEmpty) {
    mediaTurma = resumosAlunos.map((r) => r.percentual).average;
  }

  return HistoricoFrequenciaTurmaData(
    turmaId: turmaId,
    turmaNome: turmaNome,
    sessoes: sessoes,
    resumosAlunos: resumosAlunos,
    percentualMedioTurma: mediaTurma,
  );
});
