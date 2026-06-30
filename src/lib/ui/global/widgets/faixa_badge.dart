import 'package:flutter/material.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

/// Cores de cada faixa.
/// [main] = cor principal | [stripe] = cor da listra da ponta (faixa preta = vermelho) | [text] = cor do texto
({Color main, Color? stripe, Color text}) faixaCores(Faixa faixa) {
  return switch (faixa) {
    Faixa.branca  => (main: Colors.white,                 stripe: null,                    text: Colors.black87),
    Faixa.cinza   => (main: const Color(0xFF808080),      stripe: null,                    text: Colors.white),
    Faixa.amarela => (main: const Color(0xFFFFC107),      stripe: null,                    text: Colors.white),
    Faixa.laranja => (main: const Color(0xFFFF8C00),      stripe: null,                    text: Colors.white),
    Faixa.verde   => (main: const Color(0xFF2E8B00),      stripe: null,                    text: Colors.white),
    Faixa.azul    => (main: const Color(0xFF1A1AFF),      stripe: null,                    text: Colors.white),
    Faixa.roxa    => (main: const Color(0xFF5B2D8E),      stripe: null,                    text: Colors.white),
    Faixa.marrom  => (main: const Color(0xFF7B3F00),      stripe: null,                    text: Colors.white),
    Faixa.preta   => (main: Colors.black,                 stripe: const Color(0xFFDD0000), text: Colors.white),
  };
}

// ─────────────────────────────────────────────────────────────
// Avatar circular com a cor da faixa
// ─────────────────────────────────────────────────────────────
class FaixaAvatar extends StatelessWidget {
  final Faixa faixa;
  final double radius;

  const FaixaAvatar({super.key, required this.faixa, this.radius = 22});

  @override
  Widget build(BuildContext context) {
    final cores = faixaCores(faixa);

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cores.main,
        border: Border.all(
          color: faixa == Faixa.branca
              ? Colors.grey.shade300
              : cores.main.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: cores.main.withOpacity(0.35),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: cores.stripe != null
          ? ClipOval(
              child: Stack(
                children: [
                  // fundo preto
                  Positioned.fill(child: Container(color: cores.main)),
                  // listra branca fina central
                  Positioned(
                    left: radius * 0.6,
                    right: radius * 0.6,
                    top: 0,
                    bottom: 0,
                    child: Container(color: Colors.white),
                  ),
                  // listra colorida (vermelha) mais fina ainda
                  Positioned(
                    left: radius * 0.75,
                    right: radius * 0.75,
                    top: 0,
                    bottom: 0,
                    child: Container(color: cores.stripe),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class FaixaDropdownItem extends StatelessWidget {
  final Faixa faixa;

  const FaixaDropdownItem({super.key, required this.faixa});

  @override
  Widget build(BuildContext context) {
    final cores = faixaCores(faixa);
    final ponteColor = faixa == Faixa.preta ? cores.stripe! : cores.main;

    return Container(
      height: 44,
      color: cores.main,
      child: Row(
        children: [
          // ── Texto ──────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                faixa.nomeVisivel,
                style: TextStyle(
                  color: cores.text,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

          // ── Ponta direita da faixa ─────────────────────
          // Faixas coloridas: [cor_fina] [preto] [cor_fina]
          // Faixa preta:      fundo preto + [branco] [vermelho] [branco] no centro
          SizedBox(
            width: 72,
            height: 44,
            child: faixa == Faixa.preta
                ? Stack(
                    children: [
                      // Fundo preto
                      Positioned.fill(child: Container(color: Colors.black)),
                      // Listra branca esquerda
                      Positioned(
                        left: 14, top: 0, bottom: 0, width: 10,
                        child: Container(color: Colors.white),
                      ),
                      // Listra vermelha central
                      Positioned(
                        left: 24, top: 0, bottom: 0, width: 20,
                        child: Container(color: cores.stripe),
                      ),
                      // Listra branca direita
                      Positioned(
                        left: 44, top: 0, bottom: 0, width: 10,
                        child: Container(color: Colors.white),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(width: 10, color: ponteColor),
                      Expanded(child: Container(color: Colors.black)),
                      Container(width: 10, color: ponteColor),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Item selecionado (campo fechado) — mais compacto
// ─────────────────────────────────────────────────────────────
class _SelectedFaixaItem extends StatelessWidget {
  final Faixa faixa;
  const _SelectedFaixaItem({required this.faixa});

  @override
  Widget build(BuildContext context) {
    final cores = faixaCores(faixa);
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: cores.main,
        borderRadius: BorderRadius.circular(12),
        border: faixa == Faixa.branca
            ? Border.all(color: Colors.grey.shade300)
            : null,
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        faixa.nomeVisivel,
        style: TextStyle(
          color: cores.text,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Dropdown completo reutilizável
// ─────────────────────────────────────────────────────────────
class FaixaDropdownField extends StatelessWidget {
  final Faixa? value;
  final ValueChanged<Faixa?> onChanged;
  final String? Function(Faixa?)? validator;
  final String label;

  const FaixaDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
    this.label = 'Faixa*',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark ? const Color(0xFF161B22) : const Color(0xFFF0F7F8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: isDark ? Colors.white70 : const Color(0xFF001B5F),
            ),
          ),
        ),
        DropdownButtonFormField<Faixa>(
          value: value,
          validator: validator,
          dropdownColor: isDark ? const Color(0xFF0D1117) : Colors.white,
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDark ? Colors.white70 : const Color(0xFF001B5F),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF245BE6), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE53935), width: 1),
            ),
          ),
          selectedItemBuilder: (context) =>
              Faixa.values.map((f) => _SelectedFaixaItem(faixa: f)).toList(),
          items: Faixa.values
              .map((f) => DropdownMenuItem<Faixa>(
                    value: f,
                    child: FaixaDropdownItem(faixa: f),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}