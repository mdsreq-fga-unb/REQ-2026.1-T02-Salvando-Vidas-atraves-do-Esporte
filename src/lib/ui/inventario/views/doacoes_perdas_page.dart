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

  final _doadorController = TextEditingController();
  final _qtdDoadaController = TextEditingController();
  final _motivoController = TextEditingController();
  final _qtdPerdidaController = TextEditingController();

  @override
  void dispose() {
    _doadorController.dispose();
    _qtdDoadaController.dispose();
    _motivoController.dispose();
    _qtdPerdidaController.dispose();
    super.dispose();
  }

  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  Color get cardBg => isDark ? AppColors.darkSurface : Colors.white;
  Color get textColor => isDark ? Colors.white : Colors.black87;
  Color get inputFill =>
      isDark ? AppColors.darkInputFill : Colors.grey.shade200;
  Color get hintColor => isDark ? Colors.white54 : Colors.black54;
  Color get cancelBtnBg => isDark ? Colors.grey.shade800 : Colors.grey.shade300;
  Color get cancelBtnText => isDark ? Colors.white : Colors.black87;

  // --- MÉTODOS DOS POP-UPS ---

  void _mostrarConfirmacaoDoacao() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar este\nkimono (${state.tamanhoDoacao!.nomeVisivel}, ${state.corDoacao!.nomeVisivel})?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor,
          ),
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
                    .cadastrarDoacao(state.doacao);
                store.reset();
                _doadorController.clear();
                _qtdDoadaController.clear();
                await ref.refresh(gestaoKimonosStoreProvider.future);
                if (context.mounted) {
                  Navigator.pop(context);
                  _mostrarSucessoDoacao();
                }
              } on AppApiException catch (e) {
                ref.read(loggerProvider).e(e.message, error: e.error);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao registrar doação.'),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              } catch (e) {
                ref.read(loggerProvider).e(
                  'Erro inesperado ao registrar doação',
                  error: e,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao registrar doação.'),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor,
          ),
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor,
          ),
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
                _motivoController.clear();
                _qtdPerdidaController.clear();
                await ref.refresh(gestaoKimonosStoreProvider.future);
                if (context.mounted) {
                  Navigator.pop(context);
                  _mostrarSucessoPerda();
                }
              } on AppApiException catch (e) {
                ref.read(loggerProvider).e(e.message, error: e.error);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              } catch (e) {
                ref.read(loggerProvider).e(
                  'Erro inesperado ao registrar perda',
                  error: e,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao registrar perda.'),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor,
          ),
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

    if (_doadorController.text != state.doador) {
      _doadorController.text = state.doador;
    }
    if (_qtdDoadaController.text != state.qtdDoada) {
      _qtdDoadaController.text = state.qtdDoada;
    }
    if (_motivoController.text != state.motivo) {
      _motivoController.text = state.motivo;
    }
    if (_qtdPerdidaController.text != state.qtdPerdida) {
      _qtdPerdidaController.text = state.qtdPerdida;
    }

    int doacoes = 0;
    int perdas = 0;

    if (estoque.value != null) {
      if (estoque.value!.estoque != state.estoqueList) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) store.syncEstoque(estoque.value!.estoque);
        });
      }

      for (final perda in estoque.value!.perdas) {
        perdas += perda.quantidade;
      }

      for (final doacao in estoque.value!.doacoes) {
        doacoes += doacao.quantidade;
      }
    }

    final gradientColors = isDark
        ? AppColors.bgGradientDark
        : AppColors.bgGradientLight;

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
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_ios, color: textColor, size: 18),
                  label: Text(
                    'Voltar',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.cyanPrimary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.volunteer_activism,
                        color: AppColors.cyanPrimary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Doações & Perdas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.deepNavy,
                      ),
                    ),
                  ],
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
                          Row(
                            children: [
                              Expanded(
                                child: _StatCardInfo(
                                  title: 'Doações\nTotais',
                                  value: '$doacoes',
                                  icon: Icons.card_giftcard,
                                  gradientColors: isDark
                                      ? const [
                                          Color(0xFF041E42),
                                          Color(0xFF006680),
                                        ]
                                      : const [
                                          Color(0xFF1976D2),
                                          Color(0xFF26C6DA),
                                        ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _StatCardInfo(
                                  title: 'Perdas\nTotais',
                                  value: '$perdas',
                                  icon: Icons.warning_amber_rounded,
                                  gradientColors: isDark
                                      ? const [
                                          Color(0xFF4E1400),
                                          Color(0xFFB71C1C),
                                        ]
                                      : const [
                                          Color(0xFFE64A19),
                                          Color(0xFFFF8A65),
                                        ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Card Expansível: Registrar Doação
                          _buildExpandableCard(
                            title: 'Registrar uma doação',
                            subtitle: 'Escolha o tamanho e a cor',
                            leadingIcon: Icons.card_giftcard,
                            isExpandedContent: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Linha com Tamanho e Cor lado a lado
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: inputFill,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: isDark
                                                ? Colors.white12
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<TamanhoKimono>(
                                            isExpanded: true,
                                            dropdownColor: cardBg,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: textColor,
                                            ),
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: 15,
                                            ),
                                            hint: Row(
                                              children: [
                                                Icon(
                                                  Icons.straighten,
                                                  size: 18,
                                                  color: hintColor,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Tamanho',
                                                  style: TextStyle(
                                                    color: hintColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            value: state.tamanhoDoacao,
                                            items: TamanhoKimono.values
                                                .map(
                                                  (c) =>
                                                      DropdownMenuItem<
                                                        TamanhoKimono
                                                      >(
                                                        value: c,
                                                        child: Text(
                                                          c.nomeVisivel,
                                                          style: TextStyle(
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ),
                                                )
                                                .toList(),
                                            onChanged: (val) =>
                                                store.updateTamanhoDoacao(val),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: inputFill,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: isDark
                                                ? Colors.white12
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<CorKimono>(
                                            isExpanded: true,
                                            dropdownColor: cardBg,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: textColor,
                                            ),
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: 15,
                                            ),
                                            hint: Row(
                                              children: [
                                                Icon(
                                                  Icons.palette_outlined,
                                                  size: 18,
                                                  color: hintColor,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Cor',
                                                  style: TextStyle(
                                                    color: hintColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            value: state.corDoacao,
                                            items: CorKimono.values
                                                .map(
                                                  (c) =>
                                                      DropdownMenuItem<
                                                        CorKimono
                                                      >(
                                                        value: c,
                                                        child: Text(
                                                          c.nomeVisivel,
                                                          style: TextStyle(
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ),
                                                )
                                                .toList(),
                                            onChanged: (val) =>
                                                store.updateCorDoacao(val),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                TextFormField(
                                  controller: _doadorController,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Nome do doador...',
                                    hintStyle: TextStyle(
                                      color: hintColor,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person_outline,
                                      color: AppColors.cyanPrimary,
                                      size: 22,
                                    ),
                                    filled: true,
                                    fillColor: inputFill,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.cyanPrimary,
                                        width: 1.5,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  onChanged: store.updateDoador,
                                ),
                                const SizedBox(height: 14),
                                TextFormField(
                                  controller: _qtdDoadaController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Quantidade doada...',
                                    hintStyle: TextStyle(
                                      color: hintColor,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.numbers,
                                      color: AppColors.cyanPrimary,
                                      size: 22,
                                    ),
                                    filled: true,
                                    fillColor: inputFill,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.cyanPrimary,
                                        width: 1.5,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    errorText: state.qtdDoada.isNotEmpty
                                        ? state.qtdDoadaError
                                        : null,
                                  ),
                                  onChanged: store.updateQtdDoada,
                                ),
                                const SizedBox(height: 18),
                                SizedBox(
                                  height: 48,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.cyanPrimary,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: isDark
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade300,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: state.doacaoValida ? 2 : 0,
                                    ),
                                    onPressed: state.doacaoValida
                                        ? _mostrarConfirmacaoDoacao
                                        : null,
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      size: 20,
                                    ),
                                    label: const Text(
                                      'Confirmar Doação',
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
                            leadingIcon: Icons.warning_amber_rounded,
                            isExpandedContent: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      size: 18,
                                      color: AppColors.cyanPrimary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Selecione o Kimono no Estoque:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 220,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.darkBg
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white12
                                          : Colors.grey.shade200,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: estoque.when(
                                    data: (data) {
                                      if (data.estoque.isEmpty) {
                                        return Center(
                                          child: Text(
                                            'Nenhum kimono no estoque',
                                            style: TextStyle(color: hintColor),
                                          ),
                                        );
                                      }
                                      return Scrollbar(
                                        thumbVisibility: true,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.estoque.length,
                                          itemBuilder: (context, index) {
                                            final kimono = data.estoque[index];
                                            final isSelected =
                                                state.kimonoPerdido == kimono;
                                            return InkWell(
                                              onTap: () => store
                                                  .updateKimonoPerdido(kimono),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 6,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? AppColors.cyanPrimary
                                                            .withOpacity(
                                                              isDark
                                                                  ? 0.25
                                                                  : 0.12,
                                                            )
                                                      : (isDark
                                                            ? AppColors
                                                                  .darkInputFill
                                                            : Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: isSelected
                                                        ? AppColors.cyanPrimary
                                                        : (isDark
                                                              ? Colors.white12
                                                              : Colors
                                                                    .grey
                                                                    .shade200),
                                                    width: isSelected ? 1.5 : 1,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.sports_martial_arts,
                                                      size: 22,
                                                      color: isSelected
                                                          ? AppColors
                                                                .cyanPrimary
                                                          : textColor,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        '${kimono.tamanho.nomeVisivel}, ${kimono.cor.nomeVisivel}',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: isSelected
                                                              ? FontWeight.bold
                                                              : FontWeight.w500,
                                                          color: textColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: isSelected
                                                              ? AppColors
                                                                    .cyanPrimary
                                                              : hintColor,
                                                          width: 2,
                                                        ),
                                                        color: isSelected
                                                            ? AppColors
                                                                  .cyanPrimary
                                                            : Colors
                                                                  .transparent,
                                                      ),
                                                      child: isSelected
                                                          ? const Icon(
                                                              Icons.check,
                                                              size: 14,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : null,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    error: (error, stack) => const Center(
                                      child: Text('Erro ao carregar kimonos'),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.cyanPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                TextFormField(
                                  controller: _motivoController,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Motivo da perda (ex: Desgaste, rasgo)...',
                                    hintStyle: TextStyle(
                                      color: hintColor,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.description_outlined,
                                      color: AppColors.cyanPrimary,
                                      size: 22,
                                    ),
                                    filled: true,
                                    fillColor: inputFill,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.cyanPrimary,
                                        width: 1.5,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  onChanged: store.updateMotivo,
                                ),
                                const SizedBox(height: 14),
                                TextFormField(
                                  controller: _qtdPerdidaController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Quantidade perdida...',
                                    hintStyle: TextStyle(
                                      color: hintColor,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.numbers,
                                      color: AppColors.cyanPrimary,
                                      size: 22,
                                    ),
                                    filled: true,
                                    fillColor: inputFill,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: isDark
                                            ? Colors.white12
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.cyanPrimary,
                                        width: 1.5,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    errorText: state.qtdPerdida.isNotEmpty
                                        ? state.qtdPerdidaError
                                        : null,
                                  ),
                                  onChanged: store.updateQtdPerdida,
                                ),
                                const SizedBox(height: 18),
                                SizedBox(
                                  height: 48,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.cyanPrimary,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: isDark
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade300,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation:
                                          state.perdaValida(
                                            estoque.value?.estoque,
                                          )
                                          ? 2
                                          : 0,
                                    ),
                                    onPressed:
                                        state.perdaValida(
                                          estoque.value?.estoque,
                                        )
                                        ? _mostrarConfirmacaoPerda
                                        : null,
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      size: 20,
                                    ),
                                    label: const Text(
                                      'Confirmar Perda',
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
    IconData? leadingIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: leadingIcon != null
              ? Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.cyanPrimary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    leadingIcon,
                    color: AppColors.cyanPrimary,
                    size: 24,
                  ),
                )
              : null,
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
  final IconData icon;
  final List<Color> gradientColors;

  const _StatCardInfo({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.9), size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
