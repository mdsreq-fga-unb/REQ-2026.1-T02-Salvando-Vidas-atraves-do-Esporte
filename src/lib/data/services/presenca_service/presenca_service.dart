import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/observacao/observacao.dart';
import 'package:salvando_vidas/domain/presenca/presenca.dart';

part 'presenca_service.g.dart';

@Riverpod(keepAlive: true)
PresencaService presencaService(Ref ref) {
  return PresencaService(ref.watch(supabaseClientProvider));
}

String formatData(DateTime data) {
  return '${data.year.toString().padLeft(4, "0")}-${data.month.toString().padLeft(2, "0")}-${data.day.toString().padLeft(2, "0")}';
}

class PresencaService {
  final SupabaseClient _supabase;

  PresencaService(this._supabase);

  Future<List<Presenca>> listarPresencas(int idTurma, DateTime data) {
    return runSupabaseCall(() async {
      final res = await _supabase
          .from('presencas')
          .select()
          .eq('turma_id', idTurma)
          .eq('data', {formatData(data)});

      return res.map((data) => Presenca.fromMap(data)).toList();
    });
  }

  Future<Observacao?> obterObservacao(int idTurma, DateTime data) {
    return runSupabaseCall(() async {
      final res = await _supabase
          .from('observacoes')
          .select()
          .eq('turma_id', idTurma)
          .eq('data', {formatData(data)});
      if (res.isEmpty) return null;

      return Observacao.fromMap(res.first);
    });
  }

  Future<void> cadastrarPresenca(
    int turma,
    DateTime data,
    String voluntario,
    String observacao,
    List<int> alunos,
  ) {
    return runSupabaseCall(() async {
      await _supabase.rpc(
        'registrar_aula_completa',
        params: {
          'p_turma_id': turma,
          'p_data': formatData(data),
          'p_voluntario': voluntario,
          'p_observacao': observacao,
          'p_alunos_presentes': alunos,
        },
      );
    });
  }

  Future<List<UltimaPresenca>> obterUltimasPresencas() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('dashboard_ultimas_presencas').select();
      return res.map((data) => UltimaPresenca.fromMap(data)).toList();
    });
  }

  Future<List<Presenca>> listarPresencasPorAluno(int alunoId) {
    return runSupabaseCall(() async {
      final res = await _supabase
          .from('presencas')
          .select()
          .eq('aluno_id', alunoId);
      return res.map((data) => Presenca.fromMap(data)).toList();
    });
  }

  Future<List<Observacao>> listarObservacoesPorTurma(int idTurma) {
    return runSupabaseCall(() async {
      final res = await _supabase
          .from('observacoes')
          .select()
          .eq('turma_id', idTurma);
      return res.map((data) => Observacao.fromMap(data)).toList();
    });
  }

  Future<List<Presenca>> listarTodasPresencasPorTurma(int idTurma) {
    return runSupabaseCall(() async {
      final res = await _supabase
          .from('presencas')
          .select()
          .eq('turma_id', idTurma);
      return res.map((data) => Presenca.fromMap(data)).toList();
    });
  }
}


