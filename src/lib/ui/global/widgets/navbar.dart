import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routing/routes.dart';

//Navbar é principal componente utilizado na maioria das páginas logadas

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 8,
          selectedItemColor: const Color(0xFF2457F0),
          unselectedItemColor: const Color(0xFF9AA6C4),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                // context.go(Routes.search);
                break;
              case 1:
                context.go(Routes.home);
                break;
              case 2:
                context.go(Routes.cadastros);
                break;
            }
          },
        );
  }
}