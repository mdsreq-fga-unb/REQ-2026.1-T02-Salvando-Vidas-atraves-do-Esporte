import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class AlunoTileWidget extends StatelessWidget {
  final String nome;
  final VoidCallback? onRemover;

  const AlunoTileWidget({super.key, required this.nome, this.onRemover});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: const CircleAvatar(
        backgroundColor: AppColors.inputFill, // Azul/Cinza clarinho padrão do projeto
        child: Icon(Icons.person, color: AppColors.deepNavy, size: 20), // Ícone adicionado
      ),
      title: Text(
        nome, 
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.deepNavy, // Texto no Azul Principal
        ),
      ),
      trailing: onRemover != null
          ? TextButton(
              onPressed: onRemover,
              child: const Text(
                'Remover',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      shape: const Border(
        bottom: BorderSide(color: AppColors.divider, width: 1), // Linha divisória suave entre os alunos
      ),
    );
  }
}