import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/stores/historico_emprestimos/historico_emprestimos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class HistoricoEmprestimosPage extends ConsumerWidget {
  const HistoricoEmprestimosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final appBarBg = isDark ? AppColors.darkTopbar : AppColors.platinum;
    final gradientColors =
        isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBg,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: textColor, size: 22),
          label: Text(
            'Voltar',
            style: TextStyle(
              color: textColor,
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
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Título ────────────────────────────────────────
                    Text(
                      'Histórico de Empréstimos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Filtros de tipo ───────────────────────────────
                    const _FiltroChips(),
                    const SizedBox(height: 16),

                    // ── Lista ─────────────────────────────────────────
                    const Expanded(child: _HistoricoLista()),
                    const SizedBox(height: 16),
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
// Chips de filtro (Todos / Empréstimos / Devoluções)
// ─────────────────────────────────────────────────────────────────────────────
class _FiltroChips extends ConsumerWidget {
  const _FiltroChips();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historicoEmprestimosStoreProvider);
    final store = ref.read(historicoEmprestimosStoreProvider.notifier);
    final filtroAtual = state.value?.filtroTipo ?? 'todos';

    final opcoes = [
      ('todos', 'Todos'),
      ('emprestimo', 'Empréstimos'),
      ('devolucao', 'Devoluções'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: opcoes.map((op) {
          final (valor, label) = op;
          final selecionado = filtroAtual == valor;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(label),
              selected: selecionado,
              onSelected: (_) => store.updateFiltroTipo(valor),
              selectedColor: AppColors.royalAzure,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: selecionado ? Colors.white : AppColors.textSecondary,
                fontWeight:
                    selecionado ? FontWeight.w600 : FontWeight.normal,
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkSurface
                  : Colors.white,
              side: BorderSide(
                color: selecionado
                    ? AppColors.royalAzure
                    : AppColors.borderSubtle,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Lista principal
// ─────────────────────────────────────────────────────────────────────────────
class _HistoricoLista extends ConsumerWidget {
  const _HistoricoLista();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historicoEmprestimosStoreProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final listBg = isDark ? AppColors.darkSurface : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: listBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: state.when(
        data: (data) {
          if (data.itensFiltrados.isEmpty) {
            return Center(
              child: Text(
                'Nenhum registro encontrado',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.cyanPrimary,
            onRefresh: () =>
                ref.refresh(historicoEmprestimosStoreProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: data.itensFiltrados.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: isDark ? AppColors.darkDivider : AppColors.divider,
              ),
              itemBuilder: (context, index) {
                final item = data.itensFiltrados[index];
                return _HistoricoTile(item: item);
              },
            ),
          );
        },
        error: (error, stack) {
          if (error is AppApiException) {
            ref.read(loggerProvider).e(error.message, error: error.error);
          }
          return const Center(
            child: Text('Erro ao carregar o histórico de empréstimos'),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.cyanPrimary),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tile de cada item do histórico
// ─────────────────────────────────────────────────────────────────────────────
class _HistoricoTile extends StatelessWidget {
  final HistoricoItem item;

  const _HistoricoTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final isDevolucao = item.emprestimo.dataDevolucao != null;

    final tipoColor = isDevolucao ? AppColors.success : AppColors.royalAzure;
    final tipoLabel = isDevolucao ? 'Devolução' : 'Empréstimo';
    final tipoIcon =
        isDevolucao ? Icons.assignment_return_outlined : Icons.assignment_outlined;

    final data = isDevolucao
        ? item.emprestimo.dataDevolucao!
        : item.emprestimo.data;
    final dataFormatada =
        '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';

    final nomeAluno = item.aluno?.nome ?? 'Aluno #${item.emprestimo.alunoId}';
    final nomeVoluntario = item.voluntario?.nome ?? '—';
    final kimono =
        '${item.emprestimo.tamanho.nomeVisivel}, ${item.emprestimo.cor.nomeVisivel}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone de tipo
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tipoColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(tipoIcon, color: tipoColor, size: 22),
          ),
          const SizedBox(width: 12),

          // Informações
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tipo + data
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: tipoColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tipoLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: tipoColor,
                        ),
                      ),
                    ),
                    Text(
                      dataFormatada,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Nome do aluno
                Text(
                  nomeAluno,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 2),

                // Kimono
                Text(
                  'Kimono: $kimono',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),

                // Voluntário
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      nomeVoluntario,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}