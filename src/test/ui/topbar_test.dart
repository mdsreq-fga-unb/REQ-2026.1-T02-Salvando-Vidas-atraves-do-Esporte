import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/global/widgets/topbar.dart';

void main() {
  group('TopBar Widget Test', () {
    testWidgets('Deve renderizar a logo e navegar para home ao clicar', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/outra-pagina',
        routes: [
          GoRoute(path: '/outra-pagina', builder: (context, state) => const Scaffold(appBar: TopBar())),
          GoRoute(path: Routes.home, builder: (context, state) => const Scaffold(body: Text('Pagina Home'))),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Pagina Home'), findsNothing);

      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      expect(find.text('Pagina Home'), findsOneWidget);
    });
  });
}