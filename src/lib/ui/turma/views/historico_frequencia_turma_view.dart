import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/data/stores/presenca/historico_frequencia_provider.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/turma/widgets/historico_frequencia_aluno_dialog.dart';

class HistoricoFrequenciaTurmaView extends ConsumerStatefulWidget {
  final int turmaId;

  const HistoricoFrequenciaTurmaView({super.key, required this.turmaId});

  @override
  ConsumerState<HistoricoFrequenciaTurmaView> createState() => _HistoricoFrequenciaTurmaViewState();
}

class _HistoricoFrequenciaTurmaViewState extends ConsumerState<HistoricoFrequenciaTurmaView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _filtroNome = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historicoFrequenciaTurmaProvider(widget.turmaId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : AppColors.platinum;
    final appBarBg = isDark ? AppColors.darkTopbar : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: appBarBg,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Histórico de Frequência',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.cyanPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.cyanPrimary,
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.people), text: 'Por Aluno'),
            Tab(icon: Icon(Icons.calendar_month), text: 'Por Aula'),
          ],
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Erro ao carregar histórico: $err',
            style: const TextStyle(color: AppColors.error),
          ),
        ),
        data: (data) => Column(
          children: [
            // Resumo Geral da Turma (Hero Card)
            _buildHeroCard(data, isDark),
            // Aba de Conteúdo
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAbaAlunos(data, isDark),
                  _buildAbaAulas(data, isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(HistoricoFrequenciaTurmaData data, bool isDark) {
    final media = data.percentualMedioTurma;
    final corMedia = media >= 75 ? AppColors.success : (media >= 50 ? AppColors.warning : AppColors.error);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.darkInputFill, AppColors.darkSurface]
              : [AppColors.deepNavy, const Color(0xFF1E3A5F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withOpacity(isDark ? 0.4 : 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.turmaNome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Média Geral da Turma',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: corMedia.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: corMedia),
                ),
                child: Text(
                  '${media.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: corMedia,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildHeroStat('Sessões de Aula', '${data.sessoes.length}', Icons.event_available),
              Container(width: 1, height: 30, color: Colors.white24),
              _buildHeroStat('Alunos Ativos', '${data.resumosAlunos.length}', Icons.groups),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cyanPastel, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAbaAlunos(HistoricoFrequenciaTurmaData data, bool isDark) {
    final resumosFiltrados = data.resumosAlunos
        .where((r) => r.aluno.nome.toLowerCase().contains(_filtroNome.toLowerCase()) ||
                      (r.aluno.apelido?.toLowerCase().contains(_filtroNome.toLowerCase()) ?? false))
        .toList();

    return Column(
      children: [
        // Campo de Pesquisa
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            onChanged: (val) => setState(() => _filtroNome = val),
            decoration: InputDecoration(
              hintText: 'Pesquisar aluno por nome...',
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              prefixIcon: const Icon(Icons.search, color: AppColors.cyanPrimary),
              filled: true,
              fillColor: isDark ? AppColors.darkInputFill : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ),
        Expanded(
          child: resumosFiltrados.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum aluno encontrado.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: resumosFiltrados.length,
                  itemBuilder: (context, index) {
                    final resumo = resumosFiltrados[index];
                    return _buildAlunoCard(resumo, isDark);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildAlunoCard(ResumoFrequenciaAlunoTurma resumo, bool isDark) {
    final cor = resumo.percentual >= 75 ? AppColors.success : (resumo.percentual >= 50 ? AppColors.warning : AppColors.error);
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: cardBg,
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => mostrarHistoricoFrequenciaAlunoDialog(context, resumo.aluno),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      resumo.aluno.nomeReferencia,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: cor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${resumo.percentual.toStringAsFixed(0)}%',
                      style: TextStyle(color: cor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: resumo.percentual / 100,
                  backgroundColor: isDark ? Colors.white12 : Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(cor),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: AppColors.success),
                      const SizedBox(width: 4),
                      Text('${resumo.totalPresencas} Presenças', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      const SizedBox(width: 12),
                      Icon(Icons.cancel, size: 16, color: AppColors.error),
                      const SizedBox(width: 4),
                      Text('${resumo.totalAusencias} Faltas', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Detalhes',
                        style: TextStyle(color: AppColors.cyanPrimary, fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.cyanPrimary),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbaAulas(HistoricoFrequenciaTurmaData data, bool isDark) {
    if (data.sessoes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 50, color: AppColors.textSecondary.withOpacity(0.5)),
            const SizedBox(height: 12),
            const Text(
              'Nenhuma chamada registrada para esta turma.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.sessoes.length,
      itemBuilder: (context, index) {
        final sessao = data.sessoes[index];
        return _buildSessaoCard(sessao, isDark);
      },
    );
  }

  Widget _buildSessaoCard(SessaoAulaTurmaItem sessao, bool isDark) {
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: cardBg,
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.cyanPrimary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.event, color: AppColors.cyanPrimary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatarData(sessao.data),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sessao.voluntarioNome ?? 'Voluntário',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cyanPrimary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${sessao.percentualPresenca.toStringAsFixed(0)}% Presença',
                  style: const TextStyle(color: AppColors.cyanPrimary, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: AppColors.success),
                const SizedBox(width: 4),
                Text('${sessao.totalPresentes} Presentes', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(width: 12),
                Icon(Icons.cancel, size: 14, color: AppColors.error),
                const SizedBox(width: 4),
                Text('${sessao.totalAusentes} Ausentes', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  if (sessao.observacao != null && sessao.observacao!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('Nota do Professor:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: textColor)),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkInputFill : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '"${sessao.observacao!}"',
                        style: TextStyle(fontStyle: FontStyle.italic, color: isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (sessao.alunosPresentes.isNotEmpty) ...[
                    Text('Presentes (${sessao.alunosPresentes.length}):', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.success)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: sessao.alunosPresentes.map((a) => _buildAlunoChip(a, AppColors.success)).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (sessao.alunosAusentes.isNotEmpty) ...[
                    Text('Ausentes (${sessao.alunosAusentes.length}):', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.error)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: sessao.alunosAusentes.map((a) => _buildAlunoChip(a, AppColors.error)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlunoChip(Aluno aluno, Color color) {
    return ActionChip(
      avatar: Icon(Icons.person, size: 14, color: color),
      label: Text(aluno.nomeReferencia, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide.none,
      onPressed: () => mostrarHistoricoFrequenciaAlunoDialog(context, aluno),
    );
  }
}
