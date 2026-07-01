import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.royalAzure,
      brightness: Brightness.light,
      primary: AppColors.royalAzure,
      secondary: AppColors.cyanPrimary,
      error: AppColors.error,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.platinum,
    cardColor: Colors.white,
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 6,
      shadowColor: AppColors.royalAzure.withOpacity(0.18),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dividerColor: AppColors.divider,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFill,
      hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.royalAzure, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.royalAzure,
        foregroundColor: AppColors.textOnDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? AppColors.royalAzure : AppColors.textSecondary),
      trackColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? AppColors.cyanPastel : AppColors.divider),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cyanPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.highlightBlue,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.royalAzure,
      brightness: Brightness.dark,
      primary: AppColors.royalAzure,
      secondary: AppColors.cyanPrimary,
      error: AppColors.error,
      surface: AppColors.darkSurface,
    ),
    scaffoldBackgroundColor: AppColors.darkBg,
    cardColor: AppColors.darkSurface,
    
    // AQUI ESTAVA O ÚLTIMO ERRO! Agora está como CardThemeData :)
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 6,
      shadowColor: AppColors.royalAzure.withOpacity(0.35),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    
    dividerColor: AppColors.darkDivider,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputFill,
      hintStyle: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.royalAzure, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.royalAzure,
        foregroundColor: AppColors.textOnDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? AppColors.cyanPrimary : AppColors.darkTextSecondary),
      trackColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? AppColors.royalAzure.withOpacity(0.5) : AppColors.darkDivider),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkTopbar,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkNavbar,
      indicatorColor: AppColors.highlightBlue,
    ),
  );
}