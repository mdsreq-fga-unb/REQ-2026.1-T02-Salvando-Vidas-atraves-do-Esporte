import 'package:flutter/material.dart';
import '../cadastro_imports.dart'; 
import '../widgets/etapa_dados_basicos.dart';
import '../widgets/etapa_dados_medicos.dart';
import '../widgets/etapa_dados_responsavel.dart';
import '../widgets/cadastro_dialogs.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({super.key});

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  final PageController _pageController = PageController();
  int _etapaAtual = 0;
  final _formKeyEtapa1 = GlobalKey<FormState>();
  final _formKeyEtapa2 = GlobalKey<FormState>();
  final _formKeyEtapa3 = GlobalKey<FormState>();
  late final _formKeys = [_formKeyEtapa1, _formKeyEtapa2, _formKeyEtapa3];
  // Controllers - Etapa 1
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  String? _tipoSanguineo;
  String? _faixa;
  String? _idFicha; 
  // Controllers - Etapa 2
  final _obsMedicasController = TextEditingController();
  final Map<int, bool?> _respostasMedicas = {1: null, 2: null, 3: null, 4: null, 5: null};
  // Controllers - Etapa 3
  final _nomeResponsavelController = TextEditingController();
  final _cpfResponsavelController = TextEditingController();
  final _telefoneResponsavelController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _nomeController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _dataNascimentoController.dispose();
    _obsMedicasController.dispose();
    _nomeResponsavelController.dispose();
    _cpfResponsavelController.dispose();
    _telefoneResponsavelController.dispose();
    super.dispose();
  }

  void _onStepChanged(int page) {
    setState(() {
      _etapaAtual = page;
    });
  }

  void _avancar() {
    if (_formKeys[_etapaAtual].currentState!.validate()) {
      if (_etapaAtual < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _mostrarDialogConfirmacao();
      }
    }
  }

  void _voltar() {
    if (_etapaAtual > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _mostrarDialogConfirmacao() {
    showConfirmationDialog(
      context: context,
      onConfirm: () {
        showSuccessDialog(
          context: context,
          onFechar: () {
            setState(() {
              _pageController.jumpToPage(0);
              _etapaAtual = 0;
              _nomeController.clear();
              _cpfController.clear();
              _telefoneController.clear();
              _dataNascimentoController.clear();
              _tipoSanguineo = null;
              _faixa = null;
              _idFicha = null;
              _obsMedicasController.clear();
              _respostasMedicas.updateAll((key, value) => null);
              _nomeResponsavelController.clear();
              _cpfResponsavelController.clear();
              _telefoneResponsavelController.clear();
            });
          },
        );
      },
    );
  }

  String _tituloEtapa() {
    switch (_etapaAtual) {
      case 0:
        return 'Cadastrar Aluno:';
      case 1:
        return 'Cadastrar Aluno (Observações Médicas):';
      case 2:
        return 'Cadastrar Aluno (< 18 anos):';
      default:
        return '';
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
            colors: [Color(0xFFF5F7FB), Color(0xFFE4E4E4)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, 6)),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _tituloEtapa(),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF08216F)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 520, 
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: _onStepChanged,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            EtapaDadosBasicos(
                              formKey: _formKeyEtapa1,
                              nomeController: _nomeController,
                              cpfController: _cpfController,
                              telefoneController: _telefoneController,
                              dataNascimentoController: _dataNascimentoController,
                              tipoSanguineo: _tipoSanguineo,
                              faixa: _faixa,
                              idFicha: _idFicha, 
                              onTipoSanguineoChanged: (v) => setState(() => _tipoSanguineo = v),
                              onFaixaChanged: (v) => setState(() => _faixa = v),
                              onIdFichaChanged: (v) => setState(() => _idFicha = v), 
                            ),
                            EtapaDadosMedicos(
                              formKey: _formKeyEtapa2,
                              respostas: _respostasMedicas,
                              onRespostaChanged: (id, value) => setState(() => _respostasMedicas[id] = value),
                              obsController: _obsMedicasController,
                            ),
                            EtapaDadosResponsavel(
                              formKey: _formKeyEtapa3,
                              nomeController: _nomeResponsavelController,
                              cpfController: _cpfResponsavelController,
                              telefoneController: _telefoneResponsavelController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: _etapaAtual == 0 ? null : _voltar,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF08216F),
                              side: BorderSide(color: _etapaAtual == 0 ? Colors.grey : const Color(0xFF08216F)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Voltar'),
                          ),
                          ElevatedButton(
                            onPressed: _avancar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF08216F),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(_etapaAtual == 2 ? 'Cadastrar' : 'Avançar'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}