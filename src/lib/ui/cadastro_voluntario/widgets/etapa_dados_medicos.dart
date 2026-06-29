import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class EtapaDadosMedicos extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final bool termoAceito;
  final Function(bool?) onTermoChanged;

  const EtapaDadosMedicos({
    super.key,
    required this.formKey,
    required this.termoAceito,
    required this.onTermoChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final fillColor = isDark ? AppColors.darkSurface : AppColors.inputFill;
    final hintColor = isDark ? Colors.white54 : Colors.black54;

    final cadastro = ref.watch(cadastroAlunoProvider);
    final notifier = ref.read(cadastroAlunoProvider.notifier);

    return Form(
      key: formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPerguntaMedica(
                  '1. Você possui alguma condição de saúde crônica (ex: problemas cardíacos, hipertensão, diabetes, asma)?',
                  isDark,
                  textColor,
                  cadastro.pMedica1,
                  notifier.updatePMedica1,
                ),
                _buildPerguntaMedica(
                  '2. Você sente dores no peito, tonturas frequentes ou já sofreu desmaios durante ou após esforço físico?',
                  isDark,
                  textColor,
                  cadastro.pMedica2,
                  notifier.updatePMedica2,
                ),
                _buildPerguntaMedica(
                  '3. Você possui alguma lesão óssea, articular ou passou por cirurgia recente que possa ser agravada pelo treino de Jiu-Jitsu?',
                  isDark,
                  textColor,
                  cadastro.pMedica3,
                  notifier.updatePMedica3,
                ),
                _buildPerguntaMedica(
                  '4. Você tem alergia a algum medicamento ou faz uso de medicação de uso contínuo?',
                  isDark,
                  textColor,
                  cadastro.pMedica4,
                  notifier.updatePMedica4,
                ),
                _buildPerguntaMedica(
                  '5. Sabe de alguma outra razão ou limitação física não mencionada pela qual a prática de atividade física possa comprometer sua saúde?',
                  isDark,
                  textColor,
                  cadastro.pMedica5,
                  notifier.updatePMedica5,
                ),
                const SizedBox(height: 16),
                _buildLabel('Observações:', textColor),
                TextFormField(
                  initialValue: cadastro.observacaoMedica,
                  onChanged: notifier.updateObservacaoMedica,
                  maxLines: 3,
                  style: TextStyle(color: textColor),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Digite as observações aqui...',
                    hintStyle: TextStyle(color: hintColor),
                    filled: true,
                    fillColor: fillColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : AppColors.royalAzure.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? Colors.white24
                          : AppColors.royalAzure.withOpacity(0.2),
                    ),
                  ),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: isDark
                        ? AppColors.cyanPrimary
                        : AppColors.deepNavy,
                    title: Text(
                      'Termo de Responsabilidade*',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'O aluno (ou responsável legal) declarou ter compreendido e respondido a todas as perguntas com veracidade, estar ciente da recomendação de avaliação médica prévia e assumir a responsabilidade pela prática da atividade física.',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                    value: termoAceito,
                    onChanged: onTermoChanged,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPerguntaMedica(
    String pergunta,
    bool isDark,
    Color textColor,
    bool valorAtual,
    void Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(pergunta, textColor),
          SimNaoRadioGroup(
            valorAtual: valorAtual,
            onChanged: (valor) => onChanged(valor ?? false),
            isDark: isDark,
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}

class SimNaoRadioGroup extends StatelessWidget {
  final bool? valorAtual;
  final ValueChanged<bool?> onChanged;
  final bool isDark;
  final Color textColor;

  const SimNaoRadioGroup({
    super.key,
    required this.valorAtual,
    required this.onChanged,
    required this.isDark,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? AppColors.cyanPrimary : AppColors.deepNavy;

    return RadioGroup<bool>(
      groupValue: valorAtual,
      onChanged: onChanged,
      child: Row(
        children: [
          _OpcaoRadio(
            label: 'Sim',
            valor: true,
            activeColor: activeColor,
            textColor: textColor,
            onTap: () => onChanged(true),
          ),
          const SizedBox(width: 20),
          _OpcaoRadio(
            label: 'Não',
            valor: false,
            activeColor: activeColor,
            textColor: textColor,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

/// Widget privado auxiliar para desenhar cada opção de rádio internamente no grupo.
class _OpcaoRadio extends StatelessWidget {
  final String label;
  final bool valor;
  final Color activeColor;
  final Color textColor;
  final VoidCallback onTap;

  const _OpcaoRadio({
    required this.label,
    required this.valor,
    required this.activeColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<bool>(value: valor, activeColor: activeColor),
          Text(label, style: TextStyle(fontSize: 14, color: textColor)),
        ],
      ),
    );
  }
}
