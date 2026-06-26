import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class TurmaDetail extends ConsumerWidget {
  final Turma turma;

  const TurmaDetail({super.key, required this.turma});

  void _confirmarDesmatricula(BuildContext context, WidgetRef ref, String nomeAluno, int alunoId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja desmatricular o(a) aluno(a) $nomeAluno dessa turma?',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 53, 188, 229),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await _desmatricularAluno(context, ref, alunoId);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _desmatricularAluno(BuildContext context, WidgetRef ref, int alunoId) async {
    try {
      final alunoService = ref.read(alunoServiceProvider);
      await alunoService.atualizaAluno(alunoId, {'id_turma': null});
      
      // Refresh stores
      ref.invalidate(presencaStoreProvider(turma.id));
      await ref.refresh(pesquisaAlunoProvider.future);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aluno desmatriculado com sucesso!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao desmatricular: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(presencaStoreProvider(turma.id));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.platinum,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.deepNavy, size: 22),
          label: const Text(
            'Voltar',
            style: TextStyle(
              color: AppColors.deepNavy,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            turma.nome,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepNavy,
                            ),
                          ),
                        ),
                        TurmaOptionsMenuWidget(
                          turmaId: turma.id,
                          onEditar: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditarTurmaView(turma: turma),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      turma.descricao,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text('Alunos matriculados: ${store.value?.alunos.length ?? 0}'),
                    const SizedBox(height: 24),
                    const Text(
                      'Alunos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.deepNavy),
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
	                        return AlunoTileWidget(
                            nome: aluno.nome,
                            onRemover: () => _confirmarDesmatricula(context, ref, aluno.nome, aluno.id!),
                          );
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
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepNavy,
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
                                  MatricularAlunoView(turma: turma),
                            ),
                          );
                        },
                        child: const Text(
                          'Matricular Aluno',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.deepNavy,
                          side: const BorderSide(
                            color: AppColors.deepNavy,
                            width: 2,
                          ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}