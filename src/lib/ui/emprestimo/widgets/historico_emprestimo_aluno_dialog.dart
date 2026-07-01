import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/emprestimo/historico_emprestimos_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/emprestimo/widgets/detalhes_item_historico_dialog.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

void mostrarHistoricoEmprestimoAlunoDialog(BuildContext context, Aluno aluno) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _HistoricoEmprestimoAlunoSheet(aluno: aluno),
  );
}

class _HistoricoEmprestimoAlunoSheet extends ConsumerWidget {
  final Aluno aluno;

  const _HistoricoEmprestimoAlunoSheet({required this.aluno});

  String _formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historicoEmprestimosStoreProvider);
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
                    backgroundColor: AppColors.royalAzure.withOpacity(0.2),
                    child: const Icon(Icons.checkroom, color: AppColors.royalAzure, size: 30),
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
            // Conteúdo
            Expanded(
              child: state.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.cyanPrimary),
                ),
                error: (err, stack) => Center(
                  child: Text(
                    'Erro ao carregar histórico: $err',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
                data: (data) {
                  final itensDoAluno = data.itens
                      .where((item) => item.emprestimo.alunoId == aluno.id)
                      .toList();

                  return ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Grid de Resumo
                      _buildResumoGrid(itensDoAluno, isDark),
                      const SizedBox(height: 24),
                      Text(
                        'Linha do Tempo de Empréstimos e Devoluções',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (itensDoAluno.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Icon(Icons.history, size: 48, color: AppColors.textSecondary.withOpacity(0.5)),
                                const SizedBox(height: 12),
                                const Text(
                                  'Nenhum empréstimo ou devolução registrado para este aluno.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...itensDoAluno.map((item) => _buildTimelineCard(context, item, isDark)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumoGrid(List<HistoricoItem> itens, bool isDark) {
    final total = itens.length;
    final ativos = itens.where((i) => i.emprestimo.dataDevolucao == null).length;
    final devolvidos = itens.where((i) => i.emprestimo.dataDevolucao != null).length;

    final corStatus = ativos > 0 ? AppColors.warning : AppColors.success;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Atual',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ativos > 0 ? '$ativos Empréstimo(s) Ativo(s)' : 'Sem Empréstimos Pendentes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: corStatus,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: corStatus.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ativos > 0 ? 'Pendente' : 'Regular',
                  style: TextStyle(
                    color: corStatus,
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
              value: total > 0 ? (devolvidos / total) : 1.0,
              backgroundColor: isDark ? Colors.white12 : Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatBadge('Total', '$total', Icons.history, AppColors.royalAzure, isDark)),
              const SizedBox(width: 8),
              Expanded(child: _buildStatBadge('Em Aberto', '$ativos', Icons.pending_actions, AppColors.warning, isDark)),
              const SizedBox(width: 8),
              Expanded(child: _buildStatBadge('Devolvidos', '$devolvidos', Icons.check_circle, AppColors.success, isDark)),
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

  Widget _buildTimelineCard(BuildContext context, HistoricoItem item, bool isDark) {
    final isDevolvido = item.emprestimo.dataDevolucao != null;
    final statusColor = isDevolvido ? AppColors.success : AppColors.warning;
    final statusText = isDevolvido ? 'Devolvido' : 'Em Aberto';
    final statusIcon = isDevolvido ? Icons.check_circle_outline : Icons.pending_actions;

    final dataEmp = _formatarData(item.emprestimo.data);
    final dataDev = isDevolvido ? _formatarData(item.emprestimo.dataDevolucao!) : null;

    final kimono = '${item.emprestimo.tamanho.nomeVisivel}, ${item.emprestimo.cor.nomeVisivel}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isDark ? AppColors.darkDivider : AppColors.divider,
        ),
      ),
      color: isDark ? AppColors.darkInputFill : Colors.white,
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => mostrarDetalhesItemHistoricoDialog(context, item),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.sports_martial_arts, size: 20, color: AppColors.royalAzure),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Kimono: $kimono',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
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
          const SizedBox(height: 10),
          Divider(color: isDark ? Colors.white10 : Colors.grey[200], height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Data de Empréstimo:', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(dataEmp, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isDark ? Colors.white : AppColors.deepNavy)),
                ],
              ),
              if (dataDev != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Data de Devolução:', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(dataDev, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.success)),
                  ],
                ),
            ],
          ),
        ],
      ),
    ),
    ),
    );
  }
}
