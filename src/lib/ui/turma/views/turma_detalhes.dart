import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';

class TurmaDetail extends ConsumerWidget {
  final Turma turma;

  const TurmaDetail({super.key, required this.turma});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(presencaStoreProvider(turma.id));

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF08216F), size: 22),
          label: const Text(
            'Voltar',
            style: TextStyle(
              color: Color(0xFF08216F),
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      turma.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF08216F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      turma.descricao,
                      style: const TextStyle(color: Color(0xFF666666)),
                    ),
                    const SizedBox(height: 4),
                    Text('Alunos matriculados: ${store.value?.alunos.length ?? 0}'),
                    const SizedBox(height: 24),
                    const Text(
                      'Alunos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF08216F)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: store.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.alunos.length,
                      itemBuilder: (context, index) {
                        final aluno = data.alunos[index];
                        return AlunoTileWidget(nome: aluno.nome);
                      },
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08216F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegistrarFrequenciaView(turma: turma),
                        ),
                      );
                    },
                    child: const Text(
                      'Registrar Frequência',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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