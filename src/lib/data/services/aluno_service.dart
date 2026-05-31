import '../supabase_call.dart';

import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';

class AlunoService {
  final SupabaseClient _supabase;

  AlunoService(this._supabase);

  Future<Result<Aluno?>> cadastrarAluno(Aluno aluno) {
    return safeSupabaseCall(() async {
      final data = await _supabase
          .from('alunos')
          .insert(aluno.toJson())
          .select();

      return data.isNotEmpty ? aluno : null;
    });
  }

  Future<Result<Responsavel?>> cadastrarResponsavel(Responsavel responsavel) {
    return safeSupabaseCall(() async {
      final data = await _supabase
          .from('alunos')
          .insert(responsavel.toJson())
          .select();

      return data.isNotEmpty ? responsavel : null;
    });
  }

  Future<Result<List<Aluno>>> listarAlunos() {
    return safeSupabaseCall(() async {
      final res = await _supabase.from('alunos').select();

      final alunos = List<Aluno>.empty(growable: true);

      for (final data in res) {
        final aluno = Aluno.fromJson(data);
        alunos.add(aluno);
      }

      return alunos;
    });
  }

  Future<Result<List<Responsavel>>> listarResponsaveis() {
    return safeSupabaseCall(() async {
      final res = await _supabase.from('responsaveis').select();

      final responsaveis = List<Responsavel>.empty(growable: true);

      for (final data in res) {
        final responsavel = Responsavel.fromJson(data);
        responsaveis.add(responsavel);
      }

      return responsaveis;
    });
  }
}
