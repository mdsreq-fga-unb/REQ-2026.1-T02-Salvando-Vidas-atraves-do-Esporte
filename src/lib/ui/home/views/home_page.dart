import 'package:salvando_vidas/data/stores/home/home_store.dart';
import 'package:salvando_vidas/main_imports.dart';
import '../home_page_imports.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStoreProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F8F8), Color(0xFFE4E4E4)],
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
                                    color: Color(0x18000000),
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
                                      color: Color(0xFF555555),
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
                                                color: Color(0xFF888888),
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
                                                    color: Color(0xFF11A6BF),
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
                                                          ? const Color(0xFF2457F0)
                                                          : const Color(0xFF888888),
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
                                    title: 'Total de Alunos',
                                    value: '${homeState.value?.alunos.length ?? "..."}',
                                    color: const Color(0xFF2457F0),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: MetricCard(
                                    title: 'Kimonos Disponíveis',
                                    value: '${homeState.value?.kimonosDisponiveis ?? "..."}',
                                    color: const Color(0xFF11A6BF),
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
                        color: const Color(0xFFD8DDE6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
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
                              color: Color(0xFF08216F),
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
                                    color: Color(0xFFF0F2F5),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                    border: Border(bottom: BorderSide(color: Color(0xFFDDDDDD))),
                                  ),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        flex: 4,
                                        child: Text('Nome', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF555555))),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text('Turma', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF555555))),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text('Kimono', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF555555))),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text('Última\npresença', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF555555))),
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
                                            final aluno = state.alunosHome[index];
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                              decoration: const BoxDecoration(
                                                border: Border(bottom: BorderSide(color: Color(0xFFE6E6E6))),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(aluno.$1, overflow: TextOverflow.ellipsis),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text('${aluno.$2 ?? "N/A"}', textAlign: TextAlign.center),
                                                  ),
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Text('Não', textAlign: TextAlign.center),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      switch (aluno.$3) {
                                                        null => "Nunca",
                                                        0 => "Hoje",
                                                        1 => "Ontem",
                                                        int dias => "Há $dias dias",
                                                      },
                                                      textAlign: TextAlign.center,
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
                              backgroundColor: const Color(0xFF10A9D0),
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