import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/login/theme/login_colors.dart';

class LoginDecorations {
  static const BoxDecoration pageBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [LoginColors.pageBgStart, LoginColors.pageBgEnd],
    ),
  );

  static final BoxDecoration formContainer = BoxDecoration(
    color: LoginColors.darkBlueBg,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: LoginColors.borderLightBlue),
    boxShadow: const [
      BoxShadow(
        color: LoginColors.shadowDark,
        blurRadius: 22,
        offset: Offset(0, 10),
      ),
    ],
  );

  static final BoxDecoration inputContainerShadow = BoxDecoration(
    borderRadius: BorderRadius.circular(34),
    boxShadow: const [
      BoxShadow(
        color: LoginColors.shadowMedium,
        blurRadius: 16,
        offset: Offset(0, 8),
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
    hintStyle: const TextStyle(color: LoginColors.hintText, fontSize: 13),
    filled: true,
    fillColor: LoginColors.inputFill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
    prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 56),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(34),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(34),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(34),
      borderSide: const BorderSide(color: LoginColors.primaryBlue, width: 1.5),
    ),
  );
}
