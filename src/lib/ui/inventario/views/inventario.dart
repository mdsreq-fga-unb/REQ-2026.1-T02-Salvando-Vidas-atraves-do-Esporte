import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/emprestimo/widgets/historico_emprestimo_aluno_dialog.dart';

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
    final gradientColors = isDark
        ? AppColors.bgGradientDark
        : AppColors.bgGradientLight;
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Estoque de Kimonos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.deepNavy,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // ── Cards de estatísticas ──────────────────────────
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Card "Disponíveis" com botão Consultar Estoque
                          Expanded(
                            child: _StatCardConsultar(
                              title: 'Kimonos\nDisponíveis',
                              value: '$kimonoDisponives',
                              buttonText: 'Ver Estoque',
                              buttonIcon: Icons.checkroom_outlined,
                              gradientColors: isDark
                                  ? const [
                                      Color(0xFF071F3F),
                                      Color(0xFF006B85),
                                    ] // Escuro vibrante
                                  : const [
                                      Color(0xFF1976D2),
                                      Color(0xFF26C6DA),
                                    ], // Claro vivo
                              onConsultar: () => _abrirPopUpKimonos(context),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Card "Emprestados" com botão explícito de Histórico
                          Expanded(
                            child: _StatCardConsultar(
                              title: 'Kimonos\nEmprestados',
                              value: '$kimonosEmprestados',
                              buttonText: 'Ver Histórico',
                              buttonIcon: Icons.history_rounded,
                              gradientColors: isDark
                                  ? const [
                                      Color(0xFF140D36),
                                      Color(0xFF45229E),
                                    ] // Escuro vibrante
                                  : const [
                                      Color(0xFF3F51B5),
                                      Color(0xFF7986CB),
                                    ], // Claro vivo
                              onConsultar: () =>
                                  context.push(Routes.historicoEmprestimos),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Lista de alunos com kimono ─────────────────────
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.royalAzure.withOpacity(0.35),
                            width: 1.5,
                          ),
                          boxShadow: AppColors.cardShadow(isDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alunos com kimonos:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.deepNavy,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: store.when(
                                data: (data) {
                                  final emprestimos = data.emprestimos
                                      .where((e) => e.dataDevolucao == null)
                                      .toList();

                                  if (emprestimos.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'Nenhum kimono emprestado',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    );
                                  }

                                  return RefreshIndicator(
                                    color: AppColors.cyanPrimary,
                                    onRefresh: () => ref.refresh(
                                      gestaoKimonosStoreProvider.future,
                                    ),
                                    child: ListView.separated(
                                      itemCount: emprestimos.length,
                                      separatorBuilder: (_, __) => Divider(
                                        height: 1,
                                        color: isDark
                                            ? AppColors.darkDivider
                                            : AppColors.divider,
                                      ),
                                      itemBuilder: (context, index) {
                                        final emp = emprestimos[index];
                                        final aluno = data.alunos[emp.alunoId]!;
                                        return InkWell(
                                          onTap: () =>
                                              mostrarHistoricoEmprestimoAlunoDialog(
                                                context,
                                                aluno,
                                              ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 44,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.cyanPrimary
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.checkroom_outlined,
                                                    color:
                                                        AppColors.cyanPrimary,
                                                    size: 24,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        aluno.nome,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14,
                                                          color: isDark
                                                              ? Colors.white
                                                              : AppColors
                                                                    .deepNavy,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        '${emp.tamanho.nomeVisivel}, ${emp.cor.nomeVisivel}',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .textSecondary,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.chevron_right,
                                                  color: AppColors.cyanPrimary,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
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
                                      'Erro ao carregar o estoque de kimonos',
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.cyanPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Botões de ação ─────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: _ActionButton(
                            title: 'Emprestar\nKimono',
                            onTap: () => context.push(
                              Routes.emprestimoDevolucao,
                              extra: true,
                            ),
                            color: AppColors.royalAzure,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _ActionButton(
                            title: 'Devolver\nKimono',
                            onTap: () => context.push(
                              Routes.emprestimoDevolucao,
                              extra: false,
                            ),
                            color: AppColors.cyanPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _ActionButton(
                            title: 'Doações &\nPerdas',
                            onTap: () => context.push(Routes.doacoesPerdas),
                            outlined: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
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

// ─────────────────────────────────────────────────────────────────────────────
// Card de estatística com botão "Consultar"
// ─────────────────────────────────────────────────────────────────────────────
class _StatCardConsultar extends StatelessWidget {
  final String title;
  final String value;
  final String buttonText;
  final IconData buttonIcon;
  final List<Color> gradientColors;
  final VoidCallback onConsultar;

  const _StatCardConsultar({
    required this.title,
    required this.value,
    this.buttonText = 'Consultar',
    this.buttonIcon = Icons.arrow_forward_rounded,
    required this.gradientColors,
    required this.onConsultar,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(isDark ? 0.45 : 0.25),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: onConsultar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: gradientColors.first,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(buttonIcon, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card de estatística simples (só título + número)
// ─────────────────────────────────────────────────────────────────────────────
class _StatCardSimples extends StatelessWidget {
  final String title;
  final String value;

  const _StatCardSimples({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.cyanPrimary.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Botões de ação inferiores
// ─────────────────────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool outlined;
  final Color? color;

  const _ActionButton({
    required this.title,
    required this.onTap,
    this.outlined = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg =
        color ?? (outlined ? AppColors.cyanPrimary : AppColors.royalAzure);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white24,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Popup de kimonos disponíveis
// ─────────────────────────────────────────────────────────────────────────────
class _PopUpKimonosDisponiveis extends ConsumerStatefulWidget {
  const _PopUpKimonosDisponiveis();

  @override
  ConsumerState<_PopUpKimonosDisponiveis> createState() =>
      _PopUpKimonosDisponiveisState();
}

class _PopUpKimonosDisponiveisState
    extends ConsumerState<_PopUpKimonosDisponiveis> {
  TamanhoKimono? tamanhoSelecionado;
  CorKimono? corSelecionada;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? AppColors.darkSurface : Colors.white;
    final innerBg = isDark ? AppColors.darkBg : const Color(0xFFF3F7F9);
    final dropBg = isDark ? AppColors.darkInputFill : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final hintColor = isDark ? Colors.white54 : AppColors.textSecondary;

    return Dialog(
      backgroundColor: dialogBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height * 0.60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Cabeçalho do Modal ────────────────────────────────
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cyanPrimary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.cyanPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Estoque Disponível',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: hintColor),
                    splashRadius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Área interna de listagem ──────────────────────────
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: innerBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white12 : Colors.grey.shade200,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Filtros
                      Row(
                        children: [
                          Expanded(
                            child: _FilterDropdown<TamanhoKimono>(
                              hint: 'Tamanho',
                              value: tamanhoSelecionado,
                              items: TamanhoKimono.values,
                              labelOf: (t) => t.nomeVisivel,
                              bg: dropBg,
                              textColor: textColor,
                              hintColor: hintColor,
                              isDark: isDark,
                              onChanged: (v) =>
                                  setState(() => tamanhoSelecionado = v),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _FilterDropdown<CorKimono>(
                              hint: 'Cor',
                              value: corSelecionada,
                              items: CorKimono.values,
                              labelOf: (c) => c.nomeVisivel,
                              bg: dropBg,
                              textColor: textColor,
                              hintColor: hintColor,
                              isDark: isDark,
                              onChanged: (v) =>
                                  setState(() => corSelecionada = v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Lista de kimonos
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, _) {
                            final store = ref.watch(gestaoKimonosStoreProvider);
                            return store.when(
                              data: (data) {
                                final filtrado = data.estoque.where((e) {
                                  final tamanhoOk =
                                      tamanhoSelecionado == null ||
                                      e.tamanho == tamanhoSelecionado;
                                  final corOk =
                                      corSelecionada == null ||
                                      e.cor == corSelecionada;
                                  return tamanhoOk &&
                                      corOk &&
                                      e.quantidadeDisponivel > 0;
                                }).toList();

                                if (filtrado.isEmpty) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.inbox_outlined,
                                          size: 40,
                                          color: hintColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Nenhum kimono com este filtro',
                                          style: TextStyle(
                                            color: hintColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: filtrado.length,
                                  itemBuilder: (context, index) {
                                    final kimono = filtrado[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? AppColors.darkSurface
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              isDark ? 0.2 : 0.04,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.white12
                                              : Colors.grey.shade200,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColors.cyanPrimary
                                                  .withOpacity(0.12),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.sports_martial_arts,
                                              size: 22,
                                              color: AppColors.cyanPrimary,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  kimono.tamanho.nomeVisivel,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: textColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'Cor: ${kimono.cor.nomeVisivel}',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: hintColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF0083B0),
                                                  Color(0xFF00B4DB),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              '${kimono.quantidadeDisponivel} un.',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              error: (_, __) => Center(
                                child: Text(
                                  'Erro ao carregar',
                                  style: TextStyle(color: hintColor),
                                ),
                              ),
                              loading: () => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.cyanPrimary,
                                ),
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

              // Botão Concluído
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Entendido',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dropdown de filtro genérico para o popup
// ─────────────────────────────────────────────────────────────────────────────
class _FilterDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) labelOf;
  final Color bg;
  final Color textColor;
  final Color hintColor;
  final bool isDark;
  final ValueChanged<T?> onChanged;

  const _FilterDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.labelOf,
    required this.bg,
    required this.textColor,
    required this.hintColor,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
          hint: Text(hint, style: TextStyle(color: hintColor, fontSize: 13)),
          value: value,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: hintColor,
            size: 18,
          ),
          style: TextStyle(color: textColor, fontSize: 13),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    labelOf(item),
                    style: TextStyle(color: textColor, fontSize: 13),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
