//Navbar é principal componente utilizado na maioria das páginas logadas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../routing/routes.dart';
import '../themes/colors.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final isAdminPage = location.startsWith(Routes.admin);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    int currentIndex = 0;
    if (location.startsWith(Routes.buscaAluno)) {
      currentIndex = 1;
    } else if (location.startsWith(Routes.turma)) {
      currentIndex = 2;
    } else if (location.startsWith(Routes.inventario) || 
               location.startsWith(Routes.doacoesPerdas) || 
               location.startsWith(Routes.emprestimoDevolucao)) {
      currentIndex = 3;
    } else if (location.startsWith(Routes.configuracao)) {
      currentIndex = 4;
    }

    final items = [
      _NavItem(icon: Icons.home,      label: 'Início',        route: Routes.home),
      _NavItem(icon: Icons.search,    label: 'Pesquisar',     route: Routes.buscaAluno),
      _NavItem(icon: Icons.school,    label: 'Turmas',        route: Routes.turma),
      _NavItem(icon: Icons.inventory, label: 'Inventário',    route: Routes.inventario),
      _NavItem(icon: Icons.settings,  label: 'Configurações', route: Routes.configuracao),
    ];

    final navBg = isDark ? AppColors.darkNavbar : Colors.white;
    final selectedColor = AppColors.royalAzure;
    final unselectedColor = isDark ? AppColors.darkTextSecondary : Colors.black54;
    final selectedBg = isDark ? AppColors.royalAzure.withOpacity(0.25) : AppColors.highlightBlue;
    final selectedBorder = isDark ? AppColors.cyanPastel : AppColors.royalAzure;

    return Container(
      color: navBg,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = !isAdminPage && currentIndex == index;

              return Tooltip(
                message: item.label,
                decoration: BoxDecoration(
                  color: AppColors.deepNavy,
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? selectedBg : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? selectedBorder : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => context.go(item.route),
                      splashColor: AppColors.splashBlue,
                      highlightColor: AppColors.highlightBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          item.icon,
                          color: isSelected ? selectedColor : unselectedColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem({required this.icon, required this.label, required this.route});
}