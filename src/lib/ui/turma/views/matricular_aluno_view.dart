import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class MatricularAlunoView extends ConsumerStatefulWidget {
  final Turma turma;

  const MatricularAlunoView({super.key, required this.turma});

  @override
  ConsumerState<MatricularAlunoView> createState() =>
      _MatricularAlunoViewState();
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : Colors.white;
    final appBarBg = isDark ? AppColors.darkTopbar : AppColors.platinum;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final inputBg = isDark ? AppColors.darkInputFill : AppColors.platinum;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final dividerColor = isDark ? AppColors.darkDivider : AppColors.divider;

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
                    Text(
                      'Matricular Aluno',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Turma: ${widget.turma.nome}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.cyanPastel
                            : AppColors.cyanPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar aluno...',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                        prefixIcon: Icon(Icons.search, color: textColor),
                        filled: true,
                        fillColor: inputBg,
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
                    final alunosFiltrados = data.alunos.where((aluno) {
                      if (!aluno.ativo || aluno.idTurma == widget.turma.id) {
                        return false;
                      }

                      int idade = DateTime.now().year - aluno.nascimento.year;

                      switch (widget.turma.faixaEtaria) {
                        case FaixaEtaria.infantil:
                          if (idade >= 18) return false;
                        case FaixaEtaria.adulto:
                          if (idade < 18) return false;
                      }

                      return (aluno.nome.toLowerCase().contains(_searchQuery) ||
                          aluno.cpf.contains(_searchQuery));
                    }).toList();

                    if (alunosFiltrados.isEmpty) {
                      return Center(
                        child: Text(
                          'Nenhum aluno elegível encontrado',
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: alunosFiltrados.length,
                      itemBuilder: (context, index) {
                        final aluno = alunosFiltrados[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Card(
                            elevation: 0,
                            color: cardBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: dividerColor, width: 1),
                            ),
                            child: ListTile(
                              title: Text(
                                aluno.nomeReferencia,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
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
                    return const Center(
                      child: Text('Erro ao carregar os alunos'),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarMatricula(dynamic aluno) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final btnBg = isDark ? AppColors.cyanPrimary : AppColors.deepNavy;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Tem certeza?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        content: Text(
          'Tem certeza que quer colocar o aluno ${aluno.nomeReferencia} na turma ${widget.turma.nome}?',
          textAlign: TextAlign.center,
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
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
              backgroundColor: btnBg,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              try {
                await service.atualizaAluno(aluno.id!, {
                  'id_turma': widget.turma.id,
                });

                // Atualizar a lista de alunos e a presença da turma
                ref.refresh(turmasStoreProvider.future);
                ref.invalidate(pesquisaAlunoProvider);
                ref.invalidate(presencaStoreProvider(widget.turma.id));

                if (!ctx.mounted) return;
                Navigator.pop(ctx);

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${aluno.nomeReferencia} matriculado com sucesso!',
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } on AppApiException catch (e) {
                logger.e(e.message, error: e.error);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);

                if (!mounted) return;
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
