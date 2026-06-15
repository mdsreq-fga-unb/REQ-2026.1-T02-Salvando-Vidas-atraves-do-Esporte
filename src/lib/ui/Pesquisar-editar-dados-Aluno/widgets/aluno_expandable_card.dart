import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/editar_aluno_page.dart';
import 'package:salvando_vidas/ui/global/masks.dart';

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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: isInativo ? 0 : 2,
      color: isInativo ? Colors.grey[200] : Colors.white,
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
                              widget.aluno.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isInativo ? Colors.grey[500] : Colors.black,
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
                                  color: Colors.grey[400],
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
                            color: isInativo ? Colors.grey[400] : Colors.black87,
                          ),
                        ),
                        Text(
                          'Faixa: ${widget.aluno.faixa.nomeVisivel}',
                          style: TextStyle(
                            fontSize: 14,
                            color: isInativo ? Colors.grey[400] : Colors.black87,
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
                                Icon(Icons.block, size: 18, color: Colors.red),
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
                                Icon(Icons.check_circle_outline, size: 18, color: Colors.green),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BCD4),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 13),
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
  }
}