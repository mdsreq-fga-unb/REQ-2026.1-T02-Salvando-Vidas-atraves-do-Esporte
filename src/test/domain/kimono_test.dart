import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

void main() {
  group('Kimono Domain Tests', () {
    test('CorKimonoExt nomeVisivel', () {
      expect(CorKimono.azul.nomeVisivel, 'Azul');
      expect(CorKimono.branco.nomeVisivel, 'Branco');
      expect(CorKimono.preto.nomeVisivel, 'Preto');
      expect(CorKimono.rosa.nomeVisivel, 'Rosa');
    });

    test('TamanhoKimonoExt nomeVisivel', () {
      expect(TamanhoKimono.a0.nomeVisivel, 'A0');
      expect(TamanhoKimono.a1.nomeVisivel, 'A1');
      expect(TamanhoKimono.a2.nomeVisivel, 'A2');
      expect(TamanhoKimono.a3.nomeVisivel, 'A3');
      expect(TamanhoKimono.a4.nomeVisivel, 'A4');
      expect(TamanhoKimono.a5.nomeVisivel, 'A5');
    });

    test('Doacao serialization and properties', () {
      final now = DateTime(2026, 1, 1);
      final doacao = Doacao(
        id: 1,
        doador: 'João',
        cor: CorKimono.azul,
        tamanho: TamanhoKimono.a1,
        quantidade: 2,
        data: now,
      );

      final map = doacao.toMap();
      final fromMap = Doacao.fromMap(map);
      expect(fromMap.doador, 'João');
      expect(fromMap.cor, CorKimono.azul);
      expect(fromMap.tamanho, TamanhoKimono.a1);
      expect(fromMap.quantidade, 2);

      final json = doacao.toJson();
      final fromJson = Doacao.fromJson(json);
      expect(fromJson.doador, 'João');
    });

    test('Perda serialization and properties', () {
      final now = DateTime(2026, 1, 1);
      final perda = Perda(
        id: 1,
        cor: CorKimono.branco,
        tamanho: TamanhoKimono.a2,
        quantidade: 1,
        motivo: 'Rasgado',
        data: now,
      );

      final map = perda.toMap();
      final fromMap = Perda.fromMap(map);
      expect(fromMap.motivo, 'Rasgado');
      expect(fromMap.cor, CorKimono.branco);

      final json = perda.toJson();
      final fromJson = Perda.fromJson(json);
      expect(fromJson.motivo, 'Rasgado');
    });

    test('Emprestimo serialization and properties', () {
      final now = DateTime(2026, 1, 1);
      final emprestimo = Emprestimo(
        id: 1,
        alunoId: 10,
        cor: CorKimono.preto,
        tamanho: TamanhoKimono.a3,
        data: now,
        dataDevolucao: now.add(const Duration(days: 7)),
      );

      final map = emprestimo.toMap();
      final fromMap = Emprestimo.fromMap(map);
      expect(fromMap.alunoId, 10);
      expect(fromMap.dataDevolucao, isNotNull);

      final json = emprestimo.toJson();
      final fromJson = Emprestimo.fromJson(json);
      expect(fromJson.alunoId, 10);
    });

    test('Estoque serialization and properties', () {
      final estoque = Estoque(
        cor: CorKimono.rosa,
        tamanho: TamanhoKimono.a0,
        quantidadeDisponivel: 5,
      );

      final map = estoque.toMap();
      final fromMap = Estoque.fromMap(map);
      expect(fromMap.quantidadeDisponivel, 5);

      final json = estoque.toJson();
      final fromJson = Estoque.fromJson(json);
      expect(fromJson.quantidadeDisponivel, 5);
    });
  });
}
