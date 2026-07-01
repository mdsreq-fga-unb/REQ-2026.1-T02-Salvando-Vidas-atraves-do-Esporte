import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class AlunoTileWidget extends StatelessWidget {
  final String nome;
  final VoidCallback? onRemover;
  final VoidCallback? onTap;

  const AlunoTileWidget({super.key, required this.nome, this.onRemover, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final dividerColor = isDark ? AppColors.darkDivider : AppColors.divider;
    final avatarBg = isDark ? AppColors.darkInputFill : AppColors.inputFill;
    final iconColor = isDark ? AppColors.cyanPastel : AppColors.deepNavy;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          leading: CircleAvatar(
            backgroundColor: avatarBg,
            child: Icon(Icons.person, color: iconColor, size: 20),
          ),
          title: Text(
            nome,
            style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
          ),
          trailing: onRemover != null
              ? TextButton(
                  onPressed: onRemover,
                  child: const Text(
                    'Remover',
                    style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                  ),
                )
              : null,
        ),
        Divider(height: 1, thickness: 1, color: dividerColor),
      ],
    );
  }
}
