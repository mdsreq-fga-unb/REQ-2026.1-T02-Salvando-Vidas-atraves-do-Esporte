import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/pesquisa_alunos_page.dart';

void main() {
  group('Caixa Preta - PesquisaAlunosPage', () {
    testWidgets('Deve filtrar a lista de alunos corretamente ao digitar', (WidgetTester tester) async {
      // 1. SETUP: Monta a tela dentro de um MaterialApp para simular o app rodando
      await tester.pumpWidget(const MaterialApp(
        home: PesquisaAlunosPage(),
      ));
      
      // Aguarda as animações iniciais terminarem
      await tester.pumpAndSettle();

      // VERIFICAÇÃO INICIAL (Output): A lista deve começar mostrando todos os alunos do Mock
      expect(find.text('Pedro Ramos Sousa Reis'), findsOneWidget);
      expect(find.text('Lucas Silva'), findsOneWidget);

      // 2. INPUT: Simula o usuário digitando "Pedro" no campo de pesquisa
      final barraPesquisa = find.byType(TextField);
      await tester.enterText(barraPesquisa, 'Pedro');
      
      // Aguarda a tela se reconstruir (setState)
      await tester.pumpAndSettle();

      // 3. OUTPUT ESPERADO: Deve encontrar o Pedro, mas o Lucas deve sumir da tela
      expect(find.text('Pedro Ramos Sousa Reis'), findsOneWidget);
      expect(find.text('Lucas Silva'), findsNothing);

      // 4. INPUT 2: Simula o usuário apagando o texto
      await tester.enterText(barraPesquisa, '');
      await tester.pumpAndSettle();

      // 5. OUTPUT ESPERADO 2: O Lucas deve aparecer novamente
      expect(find.text('Pedro Ramos Sousa Reis'), findsOneWidget);
      expect(find.text('Lucas Silva'), findsOneWidget);
    });

    testWidgets('Deve mostrar mensagem de erro quando aluno não existir', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PesquisaAlunosPage(),
      ));
      await tester.pumpAndSettle();

      // INPUT: Digita um nome que não existe no mock
      final barraPesquisa = find.byType(TextField);
      await tester.enterText(barraPesquisa, 'NomeQueNaoExiste');
      await tester.pumpAndSettle();

      // OUTPUT: Deve sumir todo mundo e mostrar a mensagem de fallback
      expect(find.text('Pedro Ramos Sousa Reis'), findsNothing);
      expect(find.text('Lucas Silva'), findsNothing);
      expect(find.text('Nenhum aluno encontrado.'), findsOneWidget);
    });
  });
}