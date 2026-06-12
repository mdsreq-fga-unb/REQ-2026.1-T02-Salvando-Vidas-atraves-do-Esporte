import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';

class RegistrarFrequenciaView extends StatefulWidget {
  final Turma turma;

  const RegistrarFrequenciaView({super.key, required this.turma});

  @override
  State<RegistrarFrequenciaView> createState() =>
      _RegistrarFrequenciaViewState();
}

class _RegistrarFrequenciaViewState extends State<RegistrarFrequenciaView> {
  final _formKey = GlobalKey<FormState>();
  final _dataController = TextEditingController();
  String? _instrutorSelecionado;

  // CORREÇÃO AQUI: Agora usamos o 'index' (int) em vez do nome (String) para ser único
  final Map<int, bool> _frequencia = {};

  @override
  void initState() {
    super.initState();
    // Inicializa todos os alunos como ausentes (false) usando a posição deles na lista
    if ([] != null) {
      for (int i = 0; i < 0; i++) {
        _frequencia[i] = false;
      }
    }
  }

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

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
                onPressed: () {
                  Navigator.of(ctx).pop(); // Fecha o confirm
                  _mostrarDialogSucesso(); // Abre o sucesso
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
    final alunos = [];

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

                    // Dropdown Instrutor
                    _buildLabel('Instrutor/Professor da Aula:*'),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration(),
                      value: _instrutorSelecionado,
                      hint: const Text('Selecione'),
                      items: ['Professor A', 'Professor B', 'Professor C']
                          .map(
                            (i) => DropdownMenuItem(value: i, child: Text(i)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _instrutorSelecionado = val),
                      validator: (val) => val == null ? 'Obrigatório' : null,
                    ),
                    const SizedBox(height: 16),

                    // DatePicker
                    _buildLabel('Data:*'),
                    TextFormField(
                      controller: _dataController,
                      readOnly: true,
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
                          setState(() {
                            _dataController.text =
                                "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                          });
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
                      itemCount: alunos.length,
                      itemBuilder: (context, index) {
                        final aluno = alunos[index];
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
                              // CORREÇÃO AQUI: Lemos e escrevemos usando o "index"
                              Checkbox(
                                value: _frequencia[index],
                                activeColor: const Color(0xFF00BCD4),
                                side: const BorderSide(
                                  color: Color(0xFF999999),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _frequencia[index] = val ?? false;
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

  // _buildLabel com suporte ao asterisco vermelho
  Widget _buildLabel(String text) {
    final bool temAsterisco = text.endsWith('*');
    final String textoSemAsterisco = text.replaceAll('*', '');

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: RichText(
        text: TextSpan(
          text: textoSemAsterisco,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black, // Cor do texto principal
          ),
          children: [
            if (temAsterisco)
              const TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red), // Asterisco vermelho
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
