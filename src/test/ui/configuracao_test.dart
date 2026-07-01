import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/configuracao/views/configuracao.dart';

import 'configuracao_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserService>()])
void main() {
  late MockUserService mockUserService;
  const testUser = LocalUser(
    nome: 'Usuário Teste',
    email: 'teste@email.com',
    cpf: '111.111.111-11',
    telefone: '61999999999',
    role: Role.voluntario,
    funcao: 'Voluntário',
    faixa: Faixa.branca,
  );

  // Helper to build the test environment
  Widget createWidgetUnderTest() {
    // Mock the service to return a user
    when(mockUserService.localUser).thenReturn(testUser);
    // Mock the logout method
    when(mockUserService.logout()).thenAnswer((_) async => {});

    final router = GoRouter(
      initialLocation: Routes.configuracao,
      routes: [
        GoRoute(
          path: Routes.configuracao,
          builder: (c, s) => const Configuracao(),
        ),
        GoRoute(
          path: Routes.editarPerfil,
          builder: (c, s) => const Scaffold(body: Text('Pagina Editar Perfil')),
        ),
        GoRoute(
          path: Routes.login,
          builder: (c, s) => const Scaffold(body: Text('Pagina Login')),
        ),
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

  group('Configuracao Page Test', () {
    testWidgets('Deve renderizar todas as informações e opções corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text(testUser.nome), findsOneWidget);
      expect(find.text(testUser.email), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(
        find.widgetWithText(SwitchListTile, 'Modo escuro'),
        findsOneWidget,
      );
      expect(find.widgetWithText(ElevatedButton, 'Deslogar'), findsOneWidget);
    });

    testWidgets(
      'Deve navegar para a página de edição de perfil ao clicar no ícone',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpAndSettle();

        expect(find.text('Pagina Editar Perfil'), findsOneWidget);
      },
    );

    testWidgets('Deve alternar o valor do modo escuro ao clicar no switch', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      final updatedSwitchTile = tester.widget<SwitchListTile>(
        find.byType(SwitchListTile),
      );
      expect(updatedSwitchTile.value, isTrue);
    });

    testWidgets(
      'Deve chamar o método de logout e navegar para a tela de login',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Deslogar'));
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Deslogar').last);
        await tester.pumpAndSettle();

        verify(mockUserService.logout()).called(1);
        expect(find.text('Pagina Login'), findsOneWidget);
      },
    );
  });
}
