import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

import '../../supabase_call.dart';
import '../global/global_service.dart';

part 'kimono_service.g.dart';

@Riverpod(keepAlive: true)
KimonoService kimonoService(Ref ref) {
  return KimonoService(ref.watch(supabaseClientProvider));
}

class KimonoService {
  final SupabaseClient _supabase;

  KimonoService(this._supabase);

  Future<Doacao> cadastrarDoacao(Doacao doacao) {
    return runSupabaseCall(() async {
      final data = doacao.toMap();
      data.remove('id');

      final res = await _supabase.from('doacoes').insert(data).select();

      return Doacao.fromMap(res.first);
    });
  }

  Future<Perda> cadastrarPerda(Perda perda) {
    return runSupabaseCall(() async {
      final data = perda.toMap();
      data.remove('id');

      final res = await _supabase.from('perdas').insert(data).select();

      return Perda.fromMap(res.first);
    });
  }

  Future<Emprestimo> cadastrarEmprestimo(Emprestimo emprestimo) {
    return runSupabaseCall(() async {
      final data = emprestimo.toMap();
      data.remove('id');

      final res = await _supabase.from('emprestimos').insert(data).select();

      return Emprestimo.fromMap(res.first);
    });
  }

  Future<List<Doacao>> listarDoacoes() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('doacoes').select();
      return res.map((data) => Doacao.fromMap(data)).toList();
    });
  }

  Future<List<Perda>> listarPerdas() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('perdas').select();
      return res.map((data) => Perda.fromMap(data)).toList();
    });
  }

  Future<List<Emprestimo>> listarEmprestimos() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('emprestimos').select();
      return res.map((data) => Emprestimo.fromMap(data)).toList();
    });
  }

  Future<List<Estoque>> obterEstoque() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('estoque_kimonos').select();
      return res.map((data) => Estoque.fromMap(data)).toList();
    });
  }

  Future<void> retornarEmprestimo(Emprestimo emprestimo) {
    return runSupabaseCall(() async {
      final hoje = DateTime.now();
      final diaDevolucao =
          "${hoje.year.toString().padLeft(4, '0')}-${hoje.month.toString().padLeft(2, '0')}-${hoje.day.toString().padLeft(2, '0')}";

      await _supabase
          .from('emprestimos')
          .update({'data_devolucao': diaDevolucao})
          .eq('id', emprestimo.id!);
    });
  }
}
