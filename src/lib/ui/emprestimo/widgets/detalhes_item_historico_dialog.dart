import 'package:flutter/material.dart';
import 'package:salvando_vidas/data/stores/emprestimo/historico_emprestimos_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

void mostrarDetalhesItemHistoricoDialog(BuildContext context, HistoricoItem item) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _DetalhesItemHistoricoSheet(item: item),
  );
}

class _DetalhesItemHistoricoSheet extends StatelessWidget {
  final HistoricoItem item;

  const _DetalhesItemHistoricoSheet({required this.item});

  String _formatarDataHora(DateTime data) {
    final d = data.day.toString().padLeft(2, '0');
    final m = data.month.toString().padLeft(2, '0');
    final y = data.year;
    final h = data.hour.toString().padLeft(2, '0');
    final min = data.minute.toString().padLeft(2, '0');
    return '$d/$m/$y às $h:$min';
  }

  String _formatarData(DateTime data) {
    final d = data.day.toString().padLeft(2, '0');
    final m = data.month.toString().padLeft(2, '0');
    final y = data.year;
    return '$d/$m/$y';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    final isDevolvido = item.emprestimo.dataDevolucao != null;
    final statusColor = isDevolvido ? AppColors.success : AppColors.warning;
    final statusText = isDevolvido ? 'Kimono Devolvido' : 'Empréstimo em Aberto';
    final statusIcon = isDevolvido ? Icons.check_circle_outline : Icons.pending_actions;

    final nomeAluno = item.aluno?.nomeReferencia ?? 'Aluno #${item.emprestimo.alunoId}';
    final faixaAluno = item.aluno?.faixa.nomeVisivel ?? 'Não informada';
    final contatoAluno = item.aluno?.contato ?? 'Não informado';

    final tamanhoKimono = item.emprestimo.tamanho.nomeVisivel;
    final corKimono = item.emprestimo.cor.nomeVisivel;

    final nomeVoluntario = item.voluntario?.nome ?? 'Não informado';

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, -4),
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
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: statusColor.withValues(alpha: 0.15),
                      child: Icon(statusIcon, color: statusColor, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detalhes do Registro',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.emprestimo.id != null
                                ? 'Registro #${item.emprestimo.id}'
                                : 'Registro de Empréstimo',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
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
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Banner de Status
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(statusIcon, color: statusColor, size: 28),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isDevolvido
                                      ? 'Devolvido em ${_formatarData(item.emprestimo.dataDevolucao!)}'
                                      : 'O aluno ainda está em posse do quimono.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? Colors.white70 : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Card de Dados do Aluno
                    _buildSectionHeader('Dados do Aluno', Icons.person, AppColors.royalAzure),
                    const SizedBox(height: 8),
                    _buildInfoCard(
                      isDark: isDark,
                      children: [
                        _buildInfoRow('Nome do Aluno', nomeAluno, isDark),
                        const Divider(height: 20),
                        _buildInfoRow('Faixa', faixaAluno, isDark),
                        const Divider(height: 20),
                        _buildInfoRow('Telefone/Contato', contatoAluno, isDark),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Card de Especificações do Kimono
                    _buildSectionHeader('Especificações do Quimono', Icons.sports_martial_arts, AppColors.cyanPrimary),
                    const SizedBox(height: 8),
                    _buildInfoCard(
                      isDark: isDark,
                      children: [
                        _buildInfoRow('Tamanho', tamanhoKimono, isDark),
                        const Divider(height: 20),
                        _buildInfoRow('Cor', corKimono, isDark),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Card de Cronologia / Datas
                    _buildSectionHeader('Cronologia', Icons.calendar_today, AppColors.warning),
                    const SizedBox(height: 8),
                    _buildInfoCard(
                      isDark: isDark,
                      children: [
                        _buildInfoRow(
                          'Data de Empréstimo',
                          _formatarDataHora(item.emprestimo.data),
                          isDark,
                        ),
                        const Divider(height: 20),
                        _buildInfoRow(
                          'Data de Devolução',
                          isDevolvido
                              ? _formatarDataHora(item.emprestimo.dataDevolucao!)
                              : 'Pendente',
                          isDark,
                          valueColor: isDevolvido ? AppColors.success : AppColors.warning,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Card de Responsável
                    _buildSectionHeader('Responsável pelo Registro', Icons.admin_panel_settings, AppColors.royalAzure),
                    const SizedBox(height: 8),
                    _buildInfoCard(
                      isDark: isDark,
                      children: [
                        _buildInfoRow('Voluntário Responsável', nomeVoluntario, isDark),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required bool isDark, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkInputFill : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? (isDark ? Colors.white : AppColors.deepNavy),
            ),
          ),
        ),
      ],
    );
  }
}
