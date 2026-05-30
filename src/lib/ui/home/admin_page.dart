import 'package:salvando_vidas/main_imports.dart';

import 'package:salvando_vidas/data/stores/cadastros/cadastro_voluntario_form.dart';

import 'widgets/voluntario_input_field.dart';

import 'components/expansion_action_card.dart';
import 'components/input_field.dart';
import 'components/action_button.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _volunteerFormKey = GlobalKey<FormState>();
  final _classFormKey = GlobalKey<FormState>();
  final _studentFormKey = GlobalKey<FormState>();

  final _cadastroVoluntario = CadastroVoluntarioFormStore();

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
  void initState() {
    super.initState();
    _cadastroVoluntario.setupValidations();
  }

  @override
  void dispose() {
    _cadastroVoluntario.dispose();
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
    if (_cadastroVoluntario.podeCadastrar) {
      try {
        await context.read<UserService>().registerUser(
          _cadastroVoluntario.email,
          _cadastroVoluntario.senha,
          _cadastroVoluntario.nome,
          _cadastroVoluntario.telefone,
          _cadastroVoluntario.cpf,
        );
      } catch (e) {
        context.read<Logger>().e("Erro ao cadastrar usuário", error: e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Houve um erro de conexão com o servidor, tente novamente mais tarde.',
            ),
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Voluntário cadastrado com sucesso.')),
      );
      _volunteerFormKey.currentState?.reset();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Algum campo não foi preenchido corretamente.'),
        ),
      );
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: _goBack,
                        icon: const Icon(Icons.arrow_back_outlined),
                        label: const Text('Voltar às seções'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF08216F),
                          side: const BorderSide(color: Color(0xFF08216F)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                            CadastroTextField(
                              _cadastroVoluntario,
                              InputTypes.nome,
                            ),
                            const SizedBox(height: 14),
                            CadastroTextField(
                              _cadastroVoluntario,
                              InputTypes.email,
                            ),
                            const SizedBox(height: 14),
                            CadastroTextField(
                              _cadastroVoluntario,
                              InputTypes.senha,
                            ),
                            const SizedBox(height: 14),
                            CadastroTextField(
                              _cadastroVoluntario,
                              InputTypes.telefone,
                            ),
                            const SizedBox(height: 14),
                            CadastroTextField(
                              _cadastroVoluntario,
                              InputTypes.cpf,
                            ),
                            const SizedBox(height: 14),
                            CadastroTextField(
                              _cadastroVoluntario,
                              InputTypes.funcao,
                            ),
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
                              controller: _classNameController,
                              label: 'Nome da turma',
                              hint: 'Digite o nome ou identificação',
                              validatorMessage: 'Informe o nome da turma',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _classAgeGroupController,
                              label: 'Faixa etária',
                              hint: 'Ex.: 7 a 10 anos',
                              validatorMessage: 'Informe a faixa etária',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _classDaysController,
                              label: 'Dias da semana',
                              hint: 'Ex.: segunda e quarta',
                              validatorMessage: 'Informe os dias da semana',
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: InputField(
                                    controller: _classStartTimeController,
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
                                    controller: _classEndTimeController,
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
                              controller: _classResponsibleController,
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
                    ExpansionActionCard(
                      title: 'Cadastrar alunos',
                      subtitle: 'Aluno, responsáveis e vínculo inicial',
                      icon: Icons.person_add_alt_1_outlined,
                      accentColor: const Color(0xFF0B7FA5),
                      expanded: _studentExpanded,
                      onToggle: () => _togglePanel('student'),
                      child: Form(
                        key: _studentFormKey,
                        child: Column(
                          children: [
                            InputField(
                              controller: _studentNameController,
                              label: 'Nome do aluno',
                              hint: 'Digite o nome completo do aluno',
                              validatorMessage: 'Informe o nome do aluno',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentBirthDateController,
                              label: 'Data de nascimento',
                              hint: 'DD/MM/AAAA',
                              keyboardType: TextInputType.datetime,
                              validatorMessage:
                                  'Informe a data de nascimento do aluno',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentDocumentController,
                              label: 'Matrícula ou documento',
                              hint: 'Número da matrícula ou documento',
                              validatorMessage:
                                  'Informe a matrícula ou documento',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsibleNameController,
                              label: 'Responsável legal',
                              hint: 'Nome do responsável legal',
                              validatorMessage: 'Informe o responsável legal',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsiblePhoneController,
                              label: 'Telefone do responsável',
                              hint: 'Telefone para contato',
                              keyboardType: TextInputType.phone,
                              validatorMessage:
                                  'Informe o telefone do responsável',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsibleEmailController,
                              label: 'Email do responsável',
                              hint: 'Email de contato',
                              keyboardType: TextInputType.emailAddress,
                              validatorMessage:
                                  'Informe o email do responsável',
                            ),
                            const SizedBox(height: 18),
                            ActionButton(
                              label: 'Salvar aluno',
                              onPressed: _submitStudent,
                            ),
                          ],
                        ),
                      ),
                    ),
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
