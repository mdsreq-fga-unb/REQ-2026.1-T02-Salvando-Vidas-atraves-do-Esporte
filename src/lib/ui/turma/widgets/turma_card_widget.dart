import 'package:flutter/material.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'turma_options_menu_widget.dart';

class TurmaCardWidget extends StatelessWidget {
  final Turma turma;
  final VoidCallback? onTap;
  final VoidCallback? onEditar;
  final VoidCallback? onExcluir;

  const TurmaCardWidget({
    super.key,
    required this.turma,
    this.onTap,
    this.onEditar,
    this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Espaçamento em volta do card
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      elevation: 2, // Sombra suave
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone de destaque à esquerda
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF00BCD4,
                  ).withOpacity(0.15), // Fundo ciano clarinho
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: Color(0xFF00BCD4), // Cor principal
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),

              // Textos organizados
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      turma.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Linha com ícone de pessoas
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 14,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${turma.qtdAlunos ?? 0} alunos',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Linha com ícone de relógio
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(
                            Icons.schedule,
                            size: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            turma.horarioFormatado,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Menu de opções (3 pontinhos)
              TurmaOptionsMenuWidget(
                turmaId: turma.id,
                onEditar: onEditar,
                onExcluir: onExcluir,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
