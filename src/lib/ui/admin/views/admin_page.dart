import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/stores/cadastro_voluntario/cadastro_voluntario_form.dart';
import 'package:salvando_vidas/main_imports.dart';

import '../../cadastro_voluntario/widgets/action_button.dart';
import '../../cadastro_voluntario/widgets/expansion_action_card.dart';
import '../../cadastro_voluntario/widgets/input_field.dart';
import '../widgets/voluntario_input_field.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  final _volunteerFormKey = GlobalKey<FormState>();
  final _classFormKey = GlobalKey<FormState>();
  final _studentFormKey = GlobalKey<FormState>();

  final _classNameController = TextEditingController();
  final _classAgeGroupController = TextEditingController();
  final _classDaysController = TextEditingController();
  final _classStartTimeController = TextEditingController();
  final _classEndTimeController = TextEditingController();
  final _classResponsibleController = TextEditingController();

  final _studentNameController = TextEditingController();
  final _studentBirthDateController = TextEditingController();
  final _studentDocumentController = TextEditingController();
  final _studentResponsibleNameController = TextEditingController();
  final _studentResponsiblePhoneController = TextEditingController();
  final _studentResponsibleEmailController = TextEditingController();

  bool _volunteerExpanded = false;
  bool _classExpanded = false;
  bool _studentExpanded = false;

  @override
  void dispose() {
    _classNameController.dispose();
    _classAgeGroupController.dispose();
    _classDaysController.dispose();
    _classStartTimeController.dispose();
    _classEndTimeController.dispose();
    _classResponsibleController.dispose();
    _studentNameController.dispose();
    _studentBirthDateController.dispose();
    _studentDocumentController.dispose();
    _studentResponsibleNameController.dispose();
    _studentResponsiblePhoneController.dispose();
    _studentResponsibleEmailController.dispose();
    super.dispose();
  }

  void _togglePanel(String panel) {
    setState(() {
      if (panel == 'volunteer') {
        _volunteerExpanded = !_volunteerExpanded;
        _classExpanded = false;
        _studentExpanded = false;
        return;
      }

      if (panel == 'class') {
        _classExpanded = !_classExpanded;
        _volunteerExpanded = false;
        _studentExpanded = false;
        return;
      }

      _studentExpanded = !_studentExpanded;
      _volunteerExpanded = false;
      _classExpanded = false;
    });
  }

  void _showSections() {
    setState(() {
      _volunteerExpanded = false;
      _classExpanded = false;
      _studentExpanded = false;
    });
  }

  void _goBack() {
    context.go(Routes.home);
  }

  void _submitVolunteer() async {
    final cadastro = this.ref.read(cadastroVoluntarioProvider);
    if (!cadastro.podeCadastrar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Algum campo não foi preenchido corretamente.'),
        ),
      );
      return;
    }

    final voluntario = cadastro.voluntario;

    try {
      await ref.read(userServiceProvider).registerUser(voluntario);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voluntário cadastrado com sucesso.')),
      );
      _volunteerFormKey.currentState?.reset();
    } on AppApiException catch (e) {
      ref.read(loggerProvider).e(e.message, error: e.error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _submitClass() {
    if (_classFormKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Turma cadastrada com sucesso.')),
      );
      _classFormKey.currentState?.reset();
    }
  }

  void _submitStudent() {
    if (_studentFormKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluno e responsável cadastrados.')),
      );
      _studentFormKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F8F8), Color(0xFFE4E4E4)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
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
                        color: const Color(0xFF08216F),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x2A000000),
                            blurRadius: 22,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Painel do Administrador',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF10A9D0),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Toque em uma seção para abrir os campos de cadastro na mesma página.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    ExpansionActionCard(
                      title: 'Cadastrar voluntários',
                      subtitle: 'Nome, contato e função do colaborador',
                      icon: Icons.groups_outlined,
                      accentColor: const Color(0xFF11A6BF),
                      expanded: _volunteerExpanded,
                      onToggle: () => _togglePanel('volunteer'),
                      child: Form(
                        key: _volunteerFormKey,
                        child: Column(
                          children: [
                            CadastroTextField(InputTypes.nome),
                            const SizedBox(height: 14),
                            CadastroTextField(InputTypes.email),
                            const SizedBox(height: 14),
                            CadastroTextField(InputTypes.senha),
                            const SizedBox(height: 14),
                            CadastroTextField(InputTypes.telefone),
                            const SizedBox(height: 14),
                            CadastroTextField(InputTypes.cpf),
                            const SizedBox(height: 14),
                            CadastroTextField(InputTypes.funcao),
                            const SizedBox(height: 18),
                            ActionButton(
                              label: 'Salvar voluntário',
                              onPressed: _submitVolunteer,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ExpansionActionCard(
                      title: 'Cadastrar turmas',
                      subtitle: 'Faixa etária, dias, horários e responsável',
                      icon: Icons.calendar_month_outlined,
                      accentColor: const Color(0xFF2457F0),
                      expanded: _classExpanded,
                      onToggle: () => _togglePanel('class'),
                      child: Form(
                        key: _classFormKey,
                        child: Column(
                          children: [
                            InputField(
                              initialValue: '',
                              update: (value) {},
                              error: null,
                              label: 'Nome da turma',
                              hint: 'Digite o nome ou identificação',
                              validatorMessage: 'Informe o nome da turma',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              initialValue: '',
                              update: (value) {},
                              error: null,
                              label: 'Faixa etária',
                              hint: 'Ex.: 7 a 10 anos',
                              validatorMessage: 'Informe a faixa etária',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              initialValue: '',
                              update: (value) {},
                              error: null,
                              label: 'Dias da semana',
                              hint: 'Ex.: segunda e quarta',
                              validatorMessage: 'Informe os dias da semana',
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: InputField(
                                    initialValue: '',
                                    update: (value) {},
                                    error: null,
                                    label: 'Início',
                                    hint: '08:00',
                                    keyboardType: TextInputType.datetime,
                                    validatorMessage:
                                        'Informe o horário inicial',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InputField(
                                    initialValue: '',
                                    update: (value) {},
                                    error: null,
                                    label: 'Fim',
                                    hint: '10:00',
                                    keyboardType: TextInputType.datetime,
                                    validatorMessage: 'Informe o horário final',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              initialValue: '',
                              update: (value) {},
                              error: null,
                              label: 'Professor voluntário responsável',
                              hint: 'Digite o nome do responsável',
                              validatorMessage:
                                  'Informe o professor voluntário responsável',
                            ),
                            const SizedBox(height: 18),
                            ActionButton(
                              label: 'Salvar turma',
                              onPressed: _submitClass,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
