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
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Informações do Aluno',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.deepNavy),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow('Nome:', aluno.nome),
              _buildInfoRow('CPF:', aluno.cpf),
              _buildInfoRow('Telefone:', aluno.contato ?? 'N/A'),
              _buildInfoRow('Aniversário:', dateFormat.format(aluno.nascimento)),
              _buildInfoRow('Tipo Sanguíneo:', aluno.tipoSanguineo.nomeVisivel),
              _buildInfoRow('ID da Ficha:', aluno.idFicha?.toString() ?? 'N/A'),
              if (responsavel != null) ...[
                const Divider(height: 24),
                const Text('Responsável:', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.cyanPrimary)),
                _buildInfoRow('Nome:', responsavel.nome),
                _buildInfoRow('CPF:', responsavel.cpf),
                _buildInfoRow('Telefone:', responsavel.contato),
              ],
            ],
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Fechar', style: TextStyle(color: AppColors.deepNavy, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
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

    return Scaffold(
      body: Container(
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

                    // ATUALIZAÇÃO: Grid de métricas e aniversariantes responsivo usando Flexbox (Expanded)
                    SizedBox(
                      height: 192, // Altura total fixa para as duas colunas se alinharem perfeitamente
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Coluna Esquerda: Aniversariantes (Ocupa exatamente 50% do espaço da Row)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.shadowLight,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Próximos aniversariantes',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
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
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
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
                                                          : AppColors.textSecondary,
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
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Coluna Direita: Cards (Ocupa os outros 50% do espaço da Row)
                          Expanded(
                            child: Column(
                              children: [
                                // O Expanded interno garante que os dois cards dividam a altura da coluna igualmente
                                Expanded(
                                  child: MetricCard(
                                    title: 'Alunos Ativos',
                                    value: '${homeState.value?.totalAtivos ?? "..."}',
                                    subtitle: 'Inativos: ${homeState.value?.totalInativos ?? "0"} | Total: ${homeState.value?.totalAlunos ?? "0"}',
                                    color: AppColors.royalAzure,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: MetricCard(
                                    title: 'Alertas de Evasão:',
                                    value: '${homeState.value?.alertasEvasao ?? "..."}',
                                    color: const Color(0xFFFFB348),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card com a lista de alunos
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowMedium,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Alunos:',
                            style: TextStyle(
                              color: AppColors.deepNavy,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                // Cabeçalho da tabela de alunos
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.platinum,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                    border: Border(bottom: BorderSide(color: AppColors.divider)),
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
                                                      child: Text(aluno.nome, overflow: TextOverflow.ellipsis),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text('${alunoHome.$2 ?? "N/A"}', textAlign: TextAlign.center),
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
                                                              : Colors.black,
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
}