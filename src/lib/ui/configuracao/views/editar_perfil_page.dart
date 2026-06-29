import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/update_voluntario/update_voluntario_store.dart';
import 'package:salvando_vidas/main_imports.dart';

// Importações dos seus componentes customizados
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/action_button.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class EditarPerfilPage extends ConsumerStatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();
  late UpdateVoluntarioState state;
  late UpdateVoluntario notifier;
  late Logger logger;

  void _salvarAlteracoes() async {
    // Aciona a validação visual do Form antes de prosseguir
    if (_formKey.currentState?.validate() ?? false) {
      if (state.podeCadastrar) {
        try {
          final diff = state.diff;
          await ref.read(userServiceProvider).updateUser(diff);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil atualizado com sucesso!')),
          );
          context.pop(); // Retorna para a tela de configurações
        } on AppApiException catch (e) {
          logger.e('', error: e.error);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(updateVoluntarioProvider);
    notifier = ref.read(updateVoluntarioProvider.notifier);
    logger = ref.read(loggerProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topbarBg = isDark ? AppColors.darkTopbar : AppColors.cyanPrimary;
    final gradientColors = isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;
    final containerBg = isDark ? AppColors.darkSurface : Colors.white;
    final avatarBg = isDark ? const Color(0xFF161B22) : AppColors.white2;
    final textColor = isDark ? Colors.white : AppColors.black1;
    final cardShadows = AppColors.cardShadow(isDark);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: topbarBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 26,
                        ),
                        decoration: BoxDecoration(
                          color: containerBg,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: cardShadows,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: avatarBg,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.royalAzure,
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seus Dados',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Atualize suas informações pessoais abaixo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 1. Nome Completo
                            InputField(
                              initialValue: state.nome,
                              update: notifier.updateNome,
                              error: state.nomeError,
                              label: 'Nome Completo',
                              hint: 'Digite o nome completo',
                              validatorMessage: 'Informe seu nome',
                            ),
                            const SizedBox(height: 14),

                            // 2. Email
                            InputField(
                              initialValue: state.email,
                              update: notifier.updateEmail,
                              error: state.emailError,
                              label: 'E-mail',
                              hint: 'Digite o email do voluntário',
                              keyboardType: TextInputType.emailAddress,
                              validatorMessage: 'Informe seu e-mail',
                            ),
                            const SizedBox(height: 14),

                            // 3. Senha (Opcional na edição)
                            InputField(
                              initialValue: state.senha,
                              update: notifier.updateSenha,
                              error: null,
                              label: 'Nova Senha (opcional)',
                              hint:
                                  'Digite a senha do voluntário (deixe em branco para manter)',
                              validatorMessage: '',
                            ),
                            const SizedBox(height: 14),

                            // 4. Telefone
                            InputField(
                              initialValue: state.telefone,
                              update: notifier.updateTelefone,
                              error: state.telefoneError,
                              label: 'Telefone',
                              hint: 'Digite o telefone de contato',
                              keyboardType: TextInputType.phone,
                              validatorMessage: 'Informe seu telefone',
                            ),
                            const SizedBox(height: 14),

                            // 5. CPF
                            InputField(
                              initialValue: state.cpf,
                              update: notifier.updateCpf,
                              error: state.cpfError,
                              label: 'CPF',
                              hint: 'Digite o CPF do voluntário',
                              keyboardType: TextInputType.number,
                              validatorMessage: 'Informe seu CPF',
                            ),
                            const SizedBox(height: 14),

                            // 6. Função
                            InputField(
                              initialValue: state.funcao,
                              update: notifier.updateFuncao,
                              error: state.funcaoError,
                              label: 'Função',
                              hint: 'Ex.: professor, monitor, apoio',
                              validatorMessage: 'Informe sua função',
                            ),

                            const SizedBox(height: 24),

                            ActionButton(
                              label: 'Salvar Alterações',
                              onPressed: _salvarAlteracoes,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}