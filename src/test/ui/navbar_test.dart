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

  // Helper para criar o ambiente de teste com router e provider
  Widget createWidgetUnderTest(String initialLocation, {bool isAdmin = false}) {
    when(mockUserService.isAdmin).thenReturn(isAdmin);

    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: Routes.home, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Home'))),
        GoRoute(path: Routes.buscaAluno, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Busca'))),
        GoRoute(path: Routes.turma, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Turma'))),
        GoRoute(path: Routes.configuracao, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Config'))),
        GoRoute(path: Routes.admin, builder: (c, s) => const Scaffold(bottomNavigationBar: NavBar(), body: Text('Admin'))),
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
    testWidgets('Deve renderizar 4 itens para usuário normal', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(Routes.home, isAdmin: false));
      expect(find.byType(NavigationDestination), findsNWidgets(4));
      expect(find.byIcon(Icons.people), findsNothing);
    });

    testWidgets('Deve renderizar 5 itens para admin', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(Routes.home, isAdmin: true));
      expect(find.byType(NavigationDestination), findsNWidgets(5));
      expect(find.byIcon(Icons.people), findsOneWidget);
    });

    testWidgets('Deve navegar para a tela de busca ao clicar no ícone de pesquisa', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(Routes.home));

      expect(find.text('Busca'), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.text('Busca'), findsOneWidget);
    });

    testWidgets('Deve manter o item de configuração selecionado na tela de configuração', (WidgetTester tester) async {
      // Inicia na rota de configuração
      await tester.pumpWidget(createWidgetUnderTest(Routes.configuracao));

      // A NavBar usa o GoRouterState para determinar o índice.
      // O teste verifica se o índice correto foi selecionado.
      final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(navBar.selectedIndex, 3);
    });
  });
}