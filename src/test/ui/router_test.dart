import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/ui/global/widgets/navbar.dart';
import 'package:salvando_vidas/ui/global/widgets/topbar.dart';
import 'package:salvando_vidas/routing/router.dart';
import 'package:mockito/annotations.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';

import 'router_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserService>()])
void main() {
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
    // Mock the isAdmin getter to return a default value for the tests
    when(mockUserService.isAdmin).thenReturn(false);
  });

  group('MainScaffold Widget Test', () {
    // Helper to create the test environment with GoRouter
    Widget createWidgetUnderTest() {
      final router = GoRouter(
        initialLocation: '/test',
        routes: [
          ShellRoute(
            builder: (context, state, child) => MainScaffold(child: child),
            routes: [
              GoRoute(path: '/test', builder: (context, state) => const Text('Test Child')),
            ],
          ),
        ],
      );
      return ProviderScope(
        overrides: [userServiceProvider.overrideWithValue(mockUserService)],
        child: MaterialApp.router(routerConfig: router),
      );
    }

    testWidgets('Deve mostrar TopBar e NavBar quando o teclado está fechado', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TopBar), findsOneWidget);
      expect(find.byType(NavBar), findsOneWidget);
    });

    testWidgets('Deve esconder a NavBar quando o teclado está aberto', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simula o teclado abrindo
      final TestWidgetsFlutterBinding binding = tester.binding;
      binding.window.viewInsetsTestValue = const FakeViewPadding(bottom: 300);
      await tester.pump();

      expect(find.byType(TopBar), findsOneWidget);
      expect(find.byType(NavBar), findsNothing);

      // Simula o teclado fechando
      binding.window.viewInsetsTestValue = const FakeViewPadding();
      await tester.pump();

      expect(find.byType(NavBar), findsOneWidget);
    });
  });
}

// Helper para simular o viewInsets
class FakeViewPadding implements Fake, ViewPadding {
  const FakeViewPadding({this.bottom = 0.0});

  @override
  final double left = 0.0, top = 0.0, right = 0.0;
  @override
  final double bottom;
}