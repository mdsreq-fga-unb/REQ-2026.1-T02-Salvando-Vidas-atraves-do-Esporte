import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/global/widgets/faixa_badge.dart';
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

    // Fundo: cyanPrimary no light (igual ao protótipo), gradient dark no dark
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
                    // ── Cards de estatísticas ──────────────────────────
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Card "Disponíveis" com botão Consultar
                          Expanded(
                            child: _StatCardConsultar(
                              title: 'Kimonos\nDisponíveis',
                              value: '$kimonoDisponives',
                              onConsultar: () => _abrirPopUpKimonos(context),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Card "Emprestados" — só número
                          Expanded(
                            child: _StatCardSimples(
                              title: 'Kimonos\nEmprestados',
                              value: '$kimonosEmprestados',
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
                          color: isDark ? AppColors.darkSurface : Colors.white,
                          borderRadius: BorderRadius.circular(14),
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
                                color: isDark ? Colors.white : AppColors.deepNavy,
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
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Colors.grey.shade300,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      aluno.nome,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color: isDark
                                                            ? Colors.white
                                                            : AppColors.deepNavy,
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
                                            ],
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
                            title: 'Doações &\nPerdas',
                            onTap: () => context.push(Routes.doacoesPerdas),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ActionButton(
                            title: 'Emprestar/\nPegar de volta',
                            onTap: () =>
                                context.push(Routes.emprestimoDevolucao),
                            outlined: true,
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

// ─────────────────────────────────────────────────────────────────────────────
// Card de estatística com botão "Consultar"
// ─────────────────────────────────────────────────────────────────────────────
class _StatCardConsultar extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onConsultar;

  const _StatCardConsultar({
    required this.title,
    required this.value,
    required this.onConsultar,
  });

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
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: onConsultar,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.royalAzure,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Consultar',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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

  const _ActionButton({
    required this.title,
    required this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // No protótipo: "Doações & Perdas" = azul sólido, "Emprestar/Pegar de volta" = azul mais claro/ciano
    final bg = outlined
        ? AppColors.cyanPrimary
        : AppColors.royalAzure;

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
class _PopUpKimonosDisponiveis extends StatefulWidget {
  const _PopUpKimonosDisponiveis();

  @override
  State<_PopUpKimonosDisponiveis> createState() =>
      _PopUpKimonosDisponiveisState();
}

class _PopUpKimonosDisponiveisState extends State<_PopUpKimonosDisponiveis> {
  TamanhoKimono? tamanhoSelecionado;
  CorKimono? corSelecionada;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? AppColors.darkSurface : Colors.white;
    // Fundo interno do popup — cinza-azulado claro como no protótipo
    final innerBg = isDark ? AppColors.darkBg : const Color(0xFFECF3F5);
    final dropBg = isDark ? AppColors.darkInputFill : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final hintColor = isDark ? Colors.white54 : AppColors.textSecondary;
    final iconColor = isDark ? Colors.white70 : AppColors.textSecondary;

    return Dialog(
      backgroundColor: dialogBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Column(
            children: [
              // ── Área interna cinza ────────────────────────────────
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: innerBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Filtros
                      Row(
                        children: [
                          // Dropdown Tamanho
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
                          // Dropdown Cor
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
                            final store =
                                ref.watch(gestaoKimonosStoreProvider);
                            return store.when(
                              data: (data) {
                                final filtrado = data.estoque.where((e) {
                                  final tamanhoOk = tamanhoSelecionado == null ||
                                      e.tamanho == tamanhoSelecionado;
                                  final corOk = corSelecionada == null ||
                                      e.cor == corSelecionada;
                                  return tamanhoOk &&
                                      corOk &&
                                      e.quantidadeDisponivel > 0;
                                }).toList();

                                if (filtrado.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Nenhum kimono disponível',
                                      style: TextStyle(color: hintColor),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: filtrado.length,
                                  itemBuilder: (context, index) {
                                    final kimono = filtrado[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.sports_martial_arts,
                                            size: 26,
                                            color: iconColor,
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Text(
                                              '${kimono.tamanho.nomeVisivel}, ${kimono.cor.nomeVisivel}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                          // Quantidade disponível
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: AppColors.cyanPrimary
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'x${kimono.quantidadeDisponivel}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: isDark
                                                    ? AppColors.cyanPrimary
                                                    : AppColors.deepNavy,
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
              const SizedBox(height: 14),

              // Botão Ok
              SizedBox(
                width: 120,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
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
          hint: Text(hint,
              style: TextStyle(color: hintColor, fontSize: 13)),
          value: value,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: hintColor, size: 18),
          style: TextStyle(color: textColor, fontSize: 13),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(labelOf(item),
                        style: TextStyle(color: textColor, fontSize: 13)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
