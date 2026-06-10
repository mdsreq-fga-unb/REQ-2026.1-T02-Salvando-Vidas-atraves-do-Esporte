import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';

class EtapaDadosBasicos extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController telefoneController;
  final TextEditingController dataNascimentoController;
  final String? tipoSanguineo;
  final String? faixa;
  final String? idFicha;
  final ValueChanged<String?> onTipoSanguineoChanged;
  final ValueChanged<String?> onFaixaChanged;
  final ValueChanged<String?> onIdFichaChanged;

  const EtapaDadosBasicos({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.cpfController,
    required this.telefoneController,
    required this.dataNascimentoController,
    required this.tipoSanguineo,
    required this.faixa,
    required this.idFicha,
    required this.onTipoSanguineoChanged,
    required this.onFaixaChanged,
    required this.onIdFichaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              controller: nomeController,
              label: 'Nome*',
              hint: 'Digite o nome completo',
              validatorMessage: 'O nome é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              controller: cpfController,
              label: 'CPF*',
              hint: '000.000.000-00',
              keyboardType: TextInputType.number,
              validatorMessage: 'O CPF é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              controller: telefoneController,
              label: 'Telefone*',
              hint: '(00) 00000-0000',
              keyboardType: TextInputType.phone,
              validatorMessage: 'O telefone é obrigatório',
            ),
            const SizedBox(height: 14),
            _buildLabel('Aniversário*'),
            TextFormField(
              controller: dataNascimentoController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F7FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF08216F)),
              ),
              validator: (value) => (value == null || value.isEmpty) ? 'A data é obrigatória' : null,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  dataNascimentoController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
            ),
            const SizedBox(height: 14),
            _buildDropdownField(
              label: 'Tipo sanguíneo*',
              value: tipoSanguineo,
              items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
              onChanged: onTipoSanguineoChanged,
              validatorMessage: 'Selecione o tipo sanguíneo',
            ),
            const SizedBox(height: 14),
            _buildDropdownField(
              label: 'Faixa/Grau*',
              value: faixa,
              items: ['Branca', 'Azul', 'Roxa', 'Marrom', 'Preta'],
              onChanged: onFaixaChanged,
              validatorMessage: 'Selecione a faixa',
            ),
            const SizedBox(height: 14),
            _buildDropdownField(
              label: 'ID da ficha*',
              value: idFicha,
              items: ['ID 001', 'ID 002', 'ID 003'],
              onChanged: onIdFichaChanged,
              validatorMessage: 'Selecione o ID da ficha',
            ),
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

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String validatorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F7FB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          hint: Text(label.replaceAll('*', '')),
          items: items.map((String item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
          validator: (v) => v == null ? validatorMessage : null,
        ),
      ],
    );
  }
}