import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
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
    // Se o aluno não estiver ativo, não renderiza o cartão
    if (!widget.aluno.ativo) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
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
                        Text(
                          widget.aluno.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Turma: ${widget.aluno.idTurma ?? "N/A"}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Faixa: ${widget.aluno.faixa.nomeVisivel}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isExpanded)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) async {
                        if (value == 'inativar') {
                          try {
                            await ref.read(alunoServiceProvider).atualizaAluno(
                              widget.aluno.id!,
                              {'ativo': false},
                            );
                          } catch (e) {
                            switch (e) {
                              case AppApiException(
                                message: final m,
                                error: final e,
                              ):
                                ref.read(loggerProvider).e(m, error: e);
                              default:
                                ref.read(loggerProvider).e('', error: e);
                            }
                          }

                          // TODO: Adicionar lógica para inativar o aluno na base de dados
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'inativar',
                          child: Text('Inativar'),
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
