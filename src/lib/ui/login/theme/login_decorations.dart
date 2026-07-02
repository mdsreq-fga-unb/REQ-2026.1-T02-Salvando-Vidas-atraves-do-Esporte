import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/login/theme/login_colors.dart';

class LoginDecorations {
  static const BoxDecoration pageBackground = BoxDecoration(
    color: Color(0xFFCAD8DF), // Cor de fundo azulada conforme a imagem
  );

  static final BoxDecoration formContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 12,
        offset: Offset(0, 8),
      ),
    ],
  );

  static final BoxDecoration inputContainerShadow = BoxDecoration(
    borderRadius: BorderRadius.circular(34),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const BoxDecoration prefixIconGradient = BoxDecoration(
    borderRadius: BorderRadius.horizontal(left: Radius.circular(34)),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [LoginColors.primaryCyan, LoginColors.lightCyan],
    ),
  );

  static InputDecoration baseInputDecoration = InputDecoration(
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
    filled: true,
    fillColor: const Color(0xFFEBEBEB), // Cor cinza claro conforme a imagem
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 48),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(34),
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(34),
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(34),
      borderSide: const BorderSide(color: LoginColors.primaryCyan, width: 1.5),
    ),
  );
}
