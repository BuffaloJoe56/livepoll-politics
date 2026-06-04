import 'package:flutter/material.dart';

class AppTheme {
  // LIGHT PROFESSIONAL THEME - Whitish/grey background (a few tints darker than before)
  static const Color background = Color(0xFFE5E7EB);       // Darker soft grey
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFE8EAED);
  static const Color surfaceElevated = Color(0xFFF1F3F5);

  // Political accent colors (high visibility)
  static const Color republicanRed = Color(0xFFDC2626);   // Red accent
  static const Color democratBlue = Color(0xFF1D4ED8);    // Blue accent
  static const Color primary = republicanRed;
  static const Color primaryVariant = Color(0xFFB91C1C);
  static const Color accent = democratBlue;

  // High contrast dark text for excellent readability (bright and strong)
  static const Color textPrimary = Color(0xFF000000);     // Pure black for max contrast
  static const Color textSecondary = Color(0xFF1F2937);   // Very dark grey
  static const Color textMuted = Color(0xFF4B5563);
  static const Color error = Color(0xFFDC2626);

  static final ThemeData dark = ThemeData(
    brightness: Brightness.light,   // Now using light theme for readability
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: surface,
      error: error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w800,
        color: textPrimary,
        letterSpacing: -0.3,
      ),
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: surfaceVariant, width: 1),
      ),
      margin: const EdgeInsets.all(8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textPrimary,
        side: BorderSide(color: surfaceVariant, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textPrimary),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: textSecondary,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    textTheme: const TextTheme(
      // Much stronger hierarchy and sizes for readability + professional feel
      headlineLarge: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: textPrimary, letterSpacing: -0.6, height: 1.1),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: textPrimary, letterSpacing: -0.4, height: 1.15),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: textPrimary, height: 1.25),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: textPrimary, height: 1.3),
      bodyLarge: TextStyle(fontSize: 17, color: textPrimary, height: 1.45, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 15, color: textSecondary, height: 1.5, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(fontSize: 13, color: textMuted, height: 1.4, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: surfaceVariant, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      labelStyle: const TextStyle(color: textSecondary, fontWeight: FontWeight.w600),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}
