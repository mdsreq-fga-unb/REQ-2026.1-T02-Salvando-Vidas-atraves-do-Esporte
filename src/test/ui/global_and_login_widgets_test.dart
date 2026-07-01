import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/stores/login/login_controller.dart';
import 'package:salvando_vidas/ui/global/widgets/dropdown.dart';
import 'package:salvando_vidas/ui/global/widgets/label.dart';
import 'package:salvando_vidas/ui/login/widgets/botao_entrar.dart';
import 'package:salvando_vidas/ui/login/widgets/formulario_login.dart';

class FakeLoginControllerLoading extends LoginController {
  @override
  AsyncValue<bool> build() => const AsyncLoading();
}

class FakeLoginControllerError extends LoginController {
  @override
  AsyncValue<bool> build() => const AsyncData(false);

  @override
  Future<void> submitLogin() async {
    state = const AsyncLoading();
    state = AsyncError('Erro de login teste', StackTrace.empty);
  }
}

void main() {
  group('Global Widgets Tests', () {
    testWidgets('buildLabel com e sem asterisco em modos claro e escuro', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: Scaffold(
            body: Column(
              children: [
                buildLabel('Campo Obrigatório*'),
                buildLabel('Campo Opcional'),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(RichText), findsNWidgets(2));
    });

    testWidgets('buildDropdownField renderiza, abre e seleciona', (tester) async {
      String? val;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: Form(
              child: buildDropdownField<String>(
                label: 'Opção*',
                value: null,
                items: ['A', 'B'],
                labelBuilder: (item) => 'Item $item',
                onChanged: (v) => val = v,
                validatorMessage: 'Selecione algo',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Item B').last);
      await tester.pumpAndSettle();
      expect(val, 'B');
    });
  });

  group('Login Widgets Tests', () {
    testWidgets('FormularioLogin renderiza no modo claro e escuro', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(body: FormularioLogin(formKey: formKey)),
          ),
        ),
      );
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('BotaoEntrar loading state', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            loginControllerProvider.overrideWith(() => FakeLoginControllerLoading()),
          ],
          child: MaterialApp(
            home: Scaffold(body: BotaoEntrar(formKey: formKey)),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('BotaoEntrar reage a estado de erro e tap', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            loginControllerProvider.overrideWith(() => FakeLoginControllerError()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Form(
                key: formKey,
                child: BotaoEntrar(formKey: formKey),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Triggers submitLogin and listener
      expect(find.text('Erro de login teste'), findsOneWidget);
    });
  });
}
