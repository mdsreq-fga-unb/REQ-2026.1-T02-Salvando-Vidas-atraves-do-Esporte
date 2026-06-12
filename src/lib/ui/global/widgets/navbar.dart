//Navbar é principal componente utilizado na maioria das páginas logadas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import '../../../routing/routes.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = switch (location) {
      Routes.home => 0,
      Routes.turma => 1,
      Routes.configuracao => 2,
      Routes.admin => 3,
      _ => 0,
    };
    final isAdmin = ref.read(userServiceProvider).isAdmin;

    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0x332457F0),

      destinations: [
        /*         NavigationDestination(
          icon: Icon(Icons.search),
          label: '',
        ),

        NavigationDestination(
          icon: Icon(Icons.inventory),
          label: '',
        ), */
        NavigationDestination(icon: Icon(Icons.home), label: ''),

        NavigationDestination(icon: Icon(Icons.school), label: ''),

        NavigationDestination(icon: Icon(Icons.settings), label: ''),

        if (isAdmin) NavigationDestination(icon: Icon(Icons.people), label: ''),
      ],

      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go(Routes.home);
          case 1:
            context.go(Routes.turma);
          case 2:
            context.go(Routes.configuracao);
          case 3:
            context.go(Routes.admin);
        }
      },
    );
  }
}
