import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';
import 'package:salvando_vidas/ui/global/masks.dart';

class EtapaDadosResponsavel extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const EtapaDadosResponsavel({super.key, required this.formKey});

  @override
  ConsumerState<EtapaDadosResponsavel> createState() =>
      _EtapaDadosResponsavelState();
}

class _EtapaDadosResponsavelState extends ConsumerState<EtapaDadosResponsavel> {
  late final MaskTextInputFormatter formatCPF;
  late final MaskTextInputFormatter formatTelefone;

  @override
  void initState() {
    super.initState();
    formatCPF = maskCPF();
    formatTelefone = maskTelefone();
  }

  @override
  Widget build(BuildContext context) {
    final cadastro = ref.watch(cadastroAlunoProvider);
    final notifier = ref.read(cadastroAlunoProvider.notifier);

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            initialValue: formatCPF.maskText(cadastro.cpfResponsavel),
            update: (_) =>
                notifier.updateCPFResponsavel(formatCPF.getUnmaskedText()),
            error: cadastro.cpfResponsavelError,
            label: 'CPF do Responsável*',
            hint: '000.000.000-00',
            keyboardType: TextInputType.number,
            validatorMessage: 'Informe um CPF válido',
            inputFormatters: [formatCPF],
          ),
          const SizedBox(height: 14),
          InputField(
            initialValue: formatTelefone.maskText(
              cadastro.contatoResponsavel,
            ),
            update: (_) => notifier.updateContatoResponsavel(
              formatTelefone.getUnmaskedText(),
            ),
            error: cadastro.contatoResponsavelError,
            label: 'Contato do Responsável*',
            hint: '(00) 00000-0000',
            keyboardType: TextInputType.phone,
            validatorMessage: 'O telefone é obrigatório',
            inputFormatters: [formatTelefone],
          ),
          const SizedBox(height: 14),
          InputField(
            initialValue: cadastro.emailResponsavel,
            update: notifier.updateEmailResponsavel,
            error: cadastro.emailResponsavelError,
            label: 'Email do Responsável*',
            hint: 'email@email.com',
            keyboardType: TextInputType.emailAddress,
            validatorMessage: 'O email é obrigatório',
          ),
        ],
      ),
    );
  }
}
