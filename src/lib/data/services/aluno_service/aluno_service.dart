import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/helpers.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';

import '../../supabase_call.dart';
import '../global/global_service.dart';

part 'aluno_service.g.dart';

@riverpod
AlunoService alunoService(AlunoServiceRef ref) {
  return AlunoService(ref.watch(supabaseClientProvider));
}

class AlunoService {
  final SupabaseClient _supabase;

  AlunoService(this._supabase);

  Future<Aluno?> cadastrarAluno(Aluno aluno) {
    return runSupabaseCall(() async {
      final data = await _supabase
          .from('alunos')
          .insert(aluno.toMap())
          .select();

      return data.isNotEmpty ? aluno : null;
    });
  }

  Future<Responsavel?> cadastrarResponsavel(Responsavel responsavel) {
    return runSupabaseCall(() async {
      final data = await _supabase
          .from('responsaveis')
          .insert(responsavel.toMap())
          .select();

      return data.isNotEmpty ? responsavel : null;
    });
  }

  Future<List<Aluno>> listarAlunos() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('alunos').select();
      return res.map((data) => Aluno.fromMap(data)).toList();
    });
  }

  Future<List<Responsavel>> listarResponsaveis() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('responsaveis').select();
      return res.map((data) => Responsavel.fromMap(data)).toList();
    });
  }

  Future<void> atualizaAluno(BigInt id, Data diff) {
    return runSupabaseCall(() async {
      await _supabase.from('alunos').update(diff).eq('id', id);
    });
  }

  Future<void> atualizaResponsavel(BigInt id, Data diff) {
    return runSupabaseCall(() async {
      await _supabase.from('responsaveis').update(diff).eq('id', id);
    });
  }

  Future<void> deletaAluno(BigInt id) {
    return runSupabaseCall(() async {
      await _supabase.from('alunos').delete().eq('id', id);
    });
  }

  Future<void> deletaResponsavel(BigInt id) {
    return runSupabaseCall(() async {
      await _supabase.from('responsaveis').delete().eq('id', id);
    });
  }
}
