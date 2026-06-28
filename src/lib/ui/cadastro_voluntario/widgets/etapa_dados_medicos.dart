import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class EtapaDadosMedicos extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<int, bool?> respostas;
  final Function(int, bool?) onRespostaChanged;
  final TextEditingController obsController;

  const EtapaDadosMedicos({
    super.key,
    required this.formKey,
    required this.respostas,
    required this.onRespostaChanged,
    required this.obsController,
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
                _buildPerguntaMedica(1, 'Pergunta médica 1:', isDark, textColor),
                _buildPerguntaMedica(2, 'Pergunta médica 2:', isDark, textColor),
                _buildPerguntaMedica(3, 'Pergunta médica 3:', isDark, textColor),
                _buildPerguntaMedica(4, 'Pergunta médica 4:', isDark, textColor),
                _buildPerguntaMedica(5, 'Pergunta médica N:', isDark, textColor),
                const SizedBox(height: 16),
                _buildLabel('Observações:', textColor),
                TextFormField(
                  controller: obsController,
                  maxLines: 4,
                  style: TextStyle(color: textColor),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Digite as observações aqui...',
                    hintStyle: TextStyle(color: hintColor),
                    filled: true,
                    fillColor: fillColor, // Padronizado com o InputField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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

  Widget _buildPerguntaMedica(int id, String pergunta, bool isDark, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(pergunta, textColor),
          Row(
            children: [
              _buildRadioOption(id, true, 'Sim', isDark, textColor),
              const SizedBox(width: 16),
              _buildRadioOption(id, false, 'Não', isDark, textColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(int id, bool value, String label, bool isDark, Color textColor) {
    return InkWell(
      onTap: () => onRespostaChanged(id, value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
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