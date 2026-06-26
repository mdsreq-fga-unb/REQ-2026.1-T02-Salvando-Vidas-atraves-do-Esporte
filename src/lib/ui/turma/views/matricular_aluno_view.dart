import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class MatricularAlunoView extends ConsumerStatefulWidget {
  final Turma turma;

  const MatricularAlunoView({super.key, required this.turma});

  @override
  ConsumerState<MatricularAlunoView> createState() => _MatricularAlunoViewState();
}

class _MatricularAlunoViewState extends ConsumerState<MatricularAlunoView> {
  String _searchQuery = '';
  late AlunoService service;
  late Logger logger;

  @override
  Widget build(BuildContext context) {
    service = ref.read(alunoServiceProvider);
    logger = ref.read(loggerProvider);

    final alunosAsync = ref.watch(pesquisaAlunoProvider);

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
                    Text(
                      'Matricular Aluno',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepNavy,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Turma: ${widget.turma.nome}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cyanPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar aluno...',
                        prefixIcon: const Icon(Icons.search, color: AppColors.deepNavy),
                        filled: true,
                        fillColor: AppColors.platinum,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: alunosAsync.when(
                  data: (data) {
                    // Filtrar alunos sem turma ou com turma diferente
                    final alunosFiltrados = data.alunos
                        .where((aluno) =>
                            (aluno.idTurma == null || aluno.idTurma != widget.turma.id) &&
                            aluno.ativo &&
                            (aluno.nome.toLowerCase().contains(_searchQuery) ||
                                aluno.cpf.contains(_searchQuery)))
                        .toList();

                    if (alunosFiltrados.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _searchQuery.isEmpty
                                ? 'Nenhum aluno disponível para matrícula'
                                : 'Nenhum aluno encontrado',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: alunosFiltrados.length,
                      itemBuilder: (context, index) {
                        final aluno = alunosFiltrados[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: AppColors.divider,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                aluno.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepNavy,
                                ),
                              ),
                              subtitle: Text(
                                'CPF: ${aluno.cpf}',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.deepNavy,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                onPressed: () => _confirmarMatricula(aluno),
                                child: const Text(
                                  'Matricular',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stack) {
                    if (error is AppApiException) {
                      logger.e(error.message, error: error.error);
                    }
                    return const Center(child: Text('Erro ao carregar os alunos'));
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarMatricula(dynamic aluno) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Confirmar Matrícula',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.deepNavy,
          ),
        ),
        content: Text(
          'Deseja matricular ${aluno.nome} na turma ${widget.turma.nome}?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepNavy,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              try {
                await service.atualizaAluno(
                  aluno.id!,
                  {'id_turma': widget.turma.id},
                );

                // Atualizar a lista de alunos e a presença da turma
                await ref.refresh(pesquisaAlunoProvider.future);
                ref.invalidate(presencaStoreProvider(widget.turma.id));

                if (!mounted) return;
                Navigator.pop(ctx);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${aluno.nome} matriculado com sucesso!'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } on AppApiException catch (e) {
                logger.e(e.message, error: e.error);
                if (!mounted) return;
                Navigator.pop(ctx);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erro ao matricular aluno: ${e.message}'),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
