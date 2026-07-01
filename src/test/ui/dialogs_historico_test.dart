import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/stores/emprestimo/historico_emprestimos_store.dart';
import 'package:salvando_vidas/data/stores/presenca/historico_frequencia_provider.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/ui/emprestimo/widgets/detalhes_item_historico_dialog.dart';
import 'package:salvando_vidas/ui/emprestimo/widgets/historico_emprestimo_aluno_dialog.dart';
import 'package:salvando_vidas/ui/turma/widgets/historico_frequencia_aluno_dialog.dart';

class FakeHistoricoEmprestimosStore extends HistoricoEmprestimosStore {
  final HistoricoEmprestimosState fakeState;
  FakeHistoricoEmprestimosStore(this.fakeState);

  @override
  Future<HistoricoEmprestimosState> build() async => fakeState;
}

void main() {
  group('Dialogs Historico Tests', () {
    final aluno = Aluno(
      id: 1,
      nome: 'Carlos Eduardo',
      cpf: '52998224725',
      nascimento: DateTime(2012, 5, 10),
      email: 'carlos@teste.com',
      faixa: Faixa.branca,
      grau: 1,
      tipoSanguineo: TipoSanguineo.aPositivo,
      dataEntrada: DateTime(2025, 1, 1),
      ativo: true,
      federado: false,
      idTurma: 1,
    );

    final emprestimo = Emprestimo(
      id: 10,
      alunoId: 1,
      data: DateTime(2026, 2, 1, 14, 30),
      tamanho: TamanhoKimono.a1,
      cor: CorKimono.azul,
    );

    final voluntario = LocalUser(
      id: 'vol-1',
      nome: 'Voluntário 1',
      email: 'vol@teste.com',
      telefone: '11999999999',
      faixa: Faixa.branca,
      role: Role.voluntario,
    );

    final itemEmprestimo = HistoricoItem(
      emprestimo: emprestimo,
      aluno: aluno,
      voluntario: voluntario,
    );

    Widget createTestApp(Widget child, {List<dynamic> overrides = const [], ThemeMode mode = ThemeMode.light}) {
      return ProviderScope(
        overrides: overrides.cast(),
        child: MaterialApp(
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(body: Center(child: child)),
        ),
      );
    }

    testWidgets('mostrarDetalhesItemHistoricoDialog em modo Light', (tester) async {
      await tester.pumpWidget(createTestApp(
        Builder(
          builder: (ctx) => ElevatedButton(
            onPressed: () => mostrarDetalhesItemHistoricoDialog(ctx, itemEmprestimo),
            child: const Text('Abrir Detalhes'),
          ),
        ),
      ));

      await tester.tap(find.text('Abrir Detalhes'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Carlos Eduardo'), findsWidgets);
      expect(find.textContaining('Empréstimo em Aberto'), findsWidgets);
    });

    testWidgets('mostrarDetalhesItemHistoricoDialog em modo Dark', (tester) async {
      await tester.pumpWidget(createTestApp(
        Builder(
          builder: (ctx) => ElevatedButton(
            onPressed: () => mostrarDetalhesItemHistoricoDialog(ctx, itemEmprestimo),
            child: const Text('Abrir Detalhes Dark'),
          ),
        ),
        mode: ThemeMode.dark,
      ));

      await tester.tap(find.text('Abrir Detalhes Dark'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Carlos Eduardo'), findsWidgets);
    });

    testWidgets('mostrarHistoricoFrequenciaAlunoDialog em modo Light', (tester) async {
      final regItem = RegistroFrequenciaItem(
        data: DateTime(2026, 3, 1),
        turmaId: 1,
        turmaNome: 'Turma A',
        presente: true,
      );

      final historicoData = HistoricoFrequenciaAlunoData(
        aluno: aluno,
        itens: [regItem],
        totalAulas: 1,
        totalPresencas: 1,
        totalAusencias: 0,
        percentualFrequencia: 100.0,
      );

      await tester.pumpWidget(createTestApp(
        Builder(
          builder: (ctx) => ElevatedButton(
            onPressed: () => mostrarHistoricoFrequenciaAlunoDialog(ctx, aluno),
            child: const Text('Abrir Frequencia'),
          ),
        ),
        overrides: [
          historicoFrequenciaAlunoProvider(aluno).overrideWith((ref) async => historicoData),
        ],
      ));

      await tester.tap(find.text('Abrir Frequencia'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Carlos Eduardo'), findsWidgets);
    });

    testWidgets('mostrarHistoricoFrequenciaAlunoDialog em modo Dark', (tester) async {
      final regItem = RegistroFrequenciaItem(
        data: DateTime(2026, 3, 1),
        turmaId: 1,
        turmaNome: 'Turma A',
        presente: true,
      );

      final historicoData = HistoricoFrequenciaAlunoData(
        aluno: aluno,
        itens: [regItem],
        totalAulas: 1,
        totalPresencas: 1,
        totalAusencias: 0,
        percentualFrequencia: 100.0,
      );

      await tester.pumpWidget(createTestApp(
        Builder(
          builder: (ctx) => ElevatedButton(
            onPressed: () => mostrarHistoricoFrequenciaAlunoDialog(ctx, aluno),
            child: const Text('Abrir Frequencia Dark'),
          ),
        ),
        overrides: [
          historicoFrequenciaAlunoProvider(aluno).overrideWith((ref) async => historicoData),
        ],
        mode: ThemeMode.dark,
      ));

      await tester.tap(find.text('Abrir Frequencia Dark'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Carlos Eduardo'), findsWidgets);
    });

    testWidgets('mostrarHistoricoEmprestimoAlunoDialog exibe empréstimos do aluno (Light & Dark)', (tester) async {
      final state = HistoricoEmprestimosState(
        itens: [itemEmprestimo],
        itensFiltrados: [itemEmprestimo],
      );

      await tester.pumpWidget(createTestApp(
        Builder(
          builder: (ctx) => ElevatedButton(
            onPressed: () => mostrarHistoricoEmprestimoAlunoDialog(ctx, aluno),
            child: const Text('Abrir Historico Emprestimos'),
          ),
        ),
        overrides: [
          historicoEmprestimosStoreProvider.overrideWith(() => FakeHistoricoEmprestimosStore(state)),
        ],
      ));

      await tester.tap(find.text('Abrir Historico Emprestimos'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Carlos Eduardo'), findsWidgets);
    });
  });
}
