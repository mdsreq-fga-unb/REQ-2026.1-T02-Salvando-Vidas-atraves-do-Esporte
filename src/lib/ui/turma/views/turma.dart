import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class TurmaPage extends ConsumerStatefulWidget {
  const TurmaPage({super.key});

  @override
  ConsumerState<TurmaPage> createState() => _TurmasViewState();
}

class _TurmasViewState extends ConsumerState<TurmaPage> {
  void _onTapTurma(Turma turma) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TurmaDetail(turma: turma)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final turmas = ref.watch(turmasStoreProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerBg = isDark ? AppColors.darkSurface : AppColors.platinum;
    final headerBorder = isDark ? AppColors.darkDivider : AppColors.inputFill;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
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
          constraints: const BoxConstraints(maxWidth: 768), // Responsividade fluida no tablet
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: headerBg,
                  border: Border(
                    bottom: BorderSide(color: headerBorder, width: 1),
                  ),
                ),
                child: Text(
                  'Turmas Abertas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              Expanded(
                child: turmas.when(
                  data: (listaTurmas) {
                    return RefreshIndicator(
                      onRefresh: () => ref.refresh(turmasStoreProvider.future),
                      child: switch (listaTurmas.isNotEmpty) {
                        false => _buildAltState('Nenhuma turma foi encontrada'),
                        true => ListView.builder(
                          padding: const EdgeInsets.only(top: 16, bottom: 24),
                          itemCount: listaTurmas.length,
                          itemBuilder: (context, index) {
                            final turma = listaTurmas[index];
                            return TurmaCardWidget(
                              turma: turma,
                              onTap: () => _onTapTurma(turma),
                            );
                          },
                        ),
                      },
                    );
                  },
                  error: (error, stack) {
                    if (error is AppApiException) {
                      ref.read(loggerProvider).e(error.message, error: error.error);
                      return _buildAltState(error.message);
                    }
                    return _buildAltState('Ocorreu algum erro inesperado ao carregar as turmas');
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

  Widget _buildAltState(String mensagem) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_outlined, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(
            mensagem,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}