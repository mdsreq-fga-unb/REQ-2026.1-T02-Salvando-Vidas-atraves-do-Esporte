import 'package:collection/collection.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/home/home_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import '../home_page_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _mostrarDetalhesAluno(BuildContext context, WidgetRef ref, Aluno aluno) async {
    final responsaveis = await ref.read(alunoServiceProvider).listarResponsaveis();
    final responsavel = responsaveis.firstWhereOrNull((r) => r.id == aluno.idResponsavel);

    if (!context.mounted) return;

    final dateFormat = DateFormat('dd/MM/yyyy');

    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final dialogBg = isDark ? AppColors.darkSurface : Colors.white;
        final titleColor = isDark ? Colors.white : AppColors.deepNavy;
        return AlertDialog(
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Informações do Aluno',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoRow('Nome:', aluno.nome, isDark),
                _buildInfoRow('CPF:', aluno.cpf, isDark),
                _buildInfoRow('Telefone:', aluno.contato ?? 'N/A', isDark),
                _buildInfoRow('Aniversário:', dateFormat.format(aluno.nascimento), isDark),
                _buildInfoRow('Tipo Sanguíneo:', aluno.tipoSanguineo.nomeVisivel, isDark),
                _buildInfoRow('ID da Ficha:', aluno.idFicha?.toString() ?? 'N/A', isDark),
                if (responsavel != null) ...[
                  const Divider(height: 24),
                  const Text('Responsável:', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.cyanPrimary)),
                  _buildInfoRow('Nome:', responsavel.nome, isDark),
                  _buildInfoRow('CPF:', responsavel.cpf, isDark),
                  _buildInfoRow('Telefone:', responsavel.contato, isDark),
                ],
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Fechar', style: TextStyle(color: titleColor, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14),
          children: [
            TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStoreProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final outerContainerBg = isDark ? AppColors.darkInputFill : AppColors.inputFill;
    final headerBg = isDark ? const Color(0xFF1E293B) : AppColors.platinum;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final subColor = isDark ? Colors.white70 : AppColors.textSecondary;

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
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                18,
                18,
                18,
                MediaQuery.of(context).padding.bottom +
                    kBottomNavigationBarHeight +
                    12,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 768),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),

                    // Grid de métricas e aniversariantes responsivo (celulares e tablets)
                    _buildTopSection(context, homeState, isDark, cardBg, subColor),
                    const SizedBox(height: 16),

                    // Card com a lista de alunos
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: outerContainerBg,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: AppColors.cardShadow(isDark),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alunos:',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                // Cabeçalho da tabela de alunos
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: headerBg,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                    border: const Border(bottom: BorderSide(color: AppColors.divider)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: InkWell(
                                          onTap: () => ref.read(homeStoreProvider.notifier).toggleOrder(OrderBy.nome),
                                          child: Row(
                                            children: [
                                              const Text('Nome', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                                              if (homeState.value?.orderBy == OrderBy.nome)
                                                Icon(homeState.value!.ascending ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 14, color: AppColors.textSecondary),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Text('Turma', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: InkWell(
                                          onTap: () => ref.read(homeStoreProvider.notifier).toggleOrder(OrderBy.ultimaPresenca),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text('Última\npresença', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                                              if (homeState.value?.orderBy == OrderBy.ultimaPresenca)
                                                Icon(homeState.value!.ascending ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 14, color: AppColors.textSecondary),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Lista rolável de alunos com RefreshIndicator
                                SizedBox(
                                  height: 220,
                                  child: homeState.when(
                                    data: (state) {
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          ref.invalidate(homeStoreProvider);
                                        },
                                        child: ListView.builder(
                                          itemCount: state.alunosHome.length,
                                          itemBuilder: (_, index) {
                                            final alunoHome = state.alunosHome[index];
                                            final aluno = alunoHome.$1;
                                            return InkWell(
                                              onTap: () => _mostrarDetalhesAluno(context, ref, aluno),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Text(aluno.nome, style: TextStyle(color: isDark ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text('${alunoHome.$2 ?? "N/A"}', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87), textAlign: TextAlign.center),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        switch (alunoHome.$3) {
                                                          null => "Nunca",
                                                          0 => "Hoje",
                                                          1 => "Ontem",
                                                          int dias => "Há $dias dias",
                                                        },
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: (alunoHome.$3 ?? 1000) >= 14
                                                              ? AppColors.error
                                                              : (isDark ? Colors.white : Colors.black),
                                                          fontWeight: (alunoHome.$3 ?? 1000) >= 14
                                                              ? FontWeight.w700
                                                              : FontWeight.normal,
                                                        ),
                                                      ),
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
                                        ref.read(loggerProvider).e(error.message, error: error.error);
                                      }
                                      return const Center(child: Text('Erro ao carregar os alunos'));
                                    },
                                    loading: () => const Center(child: CircularProgressIndicator()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ações Rápidas (Rodapé)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.go(Routes.cadastros),
                            icon: const Icon(Icons.person_add_alt_1_outlined),
                            label: const Text('Cadastrar Aluno'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cyanPrimary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
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

  Widget _buildTopSection(
    BuildContext context,
    AsyncValue<HomeState> homeState,
    bool isDark,
    Color cardBg,
    Color subColor,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final aniversariantesBox = Container(
          height: isMobile ? 180 : double.infinity,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppColors.cardShadow(isDark),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Próximos aniversariantes',
                style: TextStyle(
                  fontSize: 12,
                  color: subColor,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: homeState.when(
                  data: (state) {
                    final lista = state.proximoAniversariante;
                    if (lista.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum nos próximos 7 dias',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: lista.length,
                      itemBuilder: (_, i) {
                        final item = lista[i];
                        final diasTexto = item.dias == 0
                            ? 'Hoje! 🎉'
                            : item.dias == 1
                                ? 'Amanhã'
                                : '${item.dias} dias';
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.cake_outlined,
                                size: 14,
                                color: AppColors.cyanPrimary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  item.aluno.nome,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                diasTexto,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: item.dias == 0
                                      ? AppColors.royalAzure
                                      : subColor,
                                  fontWeight: item.dias == 0
                                      ? FontWeight.w700
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (_, __) => const Center(child: Text('Erro')),
                  loading: () => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        final cardsBox = Column(
          children: [
            if (isMobile)
              SizedBox(
                height: 90,
                child: MetricCard(
                  title: 'Alunos Ativos',
                  value: '${homeState.value?.totalAtivos ?? "..."}',
                  subtitle: 'Inativos: ${homeState.value?.totalInativos ?? "0"} | Total: ${homeState.value?.totalAlunos ?? "0"}',
                  color: AppColors.royalAzure,
                ),
              )
            else
              Expanded(
                child: MetricCard(
                  title: 'Alunos Ativos',
                  value: '${homeState.value?.totalAtivos ?? "..."}',
                  subtitle: 'Inativos: ${homeState.value?.totalInativos ?? "0"} | Total: ${homeState.value?.totalAlunos ?? "0"}',
                  color: AppColors.royalAzure,
                ),
              ),
            const SizedBox(height: 12),
            if (isMobile)
              SizedBox(
                height: 90,
                child: MetricCard(
                  title: 'Alertas de Evasão:',
                  value: '${homeState.value?.alertasEvasao ?? "..."}',
                  color: const Color(0xFFFFB348),
                ),
              )
            else
              Expanded(
                child: MetricCard(
                  title: 'Alertas de Evasão:',
                  value: '${homeState.value?.alertasEvasao ?? "..."}',
                  color: const Color(0xFFFFB348),
                ),
              ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              aniversariantesBox,
              const SizedBox(height: 12),
              cardsBox,
            ],
          );
        }

        return SizedBox(
          height: 192,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: aniversariantesBox),
              const SizedBox(width: 12),
              Expanded(child: cardsBox),
            ],
          ),
        );
      },
    );
  }
}