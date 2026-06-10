import 'package:salvando_vidas/ui/turma/turma_imports.dart';

class Turma extends StatefulWidget {
  const Turma({super.key});

  @override
  State<Turma> createState() => _TurmasViewState();
}

class _TurmasViewState extends State<Turma> {
  List<TurmaModel> _turmas = List.from(turmasMock); // ignore: prefer_final_fields

  void _onTapTurma(TurmaModel turma) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TurmaDetail(turma: turma), // Corrigido o construtor e o nome da classe
      ),
    );
  }

  void _onEditarTurma(TurmaModel turma) {
    // Implementação futura da edição
  }

  void _onExcluirTurma(TurmaModel turma) {
    _showConfirmacaoExclusao(turma);
  }

  void _showConfirmacaoExclusao(TurmaModel turma) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Excluir Turma'),
        content: Text('Deseja excluir "${turma.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: Color(0xFFAAAAAA))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: const Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              setState(() {
                _turmas.removeWhere((t) => t.id == turma.id);
              });
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1)),
            ),
            child: const Text(
              'Turmas',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
            ),
          ),
          Expanded(
            child: _turmas.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 16, bottom: 24),
                    itemCount: _turmas.length,
                    itemBuilder: (context, index) {
                      final turma = _turmas[index];
                      return TurmaCardWidget(
                        turma: turma,
                        onTap: () => _onTapTurma(turma),
                        onEditar: () => _onEditarTurma(turma),
                        onExcluir: () => _onExcluirTurma(turma),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_outlined, size: 48, color: Color(0xFFAAAAAA)),
          SizedBox(height: 12),
          Text('Nenhuma turma cadastrada', style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14)),
        ],
      ),
    );
  }
}