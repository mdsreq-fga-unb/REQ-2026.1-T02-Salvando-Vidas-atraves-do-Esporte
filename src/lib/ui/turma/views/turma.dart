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

  void _onEditarTurma(Turma turma) {
    // Implementação futura da edição
  }

  void _onExcluirTurma(Turma turma) {
    _showConfirmacaoExclusao(turma);
  }

  void _showConfirmacaoExclusao(Turma turma) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Excluir Turma'),
        content: Text('Deseja excluir "${turma.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color(0xFFAAAAAA)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: const Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final turmas = this.ref.watch(turmasStoreProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1),
              ),
            ),
            child: const Text(
              'Turmas',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ),
          Expanded(
            child: turmas.when(
              data: (listaTurmas) {
                if (listaTurmas.isEmpty)
                  return _buildAltState('Nenhuma turma cadastrada');

                return RefreshIndicator(
                  onRefresh: () => this.ref.refresh(turmasStoreProvider.future),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 16, bottom: 24),
                    itemCount: listaTurmas.length,
                    itemBuilder: (context, index) {
                      final turma = listaTurmas[index];
                      return TurmaCardWidget(
                        turma: turma,
                        onTap: () => _onTapTurma(turma),
                        onEditar: () => _onEditarTurma(turma),
                        onExcluir: () => _onExcluirTurma(turma),
                      );
                    },
                  ),
                );
              },
              error: (error, stack) {
                switch (error) {
                  case AppApiException(:final message, :final error):
                    this.ref.read(loggerProvider).e(message, error: error);
                    return _buildAltState(message);
                  default:
                    return _buildAltState(
                      'Ocorreu algum erro inesperado ao carregar as turmas',
                    );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAltState(String mensagem) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_outlined, size: 48, color: Color(0xFFAAAAAA)),
          SizedBox(height: 12),
          Text(
            'Nenhuma turma cadastrada',
            style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
