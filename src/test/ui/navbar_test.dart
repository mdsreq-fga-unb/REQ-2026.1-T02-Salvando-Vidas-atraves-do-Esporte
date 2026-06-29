import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/global/widgets/navbar.dart';

import 'navbar_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserService>()])
void main() {
  late MockUserService mockUserService;

  Widget createWidgetUnderTest(String initialLocation) {
    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: Routes.home, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Home'))),
        GoRoute(path: Routes.buscaAluno, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Busca'))),
        GoRoute(path: Routes.turma, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Turma'))),
        GoRoute(path: Routes.inventario, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Inventario'))),
        GoRoute(path: Routes.configuracao, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Config'))),
      ],
    );

    return ProviderScope(
      overrides: [userServiceProvider.overrideWithValue(mockUserService)],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  setUp(() {
    mockUserService = MockUserService();
  });

  group('NavBar Widget Test', () {
    testWidgets('Deve renderizar os 5 itens de navegação', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(Routes.home));
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);
      expect(find.byIcon(Icons.inventory), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('Deve navegar para a tela de busca ao clicar no ícone de pesquisa', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(Routes.home));

      expect(find.text('Busca'), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.text('Busca'), findsOneWidget);
    });

    testWidgets('Deve navegar para a tela de configurações ao clicar no ícone de config', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(Routes.home));

      expect(find.text('Config'), findsNothing);

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.text('Config'), findsOneWidget);
    });
  });
}