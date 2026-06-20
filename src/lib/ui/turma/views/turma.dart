import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/turma/turma_imports.dart';

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

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 768), // Responsividade fluida no tablet
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FB),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFD8DDE6), width: 1),
                  ),
                ),
                child: const Text(
                  'Turmas Abertas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF08216F),
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
    );
  }

  Widget _buildAltState(String mensagem) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_outlined, size: 48, color: Color(0xFFAAAAAA)),
          const SizedBox(height: 12),
          Text(
            mensagem,
            style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
          ),
        ],
      ),
    );
  }
}