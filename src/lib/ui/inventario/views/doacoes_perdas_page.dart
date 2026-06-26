import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/services/kimono_service/kimono_service.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
import 'package:salvando_vidas/data/stores/registro_kimonos/registro_kimonos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class DoacoesPerdasPage extends ConsumerStatefulWidget {
  const DoacoesPerdasPage({super.key});

  @override
  ConsumerState<DoacoesPerdasPage> createState() => _DoacoesPerdasPageState();
}

class _DoacoesPerdasPageState extends ConsumerState<DoacoesPerdasPage> {
  late RegistroKimonosState state;
  late RegistroKimonosStore store;

  // --- MÉTODOS DOS POP-UPS ---

  void _mostrarConfirmacaoDoacao() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6), // Fundo escurecido
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar este\nkimono (${state.tamanhoDoacao!.nomeVisivel}, ${state.corDoacao!.nomeVisivel})?',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context), // Cancela e fecha
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              try {
                await ref
                    .read(kimonoServiceProvider)
                    .cadastrarDoacao(state.doacao);
                store.reset();
                ref.refresh(gestaoKimonosStoreProvider.future);
                Navigator.pop(context); // Fecha confirmação
                _mostrarSucessoDoacao(); // Abre sucesso
              } on AppApiException catch (e) {
                ref.read(loggerProvider).e(e.message, error: e.error);
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _mostrarSucessoDoacao() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'A doação do kimono foi\nregistrada com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarConfirmacaoPerda() {
    final kimono = state.kimonoPerdido!;
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar a perda\nde ${state.qtdPerdida} kimonos (${kimono.tamanho.nomeVisivel}, ${kimono.cor.nomeVisivel})?',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              try {
                await ref
                    .read(kimonoServiceProvider)
                    .cadastrarPerda(state.perda);
                store.reset();
                ref.refresh(gestaoKimonosStoreProvider.future);
                Navigator.pop(context); // Fecha confirmação
                _mostrarSucessoPerda(); // Abre sucesso
              } on AppApiException catch (e) {
                ref.read(loggerProvider).e(e.message, error: e.error);
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _mostrarSucessoPerda() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'A perda do kimono foi\nregistrada com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }

  // --- CONSTRUÇÃO DA TELA ---

  @override
  Widget build(BuildContext context) {
    final estoque = ref.watch(gestaoKimonosStoreProvider);

    state = ref.watch(registroKimonosStoreProvider);
    store = ref.read(registroKimonosStoreProvider.notifier);

    int doacoes = 0;
    int perdas = 0;

    if (estoque.value != null) {
      for (final perda in estoque.value!.perdas) {
        perdas += perda.quantidade;
      }

      for (final doacao in estoque.value!.doacoes) {
        doacoes += doacao.quantidade;
      }
    }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão Voltar
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: TextButton.icon(
                  onPressed: () => context.pop(), // Volta para a tela anterior
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87,
                    size: 18,
                  ),
                  label: const Text(
                    'Voltar',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      // Cards de Totais
                      Row(
                        children: [
                          Expanded(
                            child: _StatCardInfo(
                              title: 'Doações\nTotais',
                              value: '$doacoes',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _StatCardInfo(
                              title: 'Perdas\nTotais',
                              value: '$perdas',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Card Expansível: Registrar Doação
                      _buildExpandableCard(
                        title: 'Registrar uma doação',
                        subtitle: 'Escolha o tamanho e a cor',
                        isExpandedContent: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<TamanhoKimono>(
                                  isExpanded: true,
                                  hint: const Text('Tamanho...'),
                                  value: state.tamanhoDoacao,
                                  items: TamanhoKimono.values
                                      .map(
                                        (c) => DropdownMenuItem<TamanhoKimono>(
                                          value: c,
                                          child: Text(c.nomeVisivel),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) =>
                                      store.updateTamanhoDoacao(val),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<CorKimono>(
                                  isExpanded: true,
                                  hint: const Text('Cor...'),
                                  value: state.corDoacao,
                                  items: CorKimono.values
                                      .map(
                                        (c) => DropdownMenuItem<CorKimono>(
                                          value: c,
                                          child: Text(c.nomeVisivel),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) =>
                                      store.updateCorDoacao(val),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: state.doador,
                              decoration: InputDecoration(
                                hintText: 'Nome do doador...',
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: store.updateDoador,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: state.qtdDoada,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Quantidade doada...',
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: store.updateQtdDoada,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: (state.doacaoValida)
                                    ? _mostrarConfirmacaoDoacao
                                    : null, // Fica desabilitado se não preencher tudo
                                child: const Text(
                                  'Registrar Doação',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Card Expansível: Registrar Perda
                      _buildExpandableCard(
                        title: 'Registrar uma perda',
                        subtitle: 'Escolha o kimono perdido',
                        isExpandedContent: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: estoque.when(
                                data: (data) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.estoque.length,
                                  itemBuilder: (context, index) {
                                    final kimono = data.estoque[index];
                                    return RadioGroup<Estoque>(
                                      groupValue: state.kimonoPerdido,
                                      onChanged: (v) =>
                                          store.updateKimonoPerdido(v),
                                      child: RadioListTile<Estoque>(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Row(
                                          children: [
                                            const Icon(
                                              Icons.sports_martial_arts,
                                              size: 24,
                                              color: Colors.black87,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              '${kimono.tamanho.nomeVisivel}, ${kimono.cor.nomeVisivel}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        value: kimono,
                                        activeColor: Colors.cyan,
                                      ),
                                    );
                                  },
                                ),
                                error: (error, stack) {
                                  if (error is AppApiException) {
                                    ref
                                        .read(loggerProvider)
                                        .e(error.message, error: error.error);
                                  }
                                  return const Center(
                                    child: Text(
                                      'Ocorreu algum erro inesperado ao carregar o estoque de kimonos',
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: state.motivo,
                              decoration: InputDecoration(
                                hintText: 'Motivo da perda...',
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: store.updateMotivo,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: state.qtdPerdida,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Quantidade perdida...',
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: store.updateQtdPerdida,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: (state.perdaValida)
                                    ? _mostrarConfirmacaoPerda
                                    : null,
                                child: const Text(
                                  'Registrar Perda',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para construir as áreas expansíveis mantendo o estilo de Card branco com sombra
  Widget _buildExpandableCard({
    required String title,
    required String subtitle,
    required Widget isExpandedContent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ), // Remove as linhas padrão do ExpansionTile
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          iconColor: Colors.black87,
          collapsedIconColor: Colors.black87,
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          children: [const SizedBox(height: 8), isExpandedContent],
        ),
      ),
    );
  }
}

// Widget auxiliar para os cards do topo (Totais)
class _StatCardInfo extends StatelessWidget {
  final String title;
  final String value;

  const _StatCardInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
