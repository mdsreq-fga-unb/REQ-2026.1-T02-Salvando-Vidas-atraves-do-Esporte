import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/turma/views/historico_frequencia_turma_view.dart';

enum TurmaMenuOption { historico }

class TurmaOptionsMenuWidget extends StatelessWidget {
  final int turmaId;

  const TurmaOptionsMenuWidget({
    super.key,
    required this.turmaId,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final iconColor = isDark ? AppColors.cyanPrimary : AppColors.deepNavy;

    return PopupMenuButton<TurmaMenuOption>(
      icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
      color: menuBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (TurmaMenuOption option) {
        switch (option) {
          case TurmaMenuOption.historico:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HistoricoFrequenciaTurmaView(turmaId: turmaId),
              ),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<TurmaMenuOption>(
          value: TurmaMenuOption.historico,
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: iconColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Histórico de Frequência',
                  style: TextStyle(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}