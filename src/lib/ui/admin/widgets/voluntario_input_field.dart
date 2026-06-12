import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/stores/cadastro_voluntario/cadastro_voluntario_form.dart';

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

class CadastroTextField extends ConsumerWidget {
  const CadastroTextField(this.type, {super.key});

  final InputTypes type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cadastroVoluntarioProvider.notifier);
    final cadastro = ref.watch(cadastroVoluntarioProvider);
    return TextFormField(
      keyboardType: switch (type) {
        InputTypes.email => TextInputType.emailAddress,
        InputTypes.telefone => TextInputType.phone,
        InputTypes.cpf => TextInputType.number,
        _ => null,
      },
      onChanged: switch (type) {
        InputTypes.nome => (nome) => notifier.updateNome(nome),
        InputTypes.email => (email) => notifier.updateEmail(email),
        InputTypes.senha => (senha) => notifier.updateSenha(senha),
        InputTypes.telefone => (telefone) => notifier.updateTelefone(telefone),
        InputTypes.cpf => (cpf) => notifier.updateCpf(cpf),
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
          InputTypes.nome => cadastro.nomeError,
          InputTypes.email => cadastro.emailError,
          InputTypes.senha => cadastro.senhaError,
          InputTypes.telefone => cadastro.telefoneError,
          InputTypes.cpf => cadastro.cpfError,
          InputTypes.funcao => null,
        },
      ),
    );
  }
}

class VoluntarioInputField extends StatelessWidget {
  const VoluntarioInputField({
    required this.type,
    required this.label,
    super.key,
  });

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
        CadastroTextField(type),
      ],
    );
  }
}
