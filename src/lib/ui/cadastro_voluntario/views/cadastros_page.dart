import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/main_imports.dart';

import '../widgets/etapa_dados_basicos.dart';
import '../widgets/etapa_dados_medicos.dart';
import '../widgets/etapa_dados_responsavel.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class CadastrosPage extends ConsumerStatefulWidget {
  const CadastrosPage({super.key});

  @override
  ConsumerState<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends ConsumerState<CadastrosPage> {
  final PageController _pageController = PageController();
  int _etapaAtual = 0;
  final _formKeyEtapa1 = GlobalKey<FormState>();
  final _formKeyEtapa2 = GlobalKey<FormState>();
  final _formKeyEtapa3 = GlobalKey<FormState>();
  late final _formKeys = [_formKeyEtapa1, _formKeyEtapa2, _formKeyEtapa3];

  // Controllers - Etapa 2
  final _obsMedicasController = TextEditingController();
  final Map<int, bool?> _respostasMedicas = {
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
  };

  late CadastroAlunoState cadastro;
  late CadastroAluno notifier;
  late AlunoService service;
  late Logger logger;

  @override
  void dispose() {
    _pageController.dispose();
    _obsMedicasController.dispose();
    super.dispose();
  }

  void _onStepChanged(int page) {
    setState(() {
      _etapaAtual = page;
    });
  }

  void _avancar() {
    // if (_formKeys[_etapaAtual].currentState?.validate() ?? false) {
    if (cadastro.estaValido) {
      if (_etapaAtual == 0 || (_etapaAtual == 1 && cadastro.idade < 18)) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else if (cadastro.temResponsavel || cadastro.idade >= 18) {
        _mostrarDialogConfirmacao();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios corretamente.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Confirmar Cadastro',
          style: TextStyle(color: AppColors.deepNavy),
        ),
        content: const Text(
          'Deseja realmente salvar as informações deste aluno?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepNavy,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              _salvarAluno();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _salvarAluno() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    Aluno aluno = cadastro.aluno;
    Responsavel responsavel = cadastro.responsavel;

    try {
      if (cadastro.idade < 18) {
        final res = await service.cadastrarResponsavel(responsavel);
        aluno = aluno.copyWith(idResponsavel: res.id!);
      }

      await service.cadastrarAluno(aluno);

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aluno cadastrado com sucesso!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        notifier.reset();
        // AJUSTE: Redireciona de forma segura para a home page após salvar
        context.go(Routes.home);
      }
    } on AppApiException catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      logger.e(e.message, error: e.error);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar aluno. Tente novamente.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _tituloEtapa() {
    switch (_etapaAtual) {
      case 0:
        return 'Cadastrar Aluno:';
      case 1:
        return 'Cadastrar Aluno (Dados Médicos):';
      case 2:
        return 'Cadastrar Aluno (< 18 anos):';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    cadastro = this.ref.watch(cadastroAlunoProvider);
    notifier = this.ref.read(cadastroAlunoProvider.notifier);
    service = this.ref.read(alunoServiceProvider);
    logger = this.ref.read(loggerProvider);

    return Scaffold(
      // AJUSTE: Novo botão customizado de voltar com texto e navegação explícita
      appBar: AppBar(
        backgroundColor: AppColors.platinum,
        elevation: 0,
        leadingWidth: 110, // Abre espaço para o texto "Voltar" não quebrar
        leading: TextButton.icon(
          onPressed: () {
            FocusManager.instance.primaryFocus
                ?.unfocus(); // Fecha o teclado preventivamente
            context.go(Routes.home); // Manda o app direto para a HomePage
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.deepNavy,
            size: 22,
          ),
          label: const Text(
            'Voltar',
            style: TextStyle(
              color: AppColors.deepNavy,
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
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.platinum, AppColors.bgGradientEnd],
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
                      BoxShadow(
                        color: AppColors.shadowMedium,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _tituloEtapa(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepNavy,
                        ),
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
                            EtapaDadosBasicos(formKey: _formKeyEtapa1),
                            EtapaDadosMedicos(
                              formKey: _formKeyEtapa2,
                              respostas: _respostasMedicas,
                              onRespostaChanged: (id, value) =>
                                  setState(() => _respostasMedicas[id] = value),
                              obsController: _obsMedicasController,
                            ),
                            EtapaDadosResponsavel(formKey: _formKeyEtapa3),
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
                              foregroundColor: AppColors.deepNavy,
                              side: BorderSide(
                                color: _etapaAtual == 0
                                    ? AppColors.textSecondary
                                    : AppColors.deepNavy,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Voltar Etapa'),
                          ),
                          ElevatedButton(
                            onPressed: _avancar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deepNavy,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              (_etapaAtual == 2 ||
                                      (_etapaAtual == 1 &&
                                          cadastro.idade >= 18))
                                  ? 'Cadastrar'
                                  : 'Avançar',
                            ),
                          ),
                        ],
                      ),
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
