import 'package:salvando_vidas/ui/turma/turma_imports.dart';

class TurmaDetail extends StatelessWidget {
  final TurmaModel turma;

  const TurmaDetail({
    super.key,
    required this.turma,
  });

  @override
  Widget build(BuildContext context) {

    final alunos = turma.alunos ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Turma',
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
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
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  turma.descricao ?? '',
                  style: const TextStyle(
                    color: Color(0xFF666666),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Alunos: ${alunos.length}',
                ),

                const SizedBox(height: 24),

                const Text(
                  'Alunos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                final aluno = alunos[index];

                return AlunoTileWidget(
                  nome: aluno.nome,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrarFrequenciaView(turma: turma),
                    ),
                  );
                },
                child: const Text(
                  'Registrar Frequência',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}