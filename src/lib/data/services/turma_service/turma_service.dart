import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';

import '../../supabase_call.dart';
import '../global/global_service.dart';

part 'turma_service.g.dart';

@Riverpod(keepAlive: true)
TurmaService turmaService(Ref ref) {
  return TurmaService(ref.watch(supabaseClientProvider));
}

class TurmaService {
  final SupabaseClient _supabase;

  TurmaService(this._supabase);

  Future<List<Turma>> listarTurmas() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('turmas').select();
      final turmas = res.map((data) => Turma.fromMap(data)).toList();
      for (final turma in turmas) {
        turma.qtdAlunos = await contarAlunos(turma.id);
      }
      return turmas;
    });
  }

  Future<int> contarAlunos(int id) {
    return runSupabaseCall(() async {
      final res = await _supabase
          .from('alunos')
          .select()
          .eq('id_turma', id)
          .eq('ativo', true)
          .count();
      return res.count;
    });
  }

  Future<void> atualizaTurma(int id, Map<String, dynamic> diff) {
    return runSupabaseCall(() async {
      await _supabase.from('turmas').update(diff).eq('id', id);
    });
  }
}
