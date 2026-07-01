import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';
import '../mocks/local_mocks.mocks.dart';

void main() {
  group('Caixa Preta - LoginPage', () {
    testWidgets('Deve renderizar os componentes principais da pagina de login', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2400);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets('Deve permitir interacao com o fluxo de login', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2400);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final mockUserService = MockUserService();
      when(mockUserService.login(any, any)).thenAnswer((_) async => true);

      final router = GoRouter(
        initialLocation: Routes.login,
        routes: [
          GoRoute(path: Routes.login, builder: (c, s) => LoginPage()),
          GoRoute(path: Routes.home, builder: (c, s) => const Scaffold(body: Text('Pagina Home'))),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userServiceProvider.overrideWithValue(mockUserService),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), 'email@teste.com');
      await tester.enterText(textFields.at(1), 'senha123');
      
      await tester.ensureVisible(find.text('Entrar'));
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();
      
      expect(find.text('Pagina Home'), findsOneWidget);
    });
  });
}