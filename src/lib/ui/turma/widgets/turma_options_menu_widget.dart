import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

enum TurmaMenuOption { historico }

class TurmaOptionsMenuWidget extends StatelessWidget {
  final int turmaId;

  const TurmaOptionsMenuWidget({
    super.key,
    required this.turmaId,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TurmaMenuOption>(
      icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (TurmaMenuOption option) {
        switch (option) {
          case TurmaMenuOption.historico:
            // Futura implementação
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<TurmaMenuOption>(
          value: TurmaMenuOption.historico,
          child: Row(
            children: [
              const Icon(
                Icons.history,
                color: AppColors.deepNavy,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text('Histórico de Frequência'),
            ],
          ),
        ),
      ],
    );
  }
}