import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primárias ──────────────────────────────────────────────────────────────
  static const Color royalAzure    = Color(0xFF245BE6); // Azul principal, botões, seleção
  static const Color deepNavy      = Color(0xFF001B5F); // Azul escuro, tooltips, headers
  static const Color cyanPrimary   = Color(0xFF3FB0C5); // Azul clarinho, topbar, acentos
  static const Color cyanPastel    = Color(0xFF9EBAFF); // Azul pastel, fundos suaves

  // ── Semânticas ─────────────────────────────────────────────────────────────
  static const Color error         = Color(0xFFE53935);
  static const Color success       = Color(0xFF26A69A);
  static const Color warning       = Color(0xFFF59E0B);

  // ── Neutros ────────────────────────────────────────────────────────────────
  static const Color black1        = Color(0xFF010409);
  static const Color black2        = Color(0xFF080808);
  static const Color white1        = Color(0xFFF6F9FA); // Bright Snow
  static const Color white2        = Color(0xFFF5F6FB); // Ghost White
  static const Color platinum      = Color(0xFFF0F7F8); // Fundo light
  static const Color textSecondary = Color(0xFF6B7280); // Texto secundário / hint

  // ── Texto ──────────────────────────────────────────────────────────────────
  static const Color textOnDark    = white1;
  static const Color textOnLight   = black1;

  // ── Sombras & Bordas ───────────────────────────────────────────────────────
  static const Color shadowLight   = Color(0x18000000);
  static const Color shadowMedium  = Color(0x22000000);
  static const Color shadowDark    = Color(0x2A000000);
  static const Color borderSubtle  = Color(0x22245BE6);
  static const Color bgGradientEnd = Color(0xFFE4E4E4);
  static const Color divider       = Color(0xFFE6E6E6);

  // ── Interações ─────────────────────────────────────────────────────────────
  static const Color splashBlue    = Color(0x44245BE6);
  static const Color highlightBlue = Color(0x22245BE6);
  static const Color inputFill     = platinum;
  static const Color inputBorder   = royalAzure;

  // ── Dark mode ──────────────────────────────────────────────────────────────
  static const Color darkBg        = Color(0xFF010409); // Fundo principal dark
  static const Color darkSurface   = Color(0xFF0D1117); // Cards, containers dark
  static const Color darkNavbar    = Color(0xFF080808); // Navbar dark
  static const Color darkTopbar    = Color(0xFF001B5F); // Topbar dark (Deep Navy)
  static const Color darkInputFill = Color(0xFF161B22); // Input fill dark
  static const Color darkDivider   = Color(0xFF21262D); // Divisores dark
  static const Color darkTextPrimary   = white1;        // Texto principal dark
  static const Color darkTextSecondary = Color(0xFF8B949E); // Texto secundário dark

  // ── Gradients & Card Glow ──────────────────────────────────────────────────
  static const List<Color> bgGradientDark  = [darkBg, Color(0xFF0D1B2A)];
  static const List<Color> bgGradientLight = [Color(0xFFF0F8FF), Color(0xFFD8ECFF)];

  static List<BoxShadow> cardShadow(bool isDark) => [
        BoxShadow(
          color: royalAzure.withOpacity(isDark ? 0.35 : 0.18),
          blurRadius: 16,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ];
}

// Aliases legados
class PaletaDeCores {
  static const primaryCyan     = AppColors.cyanPrimary;
  static const lightCyan       = AppColors.cyanPastel;
  static const textCyan        = AppColors.cyanPrimary;
  static const primaryBlue     = AppColors.royalAzure;
  static const darkBlueBg      = AppColors.deepNavy;
  static const iconNavy        = AppColors.deepNavy;
  static const inputFill       = AppColors.inputFill;
  static const pageBgStart     = AppColors.platinum;
  static const pageBgEnd       = AppColors.white2;
  static const shadowLight     = AppColors.shadowLight;
  static const shadowMedium    = AppColors.shadowMedium;
  static const shadowDark      = AppColors.shadowDark;
  static const borderLightBlue = AppColors.borderSubtle;
  static const hintText        = AppColors.textSecondary;
}