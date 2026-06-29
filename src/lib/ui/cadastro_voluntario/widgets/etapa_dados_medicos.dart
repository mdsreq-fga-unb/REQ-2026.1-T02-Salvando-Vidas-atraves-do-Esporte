import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class EtapaDadosMedicos extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<int, bool?> respostas;
  final Function(int, bool?) onRespostaChanged;
  final TextEditingController obsController;
  final bool termoAceito;
  final Function(bool?) onTermoChanged;

  const EtapaDadosMedicos({
    super.key,
    required this.formKey,
    required this.respostas,
    required this.onRespostaChanged,
    required this.obsController,
    required this.termoAceito,
    required this.onTermoChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final fillColor = isDark ? AppColors.darkSurface : AppColors.inputFill;
    final hintColor = isDark ? Colors.white54 : Colors.black54;

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
                  1,
                  '1. Você possui alguma condição de saúde crônica (ex: problemas cardíacos, hipertensão, diabetes, asma)?',
                  isDark,
                  textColor,
                ),
                _buildPerguntaMedica(
                  2,
                  '2. Você sente dores no peito, tonturas frequentes ou já sofreu desmaios durante ou após esforço físico?',
                  isDark,
                  textColor,
                ),
                _buildPerguntaMedica(
                  3,
                  '3. Você possui alguma lesão óssea, articular ou passou por cirurgia recente que possa ser agravada pelo treino de Jiu-Jitsu?',
                  isDark,
                  textColor,
                ),
                _buildPerguntaMedica(
                  4,
                  '4. Você tem alergia a algum medicamento ou faz uso de medicação de uso contínuo?',
                  isDark,
                  textColor,
                ),
                _buildPerguntaMedica(
                  5,
                  '5. Sabe de alguma outra razão ou limitação física não mencionada pela qual a prática de atividade física possa comprometer sua saúde?',
                  isDark,
                  textColor,
                ),
                const SizedBox(height: 16),
                _buildLabel('Observações:', textColor),
                TextFormField(
                  controller: obsController,
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
                    activeColor:
                        isDark ? AppColors.cyanPrimary : AppColors.deepNavy,
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
    int id,
    String pergunta,
    bool isDark,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(pergunta, textColor),
          Row(
            children: [
              _buildRadioOption(id, true, 'Sim', isDark, textColor),
              const SizedBox(width: 20),
              _buildRadioOption(id, false, 'Não', isDark, textColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(
    int id,
    bool value,
    String label,
    bool isDark,
    Color textColor,
  ) {
    return InkWell(
      onTap: () => onRespostaChanged(id, value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<bool>(
            value: value,
            groupValue: respostas[id],
            onChanged: (bool? v) => onRespostaChanged(id, v),
            activeColor: isDark ? AppColors.cyanPrimary : AppColors.deepNavy,
          ),
          Text(label, style: TextStyle(fontSize: 14, color: textColor)),
        ],
      ),
    );
  }
}