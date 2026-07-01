import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/ui/login/widgets/text_fields.dart';
import 'package:salvando_vidas/ui/login/login_imports.dart';

void main() {
  group('Caixa Preta - TextFields Login', () {
    testWidgets('EmailTextField deve disparar o updateEmail ao digitar', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: EmailTextField())),
        ),
      );

      final finder = find.byType(TextFormField);
      await tester.enterText(finder, 'giovani@teste.com');
      await tester.pump();

      expect(find.text('giovani@teste.com'), findsOneWidget);
    });

    testWidgets('SenhaTextField deve alternar visibilidade ao clicar no olho', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: Scaffold(body: SenhaTextField())),
        ),
      );

      final senhaField = find.byType(TextFormField);
      await tester.enterText(senhaField, 'minhasenha123');
      await tester.pump();

      // 1. Deve começar oculto (obscureText = true)
      TextField campo = tester.widget(find.byType(TextField));
      expect(campo.obscureText, isTrue);

      // 2. Toca no ícone de visibilidade (IconButton)
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      // 3. Agora deve estar visível (obscureText = false)
      campo = tester.widget(find.byType(TextField));
      expect(campo.obscureText, isFalse);
    });
  });
}