import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart'; // Ajuste o import se necessário
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/routing/routes.dart';

class Inventario extends ConsumerWidget {
  const Inventario({super.key});

  void _abrirPopUpKimonos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _PopUpKimonosDisponiveis(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(gestaoKimonosStoreProvider);

    int kimonoDisponives = 0;
    int kimonosEmprestados = 0;

    if (store.value != null) {
      for (final estoque in store.value!.estoque) {
        kimonoDisponives += estoque.quantidadeDisponivel;
      }

      kimonosEmprestados = store.value!.emprestimos
          .where((e) => e.dataDevolucao == null)
          .length;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
              children: [
                // Linha Superior: Cards de Estatísticas
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Kimonos\nDisponíveis',
                        value: '$kimonoDisponives',
                        onTap: () => _abrirPopUpKimonos(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'Kimonos\nEmprestados',
                        value: '$kimonosEmprestados',
                        onTap: () {
                          // TODO: Implementar depois, se necessário
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Seção Central: Lista de Alunos
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppColors.cardShadow(isDark),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alunos com kimonos:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: store.when(
                            data: ((data) {
                              final emprestimos = data.emprestimos
                                  .where((e) => e.dataDevolucao == null)
                                  .toList();

                              return RefreshIndicator(
                                onRefresh: () => ref.refresh(
                                  gestaoKimonosStoreProvider.future,
                                ),
                                child: ListView.builder(
                                  itemCount: emprestimos.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data
                                                      .alunos[emprestimos[index]
                                                          .alunoId]!
                                                      .nome,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  '${emprestimos[index].tamanho.nomeVisivel}, ${emprestimos[index].cor.nomeVisivel}',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
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
                ),
                const SizedBox(height: 16),

                // Linha Inferior: Botões de Ação
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        title: 'Doações &\nPerdas',
                        onTap: () {
                          context.push(Routes.doacoesPerdas);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ActionCard(
                        title: 'Emprestar/\nPegar de volta',
                        onTap: () {
                          context.push(Routes.emprestimoDevolucao);
                        },
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
    );
  }
}

// ============================================================================
// COMPONENTES AUXILIARES E POP-UP
// ============================================================================

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ActionCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class _PopUpKimonosDisponiveis extends StatefulWidget {
  const _PopUpKimonosDisponiveis();

  @override
  State<_PopUpKimonosDisponiveis> createState() =>
      _PopUpKimonosDisponiveisState();
}

class _PopUpKimonosDisponiveisState extends State<_PopUpKimonosDisponiveis> {
  String? tamanhoSelecionado;
  String? corSelecionada;

  final List<String> tamanhos = ['A0', 'A1', 'A2', 'A3', 'A4', 'A5'];
  final List<String> cores = ['Branco', 'Azul', 'Preto', 'Rosa'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final innerBg = isDark ? AppColors.darkBg : Colors.blueGrey.shade50;
    final dropBg = isDark ? AppColors.darkInputFill : Colors.white;

    return Dialog(
      backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            // Container cinza interno com a lista e os filtros
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: innerBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Filtros
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: dropBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
                                hint: Text('Tamanho', style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                                value: tamanhoSelecionado,
                                items: tamanhos.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    tamanhoSelecionado = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: dropBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
                                hint: Text('Cor', style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                                value: corSelecionada,
                                items: cores.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    corSelecionada = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Lista de Kimonos disponíveis
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.sports_martial_arts, size: 28, color: isDark ? Colors.white : Colors.black87),
                                const SizedBox(width: 16),
                                Text(
                                  'A3, Branco',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botão Ok
            SizedBox(
              width: 120,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, // Cor do botão OK
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o pop-up
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
