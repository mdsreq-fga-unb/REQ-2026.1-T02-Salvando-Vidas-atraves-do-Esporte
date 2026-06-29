import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/data/stores/gestao_emprestimos/gestao_emprestimos_store.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

class EmprestimoDevolucaoPage extends ConsumerStatefulWidget {
  const EmprestimoDevolucaoPage({super.key});

  @override
  ConsumerState<EmprestimoDevolucaoPage> createState() =>
      _EmprestimoDevolucaoPageState();
}

class _EmprestimoDevolucaoPageState
    extends ConsumerState<EmprestimoDevolucaoPage> {
  // Mock de dados
  final List<String> alunos = [
    'Pedro Ramos Sousa Reis',
    'João Silva Oliveira',
    'Maria Santos Ferreira',
    'Lucas Souza Lima',
    'Ana Beatriz Costa',
    'Mateus Pereira Rocha',
  ];

  final List<Map<String, String>> kimonosDisponiveis = [
    {'tamanho': 'A3', 'cor': 'Branco'},
    {'tamanho': 'A2', 'cor': 'Azul'},
    {'tamanho': 'A4', 'cor': 'Preto'},
    {'tamanho': 'A1', 'cor': 'Rosa'},
    {'tamanho': 'A3', 'cor': 'Branco'},
  ];

  String searchQuery = '';
  String? alunoSelecionado;
  Map<String, String>? kimonoSelecionado;

  String? filtroTamanho;
  String? filtroCor;

  final List<String> tamanhos = ['A0', 'A1', 'A2', 'A3', 'A4', 'A5'];
  final List<String> cores = ['Branco', 'Azul', 'Preto', 'Rosa'];

  String viewState = 'escolha';

  void _resetSelection() {
    setState(() {
      alunoSelecionado = null;
      kimonoSelecionado = null;
      filtroTamanho = null;
      filtroCor = null;
    });
  }

  // Widget de botão voltar padronizado
  Widget _buildBackButton({required VoidCallback onPressed}) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? Colors.white : AppColors.deepNavy;
        return InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_ios, size: 18, color: textColor),
              Text(
                'Voltar',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final estoque = ref.watch(gestaoKimonosStoreProvider);

    final state = ref.watch(gestaoEmprestimosStoreProvider);
    final store = ref.read(gestaoEmprestimosStoreProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(child: _buildCurrentView()),
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (viewState) {
      case 'escolha':
        return _buildEscolhaView();
      case 'emprestar_aluno':
        return _buildSelecaoAlunoView(isEmprestar: true);
      case 'recuperar_aluno':
        return _buildSelecaoAlunoView(isEmprestar: false);
      default:
        return _buildEscolhaView();
    }
  }

  // --- VIEW: ESCOLHA INICIAL (CENTRALIZADA) ---
  Widget _buildEscolhaView() {
    return Stack(
      children: [
        // Botão Voltar no topo
        Positioned(
          top: 16,
          left: 16,
          child: _buildBackButton(onPressed: () => context.pop()),
        ),
        // Conteúdo Centralizado
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centraliza verticalmente
              children: [
                _buildMenuButton(
                  title: 'Emprestar Kimono',
                  color: AppColors.royalAzure,
                  onTap: () => setState(() => viewState = 'emprestar_aluno'),
                ),
                const SizedBox(height: 24),
                _buildMenuButton(
                  title: 'Recuperar Kimono',
                  color: AppColors.cyanPrimary,
                  onTap: () => setState(() => viewState = 'recuperar_aluno'),
                ),
              ],
            ),
          ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --- VIEW: SELEÇÃO DE ALUNO ---
  Widget _buildSelecaoAlunoView({required bool isEmprestar}) {
    final filteredAlunos = alunos
        .where((a) => a.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(gestaoEmprestimosStoreProvider);
        final store = ref.read(gestaoEmprestimosStoreProvider.notifier);
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final inputBg = isDark ? AppColors.darkInputFill : Colors.white;
        final listBg = isDark ? AppColors.darkSurface : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(
                onPressed: () => setState(() => viewState = 'escolha'),
              ),
              const SizedBox(height: 16),
              Text(
                isEmprestar ? 'Emprestar Kimono para:' : 'Pegar kimono de:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Buscar aluno...',
                  hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                  prefixIcon: Icon(Icons.search, color: textColor),
                  filled: true,
                  fillColor: inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) => store.updateFiltroAluno(val),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: listBg,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppColors.cardShadow(isDark),
                  ),
                  child: state.when(
                    data: (data) {
                      final alunosEmprestimos = data.emprestimos.map((e) {
                        if (e.dataDevolucao == null) return e.alunoId;
                      }).toList();
                      late final List<Aluno> alunos;
                      if (isEmprestar) {
                        alunos = data.alunosFiltrados
                            .where((a) => !alunosEmprestimos.contains(a.id))
                            .toList();
                      } else {
                        alunos = data.alunosFiltrados
                            .where((a) => alunosEmprestimos.contains(a.id))
                            .toList();
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: alunos.length,
                        separatorBuilder: (_, _) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                            ),
                            title: Text(
                              alunos[index].nome,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              final aluno = alunos[index];
                              final emprestimo = data.emprestimos
                                  .firstWhereOrNull(
                                    (e) =>
                                        e.dataDevolucao == null &&
                                        e.alunoId == aluno.id,
                                  );
                              if (isEmprestar) {
                                _showPopUpSelecaoKimono(aluno);
                              } else {
                                _showPopUpConfirmacaoRecuperar(
                                  aluno,
                                  emprestimo!,
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                    error: (error, stack) {
                      if (error is AppApiException) {
                        ref
                            .read(loggerProvider)
                            .e(error.message, error: error.error);
                      }
                      return const Center(
                        child: Text(
                          'Ocorreu algum erro inesperado ao carregar o estoque de kimonos',
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ],
          ),
            ),
          ),
        );
      },
    );
  }

  // --- POP-UPS: EMPRESTAR ---
  void _showPopUpSelecaoKimono(Aluno aluno) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, dialogRef, child) {
            final state = dialogRef.watch(gestaoEmprestimosStoreProvider);
            final store = dialogRef.read(
              gestaoEmprestimosStoreProvider.notifier,
            );
            return StatefulBuilder(
              builder: (context, setPopupState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text(
                    'Escolha um kimono para emprestar:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 400,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButton<TamanhoKimono?>(
                                isExpanded: true,
                                hint: const Text('Tamanho'),
                                value: state.value!.tamanho,
                                items: [
                                  const DropdownMenuItem<TamanhoKimono?>(
                                    value: null,
                                    child: Text('Qualquer tamanho'),
                                  ),
                                  ...TamanhoKimono.values.map(
                                    (t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t.nomeVisivel),
                                    ),
                                  ),
                                ],
                                onChanged: (v) => store.updateFiltroTamanho(v),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButton<CorKimono?>(
                                isExpanded: true,
                                hint: const Text('Cor'),
                                value: state.value!.cor,
                                items: [
                                  const DropdownMenuItem<CorKimono?>(
                                    value: null,
                                    child: Text('Qualquer cor'),
                                  ),
                                  ...CorKimono.values.map(
                                    (c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c.nomeVisivel),
                                    ),
                                  ),
                                ],
                                onChanged: (v) => store.updateFiltroCor(v),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: state.when(
                            data: (data) => ListView.builder(
                              itemCount: data.estoqueFiltrado.length,
                              itemBuilder: (context, index) {
                                final k = data.estoqueFiltrado[index];

                                return ListTile(
                                  leading: const Icon(
                                    Icons.checkroom,
                                    color: AppColors.royalAzure,
                                  ),
                                  title: Text(
                                    '${k.tamanho.nomeVisivel}, ${k.cor.nomeVisivel}',
                                  ),
                                  trailing: RadioGroup<Estoque>(
                                    groupValue: state.value!.kimono,
                                    child: Radio<Estoque>(value: k),
                                    onChanged: (v) => store.updateKimono(v!),
                                  ),
                                );
                              },
                            ),
                            error: (error, stack) {
                              if (error is AppApiException) {
                                ref
                                    .read(loggerProvider)
                                    .e(error.message, error: error.error);
                              }
                              return const Center(
                                child: Text(
                                  'Ocorreu algum erro inesperado ao carregar o estoque de kimonos',
                                ),
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyanPrimary,
                      ),
                      onPressed: state.value?.kimono == null
                          ? null
                          : () {
                              Navigator.pop(context);
                              _showPopUpConfirmacaoEmprestimo(
                                aluno,
                                state.value!.kimono!,
                              );
                            },
                      child: const Text(
                        'Avançar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _showPopUpConfirmacaoEmprestimo(Aluno aluno, Estoque kimono) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'Deseja emprestar este kimono para o aluno ${aluno.nome}?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showPopUpSelecaoKimono(aluno);
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyanPrimary,
                    ),
                    onPressed: () async {
                      try {
                        final emprestimo = Emprestimo(
                          alunoId: aluno.id!,
                          cor: kimono.cor,
                          tamanho: kimono.tamanho,
                          data: DateTime.now(),
                        );

                        ref
                            .read(kimonoServiceProvider)
                            .cadastrarEmprestimo(emprestimo);
                        ref.refresh(gestaoKimonosStoreProvider.future);
                        ref.refresh(gestaoEmprestimosStoreProvider.future);
                        Navigator.pop(context);
                        _showPopUpSucesso(
                          'O kimono foi emprestado com sucesso!',
                        );
                      } on AppApiException catch (e) {
                        ref.read(loggerProvider).e(e.message, error: e.error);
                      }
                    },
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPopUpConfirmacaoRecuperar(Aluno aluno, Emprestimo emprestimo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'Deseja pegar o kimono de ${aluno.nome}?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyanPrimary,
                    ),
                    onPressed: () {
                      try {
                        final service = ref.read(kimonoServiceProvider);
                        service.retornarEmprestimo(emprestimo);
                        Navigator.pop(context);
                        _showPopUpSucesso(
                          'O kimono foi recuperado com sucesso!',
                        );
                        ref.refresh(gestaoKimonosStoreProvider);
                        ref.refresh(gestaoEmprestimosStoreProvider.future);
                      } on AppApiException catch (e) {
                        ref.read(loggerProvider).e(e.message, error: e.error);
                      }
                    },
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPopUpSucesso(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cyanPrimary,
                minimumSize: const Size(120, 40),
              ),
              onPressed: () {
                Navigator.pop(context);
                _resetSelection();
                setState(() => viewState = 'escolha');
              },
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
