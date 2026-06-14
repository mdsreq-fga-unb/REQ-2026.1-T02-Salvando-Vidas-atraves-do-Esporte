import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';

void main() {
  group('Caixa Preta - LoginPage', () {
    testWidgets('Deve renderizar os componentes principais da pagina de login', (WidgetTester tester) async {
      // 1. SETUP: Envolve em ProviderScope e MaterialApp para garantir contexto completo
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Aguarda o carregamento da árvore de widgets
      await tester.pumpAndSettle();

      // 2. OUTPUT ESPERADO: Verifica se os componentes chave estão na tela
      // Verificamos pelo tipo ou por elementos que sabemos existir neles
      expect(find.byType(LoginPage), findsOneWidget);
      
      // Verifica se o formulário foi carregado (deve conter o texto 'Login' dentro dele)
      expect(find.text('Login'), findsOneWidget);
      
      // Verifica se o Botão Entrar está presente
      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets('Deve permitir interacao com o fluxo de login', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();

      // INPUT: Simula o preenchimento e clique no botão
      // Como a LoginPage contém o FormularioLogin, buscamos os campos por tipo
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), 'email@teste.com');
      await tester.enterText(textFields.at(1), 'senha123');
      
      // Tenta clicar no botão 'Entrar'
      await tester.tap(find.text('Entrar'));
      await tester.pump();
      
      // OUTPUT: Se não houver erro de exceção durante o tap, o teste segue.
      // Aqui você poderia verificar navegação se tivesse rotas configuradas.
      expect(find.text('email@teste.com'), findsOneWidget);
    });
  });
}