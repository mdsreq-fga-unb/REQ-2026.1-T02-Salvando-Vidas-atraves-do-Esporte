import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/data/stores/update_aluno/update_aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/masks.dart';

class EditarAlunoPage extends ConsumerStatefulWidget {
  final Aluno aluno;
  final Responsavel? responsavel;

  const EditarAlunoPage({
    super.key,
    required this.aluno,
    required this.responsavel,
  });

  @override
  ConsumerState<EditarAlunoPage> createState() => _EditarAlunoPageState();
}

class _EditarAlunoPageState extends ConsumerState<EditarAlunoPage> {
  final _formKey = GlobalKey<FormState>();

  late final MaskTextInputFormatter formatCPF;
  late final MaskTextInputFormatter formatTelefone;
  late final MaskTextInputFormatter formatData;

  // Controlador específico para a data (para funcionar com digitação e calendário)
  final TextEditingController _aniversarioCtrl = TextEditingController();

  late UpdateAlunoState state;
  late UpdateAluno notifier;
  late AlunoService service;
  late Logger logger;

  @override
  void initState() {
    super.initState();
    formatCPF = maskCPF();
    formatTelefone = maskTelefone();
    formatData = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );

    // Preenche a data inicial do aluno
    final data = widget.aluno.nascimento;
    _aniversarioCtrl.text =
        "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  @override
  void dispose() {
    _aniversarioCtrl.dispose();
    super.dispose();
  }

  void _salvarAlteracoes() {
    // Valida se o formulário visual não tem erros antes de chamar o modal
    if (_formKey.currentState?.validate() ?? false) {
      if (state.estaValido) {
        _mostrarDialogConfirmacao();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preencha os campos obrigatórios corretamente.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _mostrarDialogConfirmacao() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Deseja salvar as\nalterações?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF08216F)),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF08216F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              Aluno aluno = state.aluno;
              Responsavel responsavel = state.responsavel;

              try {
                if (state.idade < 18) {
                  final res = await service.cadastrarResponsavel(responsavel);
                  aluno = aluno.copyWith(idResponsavel: res.id!);
                } else {
                  aluno.copyWith(idResponsavel: null);
                }

                await service.atualizaAluno(
                  widget.aluno.id!,
                  state.diffAluno(aluno),
                );
                await ref.refresh(pesquisaAlunoProvider.future);

                if (!mounted) return;
                Navigator.pop(ctx);
                Navigator.pop(context); // Fecha a tela de edição
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aluno atualizado com sucesso!'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } on AppApiException catch (e) {
                logger.e(e.message, error: e.error);
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(updateAlunoProvider(widget.aluno, widget.responsavel));
    notifier = ref.read(updateAlunoProvider(widget.aluno, widget.responsavel).notifier);
    service = ref.read(alunoServiceProvider);
    logger = ref.read(loggerProvider);

    // Condição para mostrar os dados do responsável
    final mostrarResponsavel = state.idade < 18 || widget.aluno.idResponsavel != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF08216F), size: 22),
          label: const Text(
            'Voltar',
            style: TextStyle(
              color: Color(0xFF08216F),
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
          constraints: const BoxConstraints(maxWidth: 600), // Responsividade
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x18000000),
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
                    'Editar Aluno',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08216F),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // O formulário inteiro agora rola numa página só!
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Dados Pessoais'),
                          _buildTextField('Nome:*', notifier.updateNome, state.nome, state.nomeError),
                          _buildTextField('CPF:*', notifier.updateCPF, state.cpf, state.cpfError, formatter: formatCPF),
                          _buildTextField('Telefone:*', notifier.updateContato, state.contato, state.contatoError, formatter: formatTelefone),
                          
                          // Novo Campo: Contato de Emergência
                          _buildTextField(
                            'Contato de Emergência:*', 
                            notifier.updateContatoEmergencia, // AVISO: Garanta que essa função exista no UpdateAlunoStore
                            state.contatoEmergencia ?? '', 
                            state.contatoEmergenciaError, 
                            formatter: formatTelefone
                          ),

                          _buildDateField(),

                          if (mostrarResponsavel) ...[
                            const SizedBox(height: 16),
                            _buildSectionTitle('Dados do Responsável'),
                            _buildTextField('Nome do Responsável:*', notifier.updateNomeResponsavel, state.nomeResponsavel, state.nomeResponsavelError),
                            _buildTextField('CPF do Responsável:*', notifier.updateCPFResponsavel, state.cpfResponsavel, state.cpfResponsavelError, formatter: formatCPF),
                            _buildTextField('Telefone do Responsável:*', notifier.updateContatoResponsavel, state.contatoResponsavel, state.contatoResponsavelError, formatter: formatTelefone),
                          ],

                          const SizedBox(height: 16),
                          _buildSectionTitle('Dados Institucionais'),
                          _buildDropdownEnum<TipoSanguineo>(
                            label: 'Tipo sanguíneo:*',
                            value: state.tipoSanguineo,
                            items: TipoSanguineo.values,
                            getName: (TipoSanguineo t) => t.nomeVisivel,
                            onChanged: (value) {
                              if (value != null) notifier.updateTipoSanguineo(value);
                            },
                          ),
                          _buildDropdownEnum<Faixa>(
                            label: 'Faixa/Grau:*',
                            value: state.faixa,
                            items: Faixa.values,
                            getName: (Faixa f) => f.nomeVisivel,
                            onChanged: (value) {
                              if (value != null) notifier.updateFaixa(value);
                            },
                          ),
                          _buildTextField('ID da ficha:*', notifier.updateIdFicha, state.idFicha, state.idFichaError),
                          const SizedBox(height: 20), // Respiro no final do scroll
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  
                  // Botão de Salvar Único
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF08216F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _salvarAlteracoes,
                      child: const Text('Salvar Alterações', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF11A6BF), // Ciano Escuro para separar as seções
        ),
      ),
    );
  }

  // Campo de Data Customizado e Blindado com Máscara
  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aniversário:*',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF08216F)),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: _aniversarioCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [formatData],
            decoration: InputDecoration(
              hintText: 'DD/MM/AAAA',
              errorText: state.nascimentoError,
              filled: true,
              fillColor: const Color(0xFFF5F7FB),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today, color: Color(0xFF08216F)),
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: state.nascimento ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    notifier.updateNascimento(pickedDate);
                    final dia = pickedDate.day.toString().padLeft(2, '0');
                    final mes = pickedDate.month.toString().padLeft(2, '0');
                    final ano = pickedDate.year.toString();
                    _aniversarioCtrl.text = "$dia/$mes/$ano";
                  }
                },
              ),
            ),
            onChanged: (value) {
              if (value.length == 10) {
                try {
                  final partes = value.split('/');
                  final data = DateTime(int.parse(partes[2]), int.parse(partes[1]), int.parse(partes[0]));
                  notifier.updateNascimento(data);
                } catch (_) {}
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    void Function(String) update,
    String initialValue,
    String? error, {
    MaskTextInputFormatter? formatter,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF08216F)),
          ),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: initialValue,
            onChanged: update,
            inputFormatters: formatter != null ? [formatter] : null,
            keyboardType: formatter != null ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              errorText: error,
              filled: true,
              fillColor: const Color(0xFFF5F7FB), // Padronizado
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownEnum<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) getName,
    required ValueChanged<T?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF08216F)),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<T>(
            value: value,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF08216F)),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF5F7FB), // Padronizado
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(getName(e)))).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}