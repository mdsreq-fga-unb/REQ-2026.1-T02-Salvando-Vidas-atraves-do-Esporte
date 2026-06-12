import 'package:salvando_vidas/data/stores/home/home_store.dart';
import 'package:salvando_vidas/main_imports.dart';
import '../home_page_imports.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStoreProvider);

    String? aniversariante;
    int? dias;

    if (homeState.value != null &&
        homeState.value!.proximoAniversariante.isNotEmpty) {
      aniversariante = homeState.value!.proximoAniversariante.first.aluno.nome;
      dias = homeState.value!.proximoAniversariante.first.dias;
    }

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
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    // Metrics cards (2x2) - grid responsivo
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        final itemWidth = (constraints.maxWidth - spacing) / 2;
                        final aspect = itemWidth / 90;
                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: aspect,
                          children: [
                            MetricCard(
                              title: 'Próximos aniversariantes',
                              value: switch (aniversariante) {
                                null => "...",
                                String() => '$aniversariante ($dias dias)',
                              },
                              color: Colors.white,
                              width: itemWidth,
                            ),
                            MetricCard(
                              title: 'Total de Alunos',
                              value:
                                  '${homeState.value?.alunos.length ?? "..."}',
                              color: const Color(0xFF2457F0),
                              width: itemWidth,
                            ),
                            MetricCard(
                              title: 'Kimonos Disponíveis',
                              value:
                                  '${homeState.value?.kimonosDisponiveis ?? "..."}',
                              color: const Color(0xFF11A6BF),
                              width: itemWidth,
                            ),
                            MetricCard(
                              title: 'Total de Turmas',
                              value: '${homeState.value?.totalTurmas ?? "..."}',
                              color: Colors.white,
                              width: itemWidth,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Students list card
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
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: homeState.when(
                              data: (state) {
                                return RefreshIndicator(
                                  onRefresh: () =>
                                      ref.refresh(homeStoreProvider.future),
                                  child: ListView.builder(
                                    itemCount: state.alunos.length,
                                    itemBuilder: (_, index) {
                                      final aluno = state.alunos[index];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 10,
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFE6E6E6),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(aluno.nome),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${aluno.idTurma ?? "N/A"}',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Não',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                '0',
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
                                switch (error) {
                                  case AppApiException(
                                    :final message,
                                    :final error,
                                  ):
                                    ref
                                        .read(loggerProvider)
                                        .e(message, error: error);
                                  default:
                                    break;
                                }
                                return Center(
                                  child: Text('Erro ao carregar os alunos'),
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
                    const SizedBox(height: 16),

                    // Footer quick actions
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
