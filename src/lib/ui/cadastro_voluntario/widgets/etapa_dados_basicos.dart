import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';

class EtapaDadosBasicos extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final cadastro = ref.watch(cadastroAlunoProvider);
    final notifier = ref.read(cadastroAlunoProvider.notifier);

    final dataFormatada = cadastro.nascimento != null
        ? "${cadastro.nascimento!.day.toString().padLeft(2, '0')}/${cadastro.nascimento!.month.toString().padLeft(2, '0')}/${cadastro.nascimento!.year}"
        : '';

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              initialValue: cadastro.nome,
              update: notifier.updateNome,
              error: cadastro.nomeError,
              label: 'Nome*',
              hint: 'Digite o nome completo',
              validatorMessage: 'O nome é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              initialValue: cadastro.cpf,
              update: notifier.updateCPF,
              error: cadastro.cpfError,
              label: 'CPF*',
              hint: '000.000.000-00',
              keyboardType: TextInputType.number,
              validatorMessage: 'O CPF é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              initialValue: cadastro.contato,
              update: notifier.updateContato,
              error: cadastro.contatoError,
              label: 'Telefone*',
              hint: '(00) 00000-0000',
              keyboardType: TextInputType.phone,
              validatorMessage: 'O telefone é obrigatório',
            ),
            const SizedBox(height: 14),
            _buildLabel('Aniversário*'),
            TextFormField(
              key: ValueKey(cadastro.nascimento),
              initialValue: dataFormatada,
              readOnly: true,
              decoration: InputDecoration(
                errorText: cadastro.nascimentoError,
                filled: true,
                fillColor: const Color(0xFFF5F7FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF08216F),
                ),
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'A data é obrigatória'
                  : null,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  notifier.updateNascimento(pickedDate);
                }
              },
            ),
            const SizedBox(height: 14),
            _buildDropdownField(
              label: 'Tipo sanguíneo*',
              value: cadastro.tipoSanguineo,
              items: TipoSanguineo.values,
              labelBuilder: (tipo) => tipo.nomeVisivel,
              onChanged: (value) {
                if (value != null) {
                  notifier.updateTipoSanguineo(value);
                }
              },
              validatorMessage: 'Selecione o tipo sanguíneo',
            ),
            const SizedBox(height: 14),
            _buildDropdownField(
              label: 'Faixa/Grau*',
              value: cadastro.faixa,
              items: Faixa.values,
              labelBuilder: (faixa) => faixa.nomeVisivel,
              onChanged: (value) {
                if (value != null) {
                  notifier.updateFaixa(value);
                }
              },
              validatorMessage: 'Selecione a faixa',
            ),
            const SizedBox(height: 14),
            _buildDropdownField(
              label: 'ID da ficha',
              value: idFicha,
              items: ['ID 001', 'ID 002', 'ID 003'],
              labelBuilder: (String value) => value,
              onChanged: onIdFichaChanged,
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

  Widget _buildDropdownField<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) labelBuilder,
    required ValueChanged<T?> onChanged,
    String? validatorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F7FB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          hint: Text(label.replaceAll('*', '')),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(labelBuilder(item)),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validatorMessage != null
              ? (v) => v == null ? validatorMessage : null
              : null,
        ),
      ],
    );
  }
}
