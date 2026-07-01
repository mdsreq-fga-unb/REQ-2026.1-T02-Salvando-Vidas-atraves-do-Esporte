import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/presenca/historico_frequencia_provider.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

void mostrarHistoricoFrequenciaAlunoDialog(BuildContext context, Aluno aluno) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _HistoricoFrequenciaAlunoSheet(aluno: aluno),
  );
}

class _HistoricoFrequenciaAlunoSheet extends ConsumerWidget {
  final Aluno aluno;

  const _HistoricoFrequenciaAlunoSheet({required this.aluno});

  String _formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historicoFrequenciaAlunoProvider(aluno));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: sheetBg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Puxador do BottomSheet
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Header do Aluno
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.cyanPrimary.withOpacity(0.2),
                    child: const Icon(Icons.person, color: AppColors.cyanPrimary, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aluno.nomeReferencia,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Faixa: ${aluno.faixa.nomeVisivel}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Conteúdo (Cards de Resumo + Lista)
            Expanded(
              child: state.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Text(
                    'Erro ao carregar histórico: $err',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
                data: (data) => ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Cards de Resumo
                    _buildResumoGrid(data, isDark),
                    const SizedBox(height: 24),
                    Text(
                      'Linha do Tempo das Aulas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (data.itens.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              Icon(Icons.event_busy, size: 48, color: AppColors.textSecondary.withOpacity(0.5)),
                              const SizedBox(height: 12),
                              const Text(
                                'Nenhum registro de aula encontrado para este aluno.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...data.itens.map((item) => _buildTimelineCard(item, isDark)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumoGrid(HistoricoFrequenciaAlunoData data, bool isDark) {
    final corFrequencia = data.percentualFrequencia >= 75
        ? AppColors.success
        : (data.percentualFrequencia >= 50 ? AppColors.warning : AppColors.error);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.darkInputFill, AppColors.darkSurface]
              : [AppColors.platinum, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.divider,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Frequência Geral',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${data.percentualFrequencia.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: corFrequencia,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: corFrequencia.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.percentualFrequencia >= 75 ? 'Excelente' : (data.percentualFrequencia >= 50 ? 'Regular' : 'Baixa'),
                  style: TextStyle(
                    color: corFrequencia,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: data.totalAulas > 0 ? (data.percentualFrequencia / 100) : 0,
              backgroundColor: isDark ? Colors.white12 : Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(corFrequencia),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatBadge('Aulas', '${data.totalAulas}', Icons.calendar_month, AppColors.cyanPrimary, isDark)),
              const SizedBox(width: 8),
              Expanded(child: _buildStatBadge('Presenças', '${data.totalPresencas}', Icons.check_circle, AppColors.success, isDark)),
              const SizedBox(width: 8),
              Expanded(child: _buildStatBadge('Ausências', '${data.totalAusencias}', Icons.cancel, AppColors.error, isDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String label, String value, IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.black26 : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(RegistroFrequenciaItem item, bool isDark) {
    final statusColor = item.presente ? AppColors.success : AppColors.error;
    final statusText = item.presente ? 'Presente' : 'Ausente';
    final statusIcon = item.presente ? Icons.check_circle_outline : Icons.highlight_off;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkInputFill : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.divider,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.event, size: 18, color: AppColors.cyanPrimary),
                  const SizedBox(width: 6),
                  Text(
                    _formatarData(item.data),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.group, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                item.turmaNome ?? 'Turma #${item.turmaId}',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              if (item.voluntarioNome != null) ...[
                const SizedBox(width: 12),
                Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  item.voluntarioNome!,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ],
          ),
          if (item.observacao != null && item.observacao!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
              ),
              child: Text(
                'Nota: "${item.observacao!}"',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
