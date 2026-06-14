import 'package:flutter/material.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

class EditarAlunoPage extends StatefulWidget {
  final Aluno aluno;

  const EditarAlunoPage({super.key, required this.aluno});

  @override
  State<EditarAlunoPage> createState() => _EditarAlunoPageState();
}

class _EditarAlunoPageState extends State<EditarAlunoPage> {
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

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: widget.aluno.nome);
    _cpfCtrl = TextEditingController(text: widget.aluno.cpf);
    _telefoneCtrl = TextEditingController(text: widget.aluno.contato ?? '');
    
    final data = widget.aluno.nascimento;
    _aniversarioCtrl = TextEditingController(
      text: "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}"
    );
    
    _idFichaCtrl = TextEditingController(text: widget.aluno.idFicha?.toString() ?? '');
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
    if (_etapaAtual == 0) {
      if (widget.aluno.idResponsavel == null) {
        _mostrarDialogConfirmacao();
      } else {
        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    } else {
      _mostrarDialogConfirmacao();
    }
  }

  void _mostrarDialogConfirmacao() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Deseja salvar as\nalterações?', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
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
            onPressed: () {
              Navigator.pop(ctx); // Fecha o dialog
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Aluno atualizado com sucesso!')))
                  .closed
                  .then((_) {
                if (context.mounted) {
                  Navigator.pop(context); // Fecha a página de edição após o SnackBar
                }
              });
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                _etapaAtual == 0 ? 'Editar Aluno:' : 'Editar Aluno (< 18 anos):',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                height: 400,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (idx) => setState(() => _etapaAtual = idx),
                  children: [
                    _buildEtapa1(),
                    _buildEtapa2(),
                  ],
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
                        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
                    child: Text(_etapaAtual == 0 && widget.aluno.idResponsavel != null ? 'Avançar' : 'Salvar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEtapa1() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Nome:*', _nomeCtrl),
          _buildTextField('CPF:*', _cpfCtrl),
          _buildTextField('Telefone:*', _telefoneCtrl),
          _buildTextField('Aniversário:*', _aniversarioCtrl, isDate: true),
          
          _buildDropdownEnum<TipoSanguineo>(
            label: 'Tipo sanguíneo:*',
            value: _tipoSanguineoSelecionado,
            items: TipoSanguineo.values,
            getName: (TipoSanguineo t) => t.nomeVisivel,
            onChanged: (v) => setState(() => _tipoSanguineoSelecionado = v),
          ),
          
          _buildDropdownEnum<Faixa>(
            label: 'Faixa/Grau:*',
            value: _faixaSelecionada,
            items: Faixa.values,
            getName: (Faixa f) => f.nomeVisivel,
            onChanged: (v) => setState(() => _faixaSelecionada = v),
          ),
          
          _buildTextField('ID da ficha:*', _idFichaCtrl),
        ],
      ),
    );
  }

  Widget _buildEtapa2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Nome do Responsável:*', _nomeRespCtrl),
          _buildTextField('CPF do Responsável:*', _cpfRespCtrl),
          _buildTextField('Telefone do Responsável:*', _telefoneRespCtrl),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
              suffixIcon: isDate ? const Icon(Icons.calendar_today, size: 20) : null,
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
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 4),
          DropdownButtonFormField<T>(
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
            ),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(getName(e)))).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}