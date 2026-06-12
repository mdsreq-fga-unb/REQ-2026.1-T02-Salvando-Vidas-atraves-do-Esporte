import 'package:flutter/material.dart';

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
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPerguntaMedica(1, 'Pergunta médica 1:'),
            _buildPerguntaMedica(2, 'Pergunta médica 2:'),
            _buildPerguntaMedica(3, 'Pergunta médica 3:'),
            _buildPerguntaMedica(4, 'Pergunta médica 4:'),
            _buildPerguntaMedica(5, 'Pergunta médica N:'),
            const SizedBox(height: 16),
            _buildLabel('Observações:'),
            TextFormField(
              controller: obsController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Digite as observações aqui...',
                filled: true,
                fillColor: const Color(0xFFF5F7FB),
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
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF08216F),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPerguntaMedica(int id, String pergunta) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(pergunta),
          Row(
            children: [
              _buildRadioOption(id, true, 'Sim'),
              const SizedBox(width: 16),
              _buildRadioOption(id, false, 'Não'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(int id, bool value, String label) {
    return InkWell(
      onTap: () => onRespostaChanged(id, value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Radio<bool>(
            value: value,
            groupValue: respostas[id],
            onChanged: (bool? v) => onRespostaChanged(id, v),
            activeColor: const Color(0xFF08216F),
          ),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}