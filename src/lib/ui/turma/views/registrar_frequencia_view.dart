import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart'; // Importamos o modelo explicitamente
import 'package:salvando_vidas/main_imports.dart';

class RegistrarFrequenciaView extends ConsumerStatefulWidget {
  final Turma turma;

  const RegistrarFrequenciaView({super.key, required this.turma});

  @override
  ConsumerState<RegistrarFrequenciaView> createState() =>
      _RegistrarFrequenciaViewState();
}

class _RegistrarFrequenciaViewState
    extends ConsumerState<RegistrarFrequenciaView> {
  final _formKey = GlobalKey<FormState>();
  late AsyncValue<PresencaState> state;
  late PresencaStore notifier;
  late PresencaService service;
  late Logger logger;

  final TextEditingController _dataController = TextEditingController();
  late final MaskTextInputFormatter formatData;

  // BLINDAGEM: Agora tipado estritamente como LocalUser em vez de dynamic
  LocalUser? _professorSelecionado; 
  DateTime? _dataSelecionada;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    formatData = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  void _mostrarDialogConfirmacao() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_professorSelecionado == null || _dataSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preencha o Professor e a Data antes de registrar.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Registrar Frequência?',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF08216F)),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF08216F),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (state.value == null) return; 
                  
                  try {
                    final presencas = state.value!.presenca;
                    final alunosPresentes = presencas.entries
                        .where((entry) => entry.value == true)
                        .map((entry) => entry.key)
                        .toList();

                    await service.cadastrarPresenca(
                      widget.turma.id,
                      _dataSelecionada!,
                      _professorSelecionado!.id!,
                      '',
                      alunosPresentes,
                    );
                    Navigator.of(ctx).pop(); 
                    _mostrarDialogSucesso(); 
                  } on AppApiException catch (e) {
                    logger.e(e.message, error: e);
                  } catch (e) {
                    logger.e('', error: e);
                  }
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );
    }
  }

  void _mostrarDialogSucesso() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'A frequência foi\nregistrada com sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF08216F),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              onPressed: () {
                Navigator.of(ctx).pop(); 
                Navigator.of(context).pop(); 
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(presencaStoreProvider(widget.turma.id));
    notifier = ref.read(presencaStoreProvider(widget.turma.id).notifier);
    service = ref.read(presencaServiceProvider);
    logger = ref.read(loggerProvider);

    if (_isFirstLoad && state.value != null) {
      _professorSelecionado = state.value!.professor;
      _dataSelecionada = state.value!.data;
      
      if (_dataSelecionada != null) {
        final dia = _dataSelecionada!.day.toString().padLeft(2, '0');
        final mes = _dataSelecionada!.month.toString().padLeft(2, '0');
        final ano = _dataSelecionada!.year.toString();
        _dataController.text = "$dia/$mes/$ano";
      }
      _isFirstLoad = false;
    }

    final usuarios = state.value?.usuarios ?? [];
    // Também definimos a variável dropdownValue explicitamente como LocalUser
    LocalUser? dropdownValue; 
    if (_professorSelecionado != null) {
      try {
        dropdownValue = usuarios.firstWhere((u) => u.id == _professorSelecionado!.id);
      } catch (_) {
        dropdownValue = null;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Registrar Frequência',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF08216F),
                          ),
                        ),
                        Text(
                          widget.turma.nome,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Passamos o tipo genérico <LocalUser> pro construtor pra garantir que o Flutter entenda
                        buildDropdownField<LocalUser>(
                          label: 'Instrutor/Professor da Aula:*',
                          value: dropdownValue, 
                          items: usuarios,
                          labelBuilder: (user) => user.nome,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _professorSelecionado = value; 
                              });
                              notifier.updateProfessor(value); 
                            }
                          },
                          validatorMessage: 'Selecione o professor responsável',
                        ),
                        const SizedBox(height: 16),

                        buildLabel('Data:*'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _dataController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [formatData],
                          decoration: InputDecoration(
                            hintText: 'DD/MM/AAAA',
                            filled: true,
                            fillColor: const Color(0xFFF5F7FB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today, color: Color(0xFF08216F)),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus(); 
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _dataSelecionada ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _dataSelecionada = picked; 
                                  });
                                  notifier.updateData(picked); 
                                  
                                  final dia = picked.day.toString().padLeft(2, '0');
                                  final mes = picked.month.toString().padLeft(2, '0');
                                  final ano = picked.year.toString();
                                  _dataController.text = "$dia/$mes/$ano";
                                }
                              },
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 10) {
                              try {
                                final partes = value.split('/');
                                final data = DateTime(
                                  int.parse(partes[2]),
                                  int.parse(partes[1]),
                                  int.parse(partes[0]),
                                );
                                setState(() {
                                  _dataSelecionada = data; 
                                });
                                notifier.updateData(data); 
                              } catch (e) {
                                // Ignora enquanto a pessoa estiver apagando ou escrevendo errado
                              }
                            }
                          },
                          validator: (val) => (val == null || val.isEmpty || val.length < 10)
                              ? 'A data é obrigatória e deve ser válida'
                              : null,
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          'Alunos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF08216F),
                          ),
                        ),
                        const SizedBox(height: 8),
                        state.when(
                          data: (state) => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.alunos.length,
                            itemBuilder: (context, index) {
                              final aluno = state.alunos[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Color(0xFFD8DDE6),
                                      radius: 18,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        aluno.nome,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Checkbox(
                                      value: state.presenca[aluno.id!],
                                      activeColor: const Color(0xFF08216F),
                                      side: const BorderSide(
                                        color: Color(0xFF999999),
                                      ),
                                      onChanged: (_) {
                                        setState(() {
                                          notifier.togglePresenca(aluno.id!);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          error: (error, stack) {
                            if (error is AppApiException) {
                              ref.read(loggerProvider).e(error.message, error: error.error);
                            }
                            return const Center(
                              child: Text('Erro ao carregar os alunos'),
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF08216F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _mostrarDialogConfirmacao,
                      child: const Text(
                        'Registrar Frequência',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}