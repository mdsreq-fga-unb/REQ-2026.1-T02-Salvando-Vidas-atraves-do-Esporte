import '../cadastro_imports.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({super.key});

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  final _studentFormKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _studentBirthDateController = TextEditingController();
  final _studentDocumentController = TextEditingController();
  final _studentResponsibleNameController = TextEditingController();
  final _studentResponsiblePhoneController = TextEditingController();
  final _studentResponsibleEmailController = TextEditingController();

  bool _studentExpanded = true;
  String? _selectedTurma;
  final List<String> _turmas = ['1', '2', '3', '4'];

  @override
  void dispose() {
    _studentNameController.dispose();
    _studentBirthDateController.dispose();
    _studentDocumentController.dispose();
    _studentResponsibleNameController.dispose();
    _studentResponsiblePhoneController.dispose();
    _studentResponsibleEmailController.dispose();
    super.dispose();
  }

  void _toggleStudentPanel() {
    setState(() {
      _studentExpanded = !_studentExpanded;
    });
  }

  void _submitStudent() {
    // executa o cadastro (aqui apenas simula sucesso)
    if (_studentFormKey.currentState?.validate() ?? false) {
      _studentFormKey.currentState?.reset();
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('O aluno foi cadastrado com sucesso!', textAlign: TextAlign.center),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10A9D0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                    child: Text('Fechar'),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _confirmSubmit() {
    if (!(_studentFormKey.currentState?.validate() ?? false)) return;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Confirmar Cadastro?'),
          content: const Text('Deseja confirmar o cadastro deste aluno?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _submitStudent();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10A9D0)),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
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
              padding: EdgeInsets.fromLTRB(18, 18, 18,
                  MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight + 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 6),
                    ExpansionActionCard(
                      title: 'Cadastrar alunos',
                      subtitle: 'Aluno, responsáveis e vínculo inicial',
                      icon: Icons.person_add_alt_1_outlined,
                      accentColor: const Color(0xFF0B7FA5),
                      backgroundColor: const Color(0xFFEAF6FA),
                      expanded: _studentExpanded,
                      onToggle: _toggleStudentPanel,
                      child: Form(
                        key: _studentFormKey,
                        child: Column(
                          children: [
                            InputField(
                              controller: _studentNameController,
                              label: 'Nome*',
                              hint: 'Digite o nome completo do aluno',
                              validatorMessage: 'Informe o nome do aluno',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentDocumentController,
                              label: 'CPF*',
                              hint: '000.000.000-00',
                              keyboardType: TextInputType.number,
                              validatorMessage: 'Informe o CPF do aluno',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsibleEmailController,
                              label: 'E-mail*',
                              hint: 'email@exemplo.com',
                              keyboardType: TextInputType.emailAddress,
                              validatorMessage: 'Informe o e-mail',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsiblePhoneController,
                              label: 'Telefone*',
                              hint: '(00) 00000-0000',
                              keyboardType: TextInputType.phone,
                              validatorMessage: 'Informe o telefone',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentBirthDateController,
                              label: 'Aniversário',
                              hint: 'DD/MM/AAAA',
                              keyboardType: TextInputType.datetime,
                              validatorMessage: '',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(height: 14),
                            DropdownButtonFormField<String>(
                              value: _selectedTurma,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              ),
                              hint: const Text('Turma*'),
                              items: _turmas.map((t) => DropdownMenuItem(value: t, child: Text('Turma $t'))).toList(),
                              onChanged: (v) => setState(() => _selectedTurma = v),
                              validator: (v) => v == null ? 'Informe a turma' : null,
                            ),
                            const SizedBox(height: 18),
                            ActionButton(
                              label: '+ Cadastrar Aluno',
                              onPressed: _confirmSubmit,
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
