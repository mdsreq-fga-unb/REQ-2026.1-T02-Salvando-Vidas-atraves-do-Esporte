import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/turma/widgets/historico_frequencia_aluno_dialog.dart';

class TurmaDetail extends ConsumerWidget {
  final Turma turma;

  const TurmaDetail({super.key, required this.turma});

  void _confirmarDesmatricula(BuildContext context, WidgetRef ref, String nomeAluno, int alunoId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final cancelColor = isDark ? Colors.white70 : AppColors.error;
    final btnBg = isDark ? AppColors.cyanPrimary : const Color.fromARGB(255, 53, 188, 229);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja desmatricular o(a) aluno(a) $nomeAluno dessa turma?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancelar',
              style: TextStyle(color: cancelColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: btnBg,
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
      ref.invalidate(pesquisaAlunoProvider);
      
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : Colors.white;
    final appBarBg = isDark ? AppColors.darkTopbar : AppColors.platinum;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final outlineColor = isDark ? AppColors.cyanPastel : AppColors.deepNavy;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: appBarBg,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
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
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        TurmaOptionsMenuWidget(
                          turmaId: turma.id,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      turma.descricao,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text('Alunos matriculados: ${store.value?.alunos.length ?? 0}', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
                    const SizedBox(height: 24),
                    Text(
                      'Alunos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
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
                            nome: aluno.nomeReferencia,
                            onTap: () => mostrarHistoricoFrequenciaAlunoDialog(context, aluno),
                            onRemover: () => _confirmarDesmatricula(context, ref, aluno.nomeReferencia, aluno.id!),
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
                          foregroundColor: outlineColor,
                          side: BorderSide(
                            color: outlineColor,
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