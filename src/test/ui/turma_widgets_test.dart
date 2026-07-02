import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/turma/widgets/aluno_tile_card.dart';
import 'package:salvando_vidas/ui/turma/widgets/turma_card_widget.dart';
import 'package:salvando_vidas/ui/turma/widgets/turma_options_menu_widget.dart';

void main() {
  group('Turma Widgets Tests', () {
    final turma = Turma(
      id: 1,
      nome: 'Jiu Jitsu Kids',
      descricao: 'Turma infantil',
      faixaEtaria: FaixaEtaria.infantil,
      horarioInicio: DateTime(2026, 1, 1, 10, 0),
      horarioFim: DateTime(2026, 1, 1, 11, 30),
      ativo: true,
      eSegunda: true,
      eTerca: false,
      eQuarta: true,
      eQuinta: false,
      eSexta: false,
      eSabado: false,
      eDomingo: false,
      qtdAlunos: 15,
    );

    Widget createTestApp(Widget child, {ThemeMode mode = ThemeMode.light}) {
      return ProviderScope(
        child: MaterialApp(
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: Center(child: child),
          ),
        ),
      );
    }

    testWidgets('TurmaCardWidget renderiza dados da turma e responde a clique (Light & Dark)', (tester) async {
      var clicado = false;
      await tester.pumpWidget(createTestApp(
        TurmaCardWidget(
          turma: turma,
          onTap: () => clicado = true,
        ),
      ));

      expect(find.text('Jiu Jitsu Kids'), findsOneWidget);
      expect(find.text('15 alunos'), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      expect(clicado, isTrue);

      // Dark theme test
      await tester.pumpWidget(createTestApp(
        TurmaCardWidget(turma: turma),
        mode: ThemeMode.dark,
      ));
      expect(find.text('Jiu Jitsu Kids'), findsOneWidget);
    });

    testWidgets('AlunoTileWidget renderiza nome, botão remover e responde a cliques (Light & Dark)', (tester) async {
      var removido = false;
      var clicado = false;

      await tester.pumpWidget(createTestApp(
        AlunoTileWidget(
          nome: 'Lucas Silva',
          onRemover: () => removido = true,
          onTap: () => clicado = true,
        ),
      ));

      expect(find.text('Lucas Silva'), findsOneWidget);
      expect(find.text('Remover'), findsOneWidget);

      await tester.tap(find.text('Remover'));
      expect(removido, isTrue);

      await tester.tap(find.byType(ListTile));
      expect(clicado, isTrue);

      // Sem botão remover no modo escuro
      await tester.pumpWidget(createTestApp(
        const AlunoTileWidget(nome: 'Pedro'),
        mode: ThemeMode.dark,
      ));
      expect(find.text('Pedro'), findsOneWidget);
      expect(find.text('Remover'), findsNothing);
    });

    testWidgets('TurmaOptionsMenuWidget abre o menu de opções e exibe item (Light & Dark)', (tester) async {
      await tester.pumpWidget(createTestApp(
        const TurmaOptionsMenuWidget(turmaId: 1),
      ));

      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(find.text('Histórico de Frequência'), findsOneWidget);

      // Dark mode test
      await tester.pumpWidget(createTestApp(
        const TurmaOptionsMenuWidget(turmaId: 1),
        mode: ThemeMode.dark,
      ));
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      expect(find.text('Histórico de Frequência'), findsOneWidget);
    });
  });
}
