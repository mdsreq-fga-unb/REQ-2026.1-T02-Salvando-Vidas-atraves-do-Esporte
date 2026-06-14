import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/ui/login/widgets/formulario_login.dart';

void main() {
  testWidgets('Deve permitir que o usuario digite nos campos', (WidgetTester tester) async {
    // 1. Força um tamanho de tela onde tudo cabe
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    // 2. Envolve em um ProviderScope (mesmo se não usar Riverpod direto aqui, é boa prática)
    // Envolve também em MediaQuery e Localizations, que o TextField precisa para funcionar
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: FormularioLogin()),
          ),
        ),
      ),
    );
    
    await tester.pumpAndSettle();

    // 3. Em vez de usar .at(0) ou .at(1) que é instável, 
    // buscamos o tipo do campo de texto (que deve ser o seu EmailTextField/SenhaTextField)
    final textFields = find.byType(TextField);
    
    // Testa se achamos os campos
    expect(textFields, findsNWidgets(2));

    // 4. Digita com segurança
    await tester.enterText(textFields.at(0), 'teste@email.com');
    await tester.pumpAndSettle();
    
    await tester.enterText(textFields.at(1), 'senha123');
    await tester.pumpAndSettle();

    // 5. Verifica se o texto está presente
    expect(find.text('teste@email.com'), findsOneWidget);
    
    tester.binding.window.clearPhysicalSizeTestValue();
  });
}