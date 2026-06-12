import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';

class EtapaDadosResponsavel extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController telefoneController;

  const EtapaDadosResponsavel({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.cpfController,
    required this.telefoneController,
  });

  @override
  ConsumerState<EtapaDadosResponsavel> createState() =>
      _EtapaDadosResponsavelState();
}

class _EtapaDadosResponsavelState extends ConsumerState<EtapaDadosResponsavel> {
  bool? _isMenorDeIdade = true;

  @override
  Widget build(BuildContext context) {
    final cadastro = ref.watch(cadastroAlunoProvider);
    final notifier = ref.read(cadastroAlunoProvider.notifier);

    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'O aluno é menor de 18 anos?',
            //   style: TextStyle(
            //     color: Color(0xFF08216F),
            //     fontWeight: FontWeight.w700,
            //     fontSize: 14,
            //   ),
            // ),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     _buildRadioOption(true, 'Sim'),
            //     const SizedBox(width: 16),
            //     _buildRadioOption(false, 'Não'),
            //   ],
            // ),
            // const SizedBox(height: 24),
            if (_isMenorDeIdade == true) ...[
              InputField(
                initialValue: cadastro.nomeResponsavel,
                update: notifier.updateNomeResponsavel,
                error: cadastro.nomeResponsavelError,
                label: 'Nome do Responsável*',
                hint: 'Digite o nome completo',
                validatorMessage: 'O nome é obrigatório',
              ),
              const SizedBox(height: 14),
              InputField(
                initialValue: cadastro.cpfResponsavel,
                update: notifier.updateCPFResponsavel,
                error: cadastro.cpfResponsavelError,
                label: 'CPF do Responsável*',
                hint: '000.000.000-00',
                keyboardType: TextInputType.number,
                validatorMessage: 'O CPF é obrigatório',
              ),
              const SizedBox(height: 14),
              InputField(
                initialValue: cadastro.contatoResponsavel,
                update: notifier.updateContatoResponsavel,
                error: cadastro.contatoResponsavelError,
                label: 'Telefone do Responsável*',
                hint: '(00) 00000-0000',
                keyboardType: TextInputType.phone,
                validatorMessage: 'O telefone é obrigatório',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(bool value, String label) {
    return InkWell(
      onTap: () => _atualizarSelecao(value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<bool>(
            value: value,
            groupValue: _isMenorDeIdade,
            onChanged: (bool? v) {
              if (v != null) _atualizarSelecao(v);
            },
            activeColor: const Color(0xFF08216F),
          ),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _atualizarSelecao(bool value) {
    setState(() {
      _isMenorDeIdade = value;
      if (!value) {
        widget.nomeController.clear();
        widget.cpfController.clear();
        widget.telefoneController.clear();
      }
    });
  }
}
