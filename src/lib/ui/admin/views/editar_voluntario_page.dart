import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';
import 'package:salvando_vidas/ui/global/masks.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Tela de busca de voluntários
// ─────────────────────────────────────────────────────────────────────────────

class EditarVoluntarioPage extends ConsumerStatefulWidget {
  const EditarVoluntarioPage({super.key});

  @override
  ConsumerState<EditarVoluntarioPage> createState() =>
      _EditarVoluntarioPageState();
}

class _EditarVoluntarioPageState extends ConsumerState<EditarVoluntarioPage> {
  final _searchCtrl = TextEditingController();
  List<LocalUser> _todos = [];
  List<LocalUser> _filtrados = [];
  bool _carregando = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _carregar() async {
    try {
      final users = await ref.read(userServiceProvider).listUsers();
      setState(() {
        _todos = users;
        _filtrados = users;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erro = 'Erro ao carregar voluntários.';
        _carregando = false;
      });
    }
  }

  void _filtrar(String query) {
    final q = query.toLowerCase().trim();
    setState(() {
      _filtrados = q.isEmpty
          ? _todos
          : _todos
              .where((u) =>
                  u.nome.toLowerCase().contains(q) ||
                  u.email.toLowerCase().contains(q))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? AppColors.darkBg : AppColors.platinum;
    final containerBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: pageBg,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,
              color: textColor, size: 22),
          label: Text(
            'Voltar',
            style: TextStyle(
              color: textColor,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: containerBg,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchCtrl,
                onChanged: _filtrar,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'Buscar por nome ou email',
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.cyanPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _erro != null
                    ? Center(
                        child: Text(_erro!,
                            style:
                                const TextStyle(color: AppColors.error)))
                    : _filtrados.isEmpty
                        ? const Center(
                            child: Text('Nenhum voluntário encontrado.',
                                style: TextStyle(
                                    color: AppColors.textSecondary)))
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                            itemCount: _filtrados.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, i) {
                              final user = _filtrados[i];
                              return _VoluntarioTile(
                                user: user,
                                onEditado: _carregar,
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tile do voluntário na lista
// ─────────────────────────────────────────────────────────────────────────────

class _VoluntarioTile extends StatelessWidget {
  const _VoluntarioTile({required this.user, required this.onEditado});

  final LocalUser user;
  final VoidCallback onEditado;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(14),
      elevation: 1,
      shadowColor: isDark ? Colors.black54 : AppColors.shadowLight,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => _EditarVoluntarioForm(user: user),
            ),
          );
          onEditado();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.cyanPrimary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_outline,
                    color: AppColors.cyanPrimary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.nome,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.funcao,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: AppColors.cyanPrimary, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Formulário de edição de voluntário
// ─────────────────────────────────────────────────────────────────────────────

class _EditarVoluntarioForm extends ConsumerStatefulWidget {
  const _EditarVoluntarioForm({required this.user});

  final LocalUser user;

  @override
  ConsumerState<_EditarVoluntarioForm> createState() =>
      _EditarVoluntarioFormState();
}

class _EditarVoluntarioFormState
    extends ConsumerState<_EditarVoluntarioForm> {
  final _formKey = GlobalKey<FormState>();

  late final MaskTextInputFormatter formatCPF;
  late final MaskTextInputFormatter formatTelefone;

  late String _nome;
  late String _email;
  late String _telefone;
  late String _cpf;
  late String _funcao;
  late Faixa _faixa;
  String _senha = '';

  @override
  void initState() {
    super.initState();
    formatCPF = maskCPF();
    formatTelefone = maskTelefone();

    _nome = widget.user.nome;
    _email = widget.user.email;
    _telefone = widget.user.telefone;
    _cpf = widget.user.cpf;
    _funcao = widget.user.funcao;
    _faixa = widget.user.faixa;
  }

  Future<void> _salvar() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha os campos obrigatórios corretamente.'),
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

    final diff = <String, dynamic>{
      'p_id': widget.user.id,
      'p_nome': _nome,
      'p_email': _email,
      'p_telefone': _telefone,
      'p_cpf': _cpf,
      'p_funcao': _funcao,
      if (_senha.isNotEmpty) 'p_senha': _senha,
    };

    try {
      await ref.read(userServiceProvider).updateUser(diff);
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // fecha loading
      Navigator.of(context).pop(); // fecha form

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voluntário atualizado com sucesso!'),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: Text(
              'Deseja salvar as\nalterações?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.deepNavy),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancelar',
                    style: TextStyle(color: AppColors.error)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? AppColors.darkBg : AppColors.platinum;
    final containerBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: pageBg,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,
              color: textColor, size: 22),
          label: Text(
            'Voltar',
            style: TextStyle(
              color: textColor,
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
              color: containerBg,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black54 : AppColors.shadowLight,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
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
                  Text(
                    'Editar Voluntário',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Dados Pessoais'),
                          _buildField(
                            label: 'Nome completo*',
                            initial: _nome,
                            hint: 'Digite o nome completo',
                            onChanged: (v) => _nome = v,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'O nome é obrigatório'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          _buildMaskedField(
                            label: 'CPF*',
                            initial: formatCPF.maskText(_cpf),
                            hint: '000.000.000-00',
                            formatter: formatCPF,
                            onChanged: (_) =>
                                _cpf = formatCPF.getUnmaskedText(),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'O CPF é obrigatório'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          _buildMaskedField(
                            label: 'Telefone*',
                            initial: formatTelefone.maskText(_telefone),
                            hint: '(00) 00000-0000',
                            formatter: formatTelefone,
                            keyboardType: TextInputType.phone,
                            onChanged: (_) =>
                                _telefone = formatTelefone.getUnmaskedText(),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'O telefone é obrigatório'
                                    : null,
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Acesso ao Sistema'),
                          _buildField(
                            label: 'Email*',
                            initial: _email,
                            hint: 'email@exemplo.com',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (v) => _email = v,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'O email é obrigatório'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          _buildField(
                            label: 'Nova senha (deixe em branco para manter)',
                            initial: '',
                            hint: 'Digite nova senha',
                            onChanged: (v) => _senha = v,
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Dados Institucionais'),
                          _buildField(
                            label: 'Função*',
                            initial: _funcao,
                            hint: 'Ex.: professor, monitor, apoio',
                            onChanged: (v) => _funcao = v,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'A função é obrigatória'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          _buildFaixaDropdown(),
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
                        'Salvar Alterações',
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

  Widget _buildField({
    required String label,
    required String initial,
    required String hint,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark ? AppColors.darkInputFill : AppColors.platinum;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel(label),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: initial,
            onChanged: onChanged,
            keyboardType: keyboardType,
            validator: validator,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: fillColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.royalAzure, width: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaskedField({
    required String label,
    required String initial,
    required String hint,
    required MaskTextInputFormatter formatter,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark ? AppColors.darkInputFill : AppColors.platinum;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel(label),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: initial,
            onChanged: onChanged,
            keyboardType: keyboardType ?? TextInputType.number,
            inputFormatters: [formatter],
            validator: validator,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: fillColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.royalAzure, width: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaixaDropdown() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark ? AppColors.darkInputFill : AppColors.platinum;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('Faixa/Grau*'),
          const SizedBox(height: 6),
          DropdownButtonFormField<Faixa>(
            value: _faixa,
            dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
            icon: Icon(Icons.arrow_drop_down, color: textColor),
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: Faixa.values
                .map((f) => DropdownMenuItem(value: f, child: Text(f.nomeVisivel, style: TextStyle(color: textColor))))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _faixa = value);
            },
          ),
        ],
      ),
    );
  }
}