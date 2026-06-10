//Navbar é principal componente utilizado na maioria das páginas logadas
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routing/routes.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final location = GoRouterState.of(context).uri.toString();

    switch (location) {
      //case Routes.pesquisa(search):
      //  currentIndex = X;
      //  break
      case Routes.home:
        currentIndex = 0;
        break;
      case Routes.turma:
        currentIndex = 1;
        break;
      case Routes.configuracao:
        currentIndex = 2;
        break;
      //case Routes.inventario:
      //  currentIndex = X;
      //  break
    }

    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0x332457F0),

      destinations: const [
/*         NavigationDestination(
          icon: Icon(Icons.search),
          label: '',
        ),

        NavigationDestination(
          icon: Icon(Icons.inventory),
          label: '',
        ), */

        NavigationDestination(
          icon: Icon(Icons.home),
          label: '',
        ),

        NavigationDestination(
          icon: Icon(Icons.school),
          label: '',
        ),

        NavigationDestination(
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],

      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go(Routes.home);
            break;
          case 1:
            context.go(Routes.turma);
            break;
/*           case 1:
            context.go(Routes.cadastros);
            break; */
          case 2:
            context.go(Routes.configuracao);
            break;
        }
      },
    );
  }
}