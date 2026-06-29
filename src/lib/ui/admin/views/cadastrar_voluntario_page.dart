import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/cadastro_voluntario/cadastro_voluntario_form.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';
import 'package:salvando_vidas/ui/global/masks.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class CadastrarVoluntarioPage extends ConsumerStatefulWidget {
  const CadastrarVoluntarioPage({super.key});

  @override
  ConsumerState<CadastrarVoluntarioPage> createState() =>
      _CadastrarVoluntarioPageState();
}

class _CadastrarVoluntarioPageState
    extends ConsumerState<CadastrarVoluntarioPage> {
  final _formKey = GlobalKey<FormState>();

  late final MaskTextInputFormatter formatCPF;
  late final MaskTextInputFormatter formatTelefone;

  @override
  void initState() {
    super.initState();
    formatCPF = maskCPF();
    formatTelefone = maskTelefone();
  }

  Future<void> _salvar() async {
    final cadastro = ref.read(cadastroVoluntarioProvider);
    final notifier = ref.read(cadastroVoluntarioProvider.notifier);

    if (!(_formKey.currentState?.validate() ?? false) || !cadastro.podeCadastrar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios corretamente.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final confirm = await _mostrarDialogConfirmacao();
    if (!confirm || !mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ref.read(userServiceProvider).registerUser(cadastro.voluntario);
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      ref.invalidate(cadastroVoluntarioProvider);
      _formKey.currentState?.reset();
      formatCPF.clear();
      formatTelefone.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voluntário cadastrado com sucesso!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on AppApiException catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      ref.read(loggerProvider).e(e.message, error: e.error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<bool> _mostrarDialogConfirmacao() async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Confirmar Cadastro',
              style: TextStyle(color: AppColors.deepNavy),
            ),
            content: const Text(
              'Deseja realmente salvar as informações deste voluntário?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: AppColors.error),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final cadastro = ref.watch(cadastroVoluntarioProvider);
    final notifier = ref.read(cadastroVoluntarioProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.platinum,
      appBar: AppBar(
        backgroundColor: AppColors.platinum,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,
              color: AppColors.deepNavy, size: 22),
          label: const Text(
            'Voltar',
            style: TextStyle(
              color: AppColors.deepNavy,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cadastrar Voluntário',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Dados Pessoais'),
                          InputField(
                            initialValue: cadastro.nome,
                            update: notifier.updateNome,
                            error: cadastro.nomeError,
                            label: 'Nome completo*',
                            hint: 'Digite o nome completo',
                            validatorMessage: 'O nome é obrigatório',
                          ),
                          const SizedBox(height: 12),
                          InputField(
                            initialValue: formatCPF.maskText(cadastro.cpf),
                            update: (_) =>
                                notifier.updateCpf(formatCPF.getUnmaskedText()),
                            error: cadastro.cpfError,
                            label: 'CPF*',
                            hint: '000.000.000-00',
                            keyboardType: TextInputType.number,
                            validatorMessage: 'Informe um CPF válido',
                            inputFormatters: [formatCPF],
                          ),
                          const SizedBox(height: 12),
                          InputField(
                            initialValue:
                                formatTelefone.maskText(cadastro.telefone),
                            update: (_) => notifier.updateTelefone(
                                formatTelefone.getUnmaskedText()),
                            error: cadastro.telefoneError,
                            label: 'Telefone*',
                            hint: '(00) 00000-0000',
                            keyboardType: TextInputType.phone,
                            validatorMessage: 'Informe um telefone válido',
                            inputFormatters: [formatTelefone],
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Acesso ao Sistema'),
                          InputField(
                            initialValue: cadastro.email,
                            update: notifier.updateEmail,
                            error: cadastro.emailError,
                            label: 'Email*',
                            hint: 'email@exemplo.com',
                            keyboardType: TextInputType.emailAddress,
                            validatorMessage: 'Informe um email válido',
                          ),
                          const SizedBox(height: 12),
                          InputField(
                            initialValue: cadastro.senha,
                            update: notifier.updateSenha,
                            error: cadastro.senhaError,
                            label: 'Senha*',
                            hint: 'Digite a senha de acesso',
                            validatorMessage: 'A senha é obrigatória',
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Dados Institucionais'),
                          InputField(
                            initialValue: cadastro.funcao,
                            update: notifier.updateFuncao,
                            error: cadastro.funcaoError,
                            label: 'Função*',
                            hint: 'Ex.: professor, monitor, apoio',
                            validatorMessage: 'Informe a função',
                          ),
                          const SizedBox(height: 12),
                          _buildFaixaDropdown(cadastro, notifier),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepNavy,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _salvar,
                      child: const Text(
                        'Cadastrar Voluntário',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.cyanPrimary,
        ),
      ),
    );
  }

  Widget _buildFaixaDropdown(
      CadastroVoluntarioState cadastro, CadastroVoluntario notifier) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('Faixa/Grau*'),
          const SizedBox(height: 6),
          DropdownButtonFormField<Faixa>(
            value: cadastro.faixa,
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.deepNavy),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.platinum,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: Faixa.values
                .map((f) =>
                    DropdownMenuItem(value: f, child: Text(f.nomeVisivel)))
                .toList(),
            onChanged: (value) {
              if (value != null) notifier.updateFaixa(value);
            },
          ),
        ],
      ),
    );
  }
}