import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/stores/cadastros/cadastro_voluntario_form.dart';

enum InputTypes { nome, email, senha, telefone, cpf, funcao }

final voluntarioInputDecoration = InputDecoration(
  hintStyle: const TextStyle(color: Color(0xAA000000), fontSize: 13),
  filled: true,
  fillColor: const Color(0xFFD8DDE6),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Color(0xFF2457F0), width: 1.2),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
);

class CadastroTextField extends StatelessWidget {
  const CadastroTextField(this.store, this.type, {super.key});

  final CadastroVoluntarioFormStore store;
  final InputTypes type;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => TextFormField(
        keyboardType: switch (type) {
          InputTypes.email => TextInputType.emailAddress,
          InputTypes.telefone => TextInputType.phone,
          InputTypes.cpf => TextInputType.number,
          _ => null,
        },
        onChanged: switch (type) {
          InputTypes.nome => (value) => store.nome = value,
          InputTypes.email => (value) => store.email = value,
          InputTypes.senha => (value) => store.senha = value,
          InputTypes.telefone => (value) => store.telefone = value,
          InputTypes.cpf => (value) => store.cpf = value,
          InputTypes.funcao => null,
        },
        style: const TextStyle(
          color: Color(0xFF24304D),
          fontWeight: FontWeight.w600,
        ),
        decoration: voluntarioInputDecoration.copyWith(
          hintText: switch (type) {
            InputTypes.nome => 'Digite o nome completo',
            InputTypes.email => 'Digite o email do voluntário',
            InputTypes.senha => 'Digite a senha do voluntário',
            InputTypes.telefone => 'Digite o telefone de contato',
            InputTypes.cpf => 'Digite o CPF do voluntário',
            InputTypes.funcao => 'Ex.: professor, monitor, apoio',
          },
          errorText: switch (type) {
            InputTypes.nome => store.error.nome,
            InputTypes.email => store.error.email,
            InputTypes.senha => store.error.senha,
            InputTypes.telefone => store.error.telefone,
            InputTypes.cpf => store.error.cpf,
            InputTypes.funcao => null,
          },
        ),
      ),
    );
  }
}

class VoluntarioInputField extends StatelessWidget {
  const VoluntarioInputField({
    required this.store,
    required this.type,
    required this.label,
    super.key,
  });

  final CadastroVoluntarioFormStore store;
  final InputTypes type;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF10A9D0),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        CadastroTextField(store, type),
      ],
    );
  }
}
