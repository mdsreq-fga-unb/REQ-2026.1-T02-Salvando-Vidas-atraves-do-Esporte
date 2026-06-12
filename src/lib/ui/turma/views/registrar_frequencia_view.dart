import 'package:salvando_vidas/data/services/presenca_service/presenca_service.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
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

  void _mostrarDialogConfirmacao() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              'Registrar Frequência?',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE0E0E0),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4), // Ciano
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (state.value == null || !state.value!.eValido) return;
                  try {
                    final presencas = state.value!.presenca;
                    final alunosPresentes = presencas.entries
                        .where((entry) => entry.value == true)
                        .map((entry) => entry.key)
                        .toList();

                    await service.cadastrarPresenca(
                      widget.turma.id,
                      state.value!.data,
                      state.value!.professor!.id!,
                      '',
                      alunosPresentes,
                    );
                    Navigator.of(ctx).pop(); // Fecha o confirm
                    _mostrarDialogSucesso(); // Abre o sucesso
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BCD4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha modal
                Navigator.of(context).pop(); // Volta para Detalhes da Turma
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

    final dataFormatada = state.value?.data != null
        ? "${state.value!.data.day.toString().padLeft(2, '0')}/${state.value!.data.month.toString().padLeft(2, '0')}/${state.value!.data.year}"
        : '';

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Voltar',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        titleSpacing: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            state.when(
              data: (state) => Expanded(
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

                      buildDropdownField(
                        label: 'Instrutor/Professor da Aula:*',
                        value: state.professor,
                        items: state.usuarios,
                        labelBuilder: (user) => user.nome,
                        onChanged: (value) {
                          if (value != null) {
                            notifier.updateProfessor(value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // DatePicker
                      buildLabel('Data:*'),
                      TextFormField(
                        key: ValueKey(state.data),
                        readOnly: true,
                        initialValue: dataFormatada,
                        decoration: _inputDecoration().copyWith(
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Color(0xFF666666),
                          ),
                        ),
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Obrigatório' : null,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            notifier.updateData(picked);
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Lista de Alunos com Checkbox
                      const Text(
                        'Alunos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
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
                                  backgroundColor: Color(0xFFE0E0E0),
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
                                  activeColor: const Color(0xFF00BCD4),
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
                    ],
                  ),
                ),
              ),
              error: (error, stack) {
                switch (error) {
                  case AppApiException(:final message, :final error):
                    ref.read(loggerProvider).e(message, error: error);
                  default:
                    break;
                }
                return Center(child: Text('Erro ao carregar os alunos'));
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),

            // Botão Inferior Fixo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFEFEFEF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
    );
  }
}
