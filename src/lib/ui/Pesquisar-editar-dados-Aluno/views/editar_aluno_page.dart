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
  final PageController _pageController = PageController();
  int _etapaAtual = 0;

  late TextEditingController _nomeCtrl;
  late TextEditingController _cpfCtrl;
  late TextEditingController _telefoneCtrl;
  late TextEditingController _aniversarioCtrl;
  late TextEditingController _idFichaCtrl;

  Faixa? _faixaSelecionada;
  TipoSanguineo? _tipoSanguineoSelecionado;

  final TextEditingController _nomeRespCtrl = TextEditingController();
  final TextEditingController _cpfRespCtrl = TextEditingController();
  final TextEditingController _telefoneRespCtrl = TextEditingController();

  late final MaskTextInputFormatter formatCPF;
  late final MaskTextInputFormatter formatTelefone;

  late UpdateAlunoState state;
  late UpdateAluno notifier;
  late AlunoService service;
  late Logger logger;

  @override
  void initState() {
    super.initState();
    formatCPF = maskCPF();
    formatTelefone = maskTelefone();

    _nomeCtrl = TextEditingController(text: widget.aluno.nome);
    _cpfCtrl = TextEditingController(text: widget.aluno.cpf);
    _telefoneCtrl = TextEditingController(text: widget.aluno.contato ?? '');

    final data = widget.aluno.nascimento;
    _aniversarioCtrl = TextEditingController(
      text:
          "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}",
    );

    _idFichaCtrl = TextEditingController(
      text: widget.aluno.idFicha?.toString() ?? '',
    );
    _faixaSelecionada = widget.aluno.faixa;
    _tipoSanguineoSelecionado = widget.aluno.tipoSanguineo;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nomeCtrl.dispose();
    _cpfCtrl.dispose();
    _telefoneCtrl.dispose();
    _aniversarioCtrl.dispose();
    _idFichaCtrl.dispose();
    _nomeRespCtrl.dispose();
    _cpfRespCtrl.dispose();
    _telefoneRespCtrl.dispose();
    super.dispose();
  }

  void _avancarOuSalvar() {
    if (state.estaValido) {
      if (_etapaAtual == 0 && state.idade < 18) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else if (state.temResponsavel) {
        _mostrarDialogConfirmacao();
      }
    }
  }

  void _mostrarDialogConfirmacao() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Deseja salvar as\nalterações?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD9D9D9),
              foregroundColor: Colors.black,
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BCD4),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Aluno aluno = state.aluno;
              Responsavel responsavel = state.responsavel;

              try {
                if (state.idade < 18) {
                  final res = await service.cadastrarResponsavel(responsavel);
                  aluno = aluno.copyWith(idResponsavel: res.id!);
                }

                await service.atualizaAluno(widget.aluno.id!, aluno.toMap());
                await ref.refresh(pesquisaAlunoProvider.future);

                Navigator.pop(ctx);
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(
                        content: Text('Aluno atualizado com sucesso!'),
                      ),
                    )
                    .closed
                    .then((_) {
                      if (context.mounted) {
                        Navigator.pop(
                          context,
                        ); // Fecha a página de edição após o SnackBar
                      }
                    });
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
    notifier = ref.read(
      updateAlunoProvider(widget.aluno, widget.responsavel).notifier,
    );
    service = ref.read(alunoServiceProvider);
    logger = ref.read(loggerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF00BCD4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _etapaAtual == 0
                    ? 'Editar Aluno:'
                    : 'Editar Aluno (< 18 anos):',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 400,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (idx) => setState(() => _etapaAtual = idx),
                  children: [_buildEtapa1(), _buildEtapa2()],
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9D9D9),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      if (_etapaAtual == 0) {
                        Navigator.pop(context);
                      } else {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: const Text('Voltar'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BCD4),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _avancarOuSalvar,
                    child: Text(
                      _etapaAtual == 0 && widget.aluno.idResponsavel != null
                          ? 'Avançar'
                          : 'Salvar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEtapa1() {
    final dataFormatada = state.nascimento != null
        ? "${state.nascimento!.day.toString().padLeft(2, '0')}/${state.nascimento!.month.toString().padLeft(2, '0')}/${state.nascimento!.year}"
        : '';
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            'Nome:*',
            notifier.updateNome,
            state.nome,
            state.nomeError,
          ),
          _buildTextField(
            'CPF:*',
            notifier.updateCPF,
            state.cpf,
            state.cpfError,
          ),
          _buildTextField(
            'Telefone:*',
            notifier.updateContato,
            state.contato,
            state.contatoError,
          ),
          _buildTextField(
            'Aniversário:*',
            (data) => notifier.updateNascimento(DateTime.parse(data)),
            dataFormatada,
            state.nascimentoError,
            isDate: true,
          ),

          _buildDropdownEnum<TipoSanguineo>(
            label: 'Tipo sanguíneo:*',
            value: state.tipoSanguineo,
            items: TipoSanguineo.values,
            getName: (TipoSanguineo t) => t.nomeVisivel,
            onChanged: (value) {
              if (value != null) {
                notifier.updateTipoSanguineo(value);
              }
            },
          ),

          _buildDropdownEnum<Faixa>(
            label: 'Faixa/Grau:*',
            value: state.faixa,
            items: Faixa.values,
            getName: (Faixa f) => f.nomeVisivel,
            onChanged: (value) {
              if (value != null) {
                notifier.updateFaixa(value);
              }
            },
          ),

          _buildTextField(
            'ID da ficha:*',
            notifier.updateIdFicha,
            state.idFicha,
            state.idFichaError,
          ),
        ],
      ),
    );
  }

  Widget _buildEtapa2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            'Nome do Responsável:*',
            notifier.updateNomeResponsavel,
            state.nomeResponsavel,
            state.nomeResponsavelError,
          ),
          _buildTextField(
            'CPF do Responsável:*',
            notifier.updateCPFResponsavel,
            state.cpfResponsavel,
            state.cpfResponsavelError,
          ),
          _buildTextField(
            'Telefone do Responsável:*',
            notifier.updateContatoResponsavel,
            state.contatoResponsavel,
            state.contatoResponsavelError,
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
    bool isDate = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          TextFormField(
            key: switch (isDate) {
              false => null,
              true => ValueKey(state.nascimento),
            },
            readOnly: isDate,
            initialValue: initialValue,
            onChanged: update,
            onTap: switch (isDate) {
              false => () {},
              true => () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: state.nascimento ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  notifier.updateNascimento(pickedDate);
                }
              },
            },
            decoration: InputDecoration(
              errorText: error,
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              suffixIcon: isDate
                  ? const Icon(Icons.calendar_today, size: 20)
                  : null,
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
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<T>(
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(getName(e))))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
