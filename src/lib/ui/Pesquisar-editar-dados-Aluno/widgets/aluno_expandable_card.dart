import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/editar_aluno_page.dart';
import 'package:salvando_vidas/ui/global/masks.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/turma/widgets/historico_frequencia_aluno_dialog.dart';

class AlunoExpandableCard extends ConsumerStatefulWidget {
  final Aluno aluno;
  final Responsavel? responsavel;

  const AlunoExpandableCard({
    super.key,
    required this.aluno,
    required this.responsavel,
  });

  @override
  ConsumerState<AlunoExpandableCard> createState() =>
      _AlunoExpandableCardState();
}

class _AlunoExpandableCardState extends ConsumerState<AlunoExpandableCard> {
  bool _isExpanded = false;

  String _formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  final formatCPF = maskCPF();
  final formatTelefone = maskTelefone();

  @override
  Widget build(BuildContext context) {
    final bool isInativo = !widget.aluno.ativo;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isInativo
        ? AppColors.textSecondary.withValues(alpha: 0.4)
        : (isDark ? AppColors.darkSurface : Colors.white);
    final mainText = isInativo ? AppColors.textSecondary : (isDark ? Colors.white : Colors.black);
    final subText = isInativo ? AppColors.textSecondary : (isDark ? Colors.white70 : AppColors.black1);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: isInativo ? 0 : 4,
      shadowColor: AppColors.royalAzure.withOpacity(isDark ? 0.35 : 0.18),
      color: cardBg,
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.aluno.nomeReferencia,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: mainText,
                              ),
                            ),
                            if (isInativo) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.textSecondary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Inativo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Turma: ${widget.aluno.idTurma ?? "N/A"}',
                          style: TextStyle(
                            fontSize: 14,
                            color: subText,
                          ),
                        ),
                        Text(
                          'Faixa: ${widget.aluno.faixa.nomeVisivel}',
                          style: TextStyle(
                            fontSize: 14,
                            color: subText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isExpanded)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) async {
                        final notifier = ref.read(pesquisaAlunoProvider.notifier);
                        try {
                          if (value == 'inativar') {
                            await notifier.inativarAluno(widget.aluno.id!);
                          } else if (value == 'reativar') {
                            await notifier.reativarAluno(widget.aluno.id!);
                          }
                        } catch (e) {
                          switch (e) {
                            case AppApiException(
                              message: final m,
                              error: final err,
                            ):
                              ref.read(loggerProvider).e(m, error: err);
                            default:
                              ref.read(loggerProvider).e('', error: e);
                          }
                        }
                      },
                      itemBuilder: (context) => [
                        if (!isInativo)
                          const PopupMenuItem(
                            value: 'inativar',
                            child: Row(
                              children: [
                                Icon(Icons.block, size: 18, color: AppColors.error),
                                SizedBox(width: 8),
                                Text('Inativar'),
                              ],
                            ),
                          ),
                        if (isInativo)
                          const PopupMenuItem(
                            value: 'reativar',
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline, size: 18, color: AppColors.success),
                                SizedBox(width: 8),
                                Text('Reativar'),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),

              if (_isExpanded) ...[
                const SizedBox(height: 12),
                if (widget.aluno.apelido != null && widget.aluno.apelido!.isNotEmpty) ...[
                  _buildInfoRow('Nome completo: ', widget.aluno.nome),
                  _buildInfoRow('Apelido: ', widget.aluno.apelido!),
                ],
                _buildInfoRow('CPF: ', formatCPF.maskText(widget.aluno.cpf)),
                _buildInfoRow(
                  'Telefone: ',
                  widget.aluno.contato != null
                      ? formatTelefone.maskText(widget.aluno.contato!)
                      : 'Não informado',
                ),
                _buildInfoRow(
                  'Aniversário: ',
                  _formatarData(widget.aluno.nascimento),
                ),
                _buildInfoRow(
                  'Tipo sanguíneo: ',
                  widget.aluno.tipoSanguineo.nomeVisivel,
                ),
                _buildInfoRow(
                  'ID da ficha: ',
                  widget.aluno.idFicha?.toString() ?? 'N/A',
                ),

                if (widget.responsavel != null) ...[
                  const SizedBox(height: 8),
                  const Text(
                    '(< 18 anos)',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                  _buildInfoRow(
                    'Nome do responsável: ',
                    widget.responsavel!.nome,
                  ),
                  _buildInfoRow(
                    'CPF do responsável: ',
                    formatCPF.maskText(widget.responsavel!.cpf),
                  ),
                  _buildInfoRow(
                    'Telefone do responsável: ',
                    formatTelefone.maskText(widget.responsavel!.contato),
                  ),
                ],

                if (!isInativo) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.cyanPrimary,
                        side: const BorderSide(color: AppColors.cyanPrimary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.history, size: 18),
                      onPressed: () => mostrarHistoricoFrequenciaAlunoDialog(context, widget.aluno),
                      label: const Text(
                        'Ver Histórico de Frequência',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyanPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarAlunoPage(
                              aluno: widget.aluno,
                              responsavel: widget.responsavel,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Editar Informações',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: isDark ? Colors.white70 : AppColors.black1, fontSize: 13),
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        );
      },
    );
  }
}