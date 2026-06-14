import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/global/widgets/topbar.dart';

void main() {
  group('TopBar Widget Test', () {
    testWidgets('Deve renderizar a logo e navegar para home ao clicar', (WidgetTester tester) async {
      // Configura um router simples para o teste
      final router = GoRouter(
        initialLocation: '/outra-pagina',
        routes: [
          GoRoute(path: '/outra-pagina', builder: (context, state) => const Scaffold(appBar: TopBar())),
          GoRoute(path: Routes.home, builder: (context, state) => const Scaffold(body: Text('Pagina Home'))),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // Verifica se a logo está presente e se não estamos na home ainda
      expect(find.text('Logo'), findsOneWidget);
      expect(find.text('Pagina Home'), findsNothing);

      // Simula o clique no GestureDetector que envolve a logo
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle(); // Espera a transição de navegação

      // Verifica se a navegação para a home ocorreu
      expect(find.text('Pagina Home'), findsOneWidget);
    });
  });
}