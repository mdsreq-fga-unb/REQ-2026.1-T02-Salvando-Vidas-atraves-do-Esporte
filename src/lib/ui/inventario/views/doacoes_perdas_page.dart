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

  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  Color get cardBg => isDark ? AppColors.darkSurface : Colors.white;
  Color get textColor => isDark ? Colors.white : Colors.black87;
  Color get inputFill => isDark ? AppColors.darkInputFill : Colors.grey.shade200;
  Color get hintColor => isDark ? Colors.white54 : Colors.black54;
  Color get cancelBtnBg => isDark ? Colors.grey.shade800 : Colors.grey.shade300;
  Color get cancelBtnText => isDark ? Colors.white : Colors.black87;

  // --- MÉTODOS DOS POP-UPS ---

  void _mostrarConfirmacaoDoacao() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6), // Fundo escurecido
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar este\nkimono (${state.tamanhoDoacao!.nomeVisivel}, ${state.corDoacao!.nomeVisivel})?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cancelBtnBg,
              foregroundColor: cancelBtnText,
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
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'A doação do kimono foi\nregistrada com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
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
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar a perda\nde ${state.qtdPerdida} kimonos (${kimono.tamanho.nomeVisivel}, ${kimono.cor.nomeVisivel})?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cancelBtnBg,
              foregroundColor: cancelBtnText,
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
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'A perda do kimono foi\nregistrada com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão Voltar
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: TextButton.icon(
                  onPressed: () => context.pop(), // Volta para a tela anterior
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: textColor,
                    size: 18,
                  ),
                  label: Text(
                    'Voltar',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
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
                                color: inputFill,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<TamanhoKimono>(
                                  isExpanded: true,
                                  dropdownColor: cardBg,
                                  icon: Icon(Icons.arrow_drop_down, color: textColor),
                                  style: TextStyle(color: textColor, fontSize: 16),
                                  hint: Text('Tamanho...', style: TextStyle(color: hintColor)),
                                  value: state.tamanhoDoacao,
                                  items: TamanhoKimono.values
                                      .map(
                                        (c) => DropdownMenuItem<TamanhoKimono>(
                                          value: c,
                                          child: Text(c.nomeVisivel, style: TextStyle(color: textColor)),
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
                                color: inputFill,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<CorKimono>(
                                  isExpanded: true,
                                  dropdownColor: cardBg,
                                  icon: Icon(Icons.arrow_drop_down, color: textColor),
                                  style: TextStyle(color: textColor, fontSize: 16),
                                  hint: Text('Cor...', style: TextStyle(color: hintColor)),
                                  value: state.corDoacao,
                                  items: CorKimono.values
                                      .map(
                                        (c) => DropdownMenuItem<CorKimono>(
                                          value: c,
                                          child: Text(c.nomeVisivel, style: TextStyle(color: textColor)),
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
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                hintText: 'Nome do doador...',
                                hintStyle: TextStyle(color: hintColor),
                                filled: true,
                                fillColor: inputFill,
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
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                hintText: 'Quantidade doada...',
                                hintStyle: TextStyle(color: hintColor),
                                filled: true,
                                fillColor: inputFill,
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
                                color: inputFill,
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
                                            Icon(
                                              Icons.sports_martial_arts,
                                              size: 24,
                                              color: textColor,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              '${kimono.tamanho.nomeVisivel}, ${kimono.cor.nomeVisivel}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: textColor,
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
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                hintText: 'Motivo da perda...',
                                hintStyle: TextStyle(color: hintColor),
                                filled: true,
                                fillColor: inputFill,
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
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                hintText: 'Quantidade perdida...',
                                hintStyle: TextStyle(color: hintColor),
                                filled: true,
                                fillColor: inputFill,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ), // Remove as linhas padrão do ExpansionTile
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: subColor),
          ),
          iconColor: textColor,
          collapsedIconColor: textColor,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
