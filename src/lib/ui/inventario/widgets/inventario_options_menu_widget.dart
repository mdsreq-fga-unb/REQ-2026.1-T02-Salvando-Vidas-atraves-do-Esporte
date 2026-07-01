import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

enum InventarioMenuOption { historico }

class InventarioOptionsMenuWidget extends StatelessWidget {
  const InventarioOptionsMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final iconColor = isDark ? AppColors.cyanPrimary : AppColors.deepNavy;

    return PopupMenuButton<InventarioMenuOption>(
      icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
      color: menuBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (InventarioMenuOption option) {
        switch (option) {
          case InventarioMenuOption.historico:
            context.push(Routes.historicoEmprestimos);
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<InventarioMenuOption>(
          value: InventarioMenuOption.historico,
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: iconColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text('Histórico de Empréstimos e Devoluções', style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ],
    );
  }
}
