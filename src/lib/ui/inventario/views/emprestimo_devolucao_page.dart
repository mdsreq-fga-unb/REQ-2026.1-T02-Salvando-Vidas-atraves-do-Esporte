import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:go_router/go_router.dart';

class EmprestimoDevolucaoPage extends ConsumerStatefulWidget {
  const EmprestimoDevolucaoPage({super.key});

  @override
  ConsumerState<EmprestimoDevolucaoPage> createState() => _EmprestimoDevolucaoPageState();
}

class _EmprestimoDevolucaoPageState extends ConsumerState<EmprestimoDevolucaoPage> {
  // Mock de dados
  final List<String> alunos = [
    'Pedro Ramos Sousa Reis',
    'João Silva Oliveira',
    'Maria Santos Ferreira',
    'Lucas Souza Lima',
    'Ana Beatriz Costa',
    'Mateus Pereira Rocha',
  ];

  final List<Map<String, String>> kimonosDisponiveis = [
    {'tamanho': 'A3', 'cor': 'Branco'},
    {'tamanho': 'A2', 'cor': 'Azul'},
    {'tamanho': 'A4', 'cor': 'Preto'},
    {'tamanho': 'A1', 'cor': 'Rosa'},
    {'tamanho': 'A3', 'cor': 'Branco'},
  ];

  String searchQuery = '';
  String? alunoSelecionado;
  Map<String, String>? kimonoSelecionado;
  
  String? filtroTamanho;
  String? filtroCor;

  final List<String> tamanhos = ['A0', 'A1', 'A2', 'A3', 'A4', 'A5'];
  final List<String> cores = ['Branco', 'Azul', 'Preto', 'Rosa'];

  String viewState = 'escolha';

  void _resetSelection() {
    setState(() {
      alunoSelecionado = null;
      kimonoSelecionado = null;
      filtroTamanho = null;
      filtroCor = null;
    });
  }

  // Widget de botão voltar padronizado
  Widget _buildBackButton({required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios, size: 18, color: AppColors.deepNavy),
          Text(
            'Voltar',
            style: TextStyle(
              color: AppColors.deepNavy,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.platinum, AppColors.bgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: _buildCurrentView(),
        ),
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (viewState) {
      case 'escolha':
        return _buildEscolhaView();
      case 'emprestar_aluno':
        return _buildSelecaoAlunoView(isEmprestar: true);
      case 'recuperar_aluno':
        return _buildSelecaoAlunoView(isEmprestar: false);
      default:
        return _buildEscolhaView();
    }
  }

  // --- VIEW: ESCOLHA INICIAL (CENTRALIZADA) ---
  Widget _buildEscolhaView() {
    return Stack(
      children: [
        // Botão Voltar no topo
        Positioned(
          top: 16,
          left: 16,
          child: _buildBackButton(onPressed: () => context.pop()),
        ),
        // Conteúdo Centralizado
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
              children: [
                _buildMenuButton(
                  title: 'Emprestar Kimono',
                  color: AppColors.royalAzure,
                  onTap: () => setState(() => viewState = 'emprestar_aluno'),
                ),
                const SizedBox(height: 24),
                _buildMenuButton(
                  title: 'Recuperar Kimono',
                  color: AppColors.cyanPrimary,
                  onTap: () => setState(() => viewState = 'recuperar_aluno'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton({required String title, required Color color, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --- VIEW: SELEÇÃO DE ALUNO ---
  Widget _buildSelecaoAlunoView({required bool isEmprestar}) {
    final filteredAlunos = alunos.where((a) => a.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(onPressed: () => setState(() => viewState = 'escolha')),
          const SizedBox(height: 16),
          Text(
            isEmprestar ? 'Emprestar Kimono para:' : 'Pegar kimono de:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar aluno...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            onChanged: (val) => setState(() => searchQuery = val),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: filteredAlunos.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.grey.shade300),
                    title: Text(filteredAlunos[index], style: const TextStyle(fontWeight: FontWeight.w500)),
                    onTap: () {
                      alunoSelecionado = filteredAlunos[index];
                      if (isEmprestar) {
                        _showPopUpSelecaoKimono();
                      } else {
                        _showPopUpConfirmacaoRecuperar();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- POP-UPS: EMPRESTAR ---
  void _showPopUpSelecaoKimono() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Escolha um kimono para emprestar:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Tamanho'),
                            value: filtroTamanho,
                            items: tamanhos.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                            onChanged: (val) => setPopupState(() => filtroTamanho = val),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Cor'),
                            value: filtroCor,
                            items: cores.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                            onChanged: (val) => setPopupState(() => filtroCor = val),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: kimonosDisponiveis.length,
                        itemBuilder: (context, index) {
                          final k = kimonosDisponiveis[index];
                          if (filtroTamanho != null && k['tamanho'] != filtroTamanho) return const SizedBox.shrink();
                          if (filtroCor != null && k['cor'] != filtroCor) return const SizedBox.shrink();

                          final isSelected = kimonoSelecionado == k;
                          return ListTile(
                            leading: const Icon(Icons.checkroom, color: AppColors.royalAzure),
                            title: Text('${k['tamanho']}, ${k['cor']}'),
                            trailing: Radio<Map<String, String>>(
                              value: k,
                              groupValue: kimonoSelecionado,
                              onChanged: (val) => setPopupState(() => kimonoSelecionado = val),
                            ),
                            onTap: () => setPopupState(() => kimonoSelecionado = k),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyanPrimary),
                  onPressed: kimonoSelecionado == null ? null : () {
                    Navigator.pop(context);
                    _showPopUpConfirmacaoEmprestimo();
                  },
                  child: const Text('Avançar', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showPopUpConfirmacaoEmprestimo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'Deseja emprestar este kimono para o aluno $alunoSelecionado?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showPopUpSelecaoKimono();
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyanPrimary),
                    onPressed: () {
                      Navigator.pop(context);
                      _showPopUpSucesso('O kimono foi emprestado com sucesso!');
                    },
                    child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showPopUpConfirmacaoRecuperar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'Deseja pegar o kimono de $alunoSelecionado?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyanPrimary),
                    onPressed: () {
                      Navigator.pop(context);
                      _showPopUpSucesso('O kimono foi recuperado com sucesso!');
                    },
                    child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showPopUpSucesso(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyanPrimary, minimumSize: const Size(120, 40)),
              onPressed: () {
                Navigator.pop(context);
                _resetSelection();
                setState(() => viewState = 'escolha');
              },
              child: const Text('Fechar', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
