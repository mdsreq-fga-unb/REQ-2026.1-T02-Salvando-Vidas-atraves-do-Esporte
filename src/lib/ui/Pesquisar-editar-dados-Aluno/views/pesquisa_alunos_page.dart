import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno_mock.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/widgets/aluno_expandable_card.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class PesquisaAlunosPage extends ConsumerStatefulWidget {
  const PesquisaAlunosPage({super.key});

  @override
  ConsumerState<PesquisaAlunosPage> createState() => _PesquisaAlunosPageState();
}

class _PesquisaAlunosPageState extends ConsumerState<PesquisaAlunosPage> {
  // 1. Lista original que guarda todos os alunos e nunca é alterada
  // ignore: unused_field
  final List<Aluno> _todosAlunos = List.from(alunosMock);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pesquisaAlunoProvider);
    final notifier = ref.read(pesquisaAlunoProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchBg = isDark ? AppColors.darkSurface : Colors.white;
    final gradientColors = isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 16.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: searchBg,
                borderRadius: BorderRadius.circular(30),
                boxShadow: AppColors.cardShadow(isDark),
              ),
              child: TextField(
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                enabled: state.maybeWhen(
                  data: (_) => true,
                  orElse: () => false,
                ),
                onChanged: notifier.filtrarAlunos,
                decoration: InputDecoration(
                  hintText: 'Insira o nome do aluno',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white54 : AppColors.textSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.cyanPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Toggle: mostrar alunos inativos
          state.maybeWhen(
            data: (data) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Mostrar inativos',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: data.mostrarInativos,
                    onChanged: (_) => notifier.toggleMostrarInativos(),
                    activeThumbColor: AppColors.cyanPrimary,
                  ),
                ],
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),

          Expanded(
            child: state.when(
              data: (data) => data.alunosFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum aluno encontrado.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: data.alunosFiltrados.length,
                      itemBuilder: (context, index) {
                        final aluno = data.alunosFiltrados[index];
                        final responsavel = data.responsaveis[aluno.id!];
                        return AlunoExpandableCard(
                          key: Key('${aluno.nome} - ${aluno.ativo}'),
                          aluno: aluno,
                          responsavel: responsavel,
                        );
                      },
                    ),
              error: (error, stack) {
                switch (error) {
                  case AppApiException(:final message, :final error):
                    ref.read(loggerProvider).e(message, error: error);
                    continue d;
                  d:
                  default:
                    return const Center(
                      child: Text(
                        'Erro ao procurar por alunos.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                    );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
          ),
        ),
      ),
    );
  }
}
