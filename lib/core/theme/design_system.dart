import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PuckeyColors {
  // Primary background
  static const Color background = Color(0xFF0A192F);
  static const Color surface = Color(0xFF112240);
  static const Color surfaceLight = Color(0xFF233554);

  // Brand colors
  static const Color teal = Color(0xFF64FFDA);
  static const Color tealSecondary = Color(0xFF00BFA5);
  static const Color mint = Color(0xFFB2FF59);
  
  // Accents
  static const Color iceBlue = Color(0xFFE6F1FF);
  static const Color slate = Color(0xFF8892B0);
  static const Color lightSlate = Color(0xFFA8B2D1);
  
  // Status
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF64FFDA);
}

class PuckeyTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: PuckeyColors.background,
      colorScheme: const ColorScheme.dark(
        primary: PuckeyColors.teal,
        secondary: PuckeyColors.mint,
        surface: PuckeyColors.surface,
        error: PuckeyColors.error,
        onPrimary: PuckeyColors.background,
        onSecondary: PuckeyColors.background,
        onSurface: PuckeyColors.iceBlue,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: PuckeyColors.iceBlue, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: PuckeyColors.iceBlue, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: PuckeyColors.lightSlate),
          bodyMedium: TextStyle(color: PuckeyColors.slate),
        ),
      ),
      cardTheme: CardThemeData(
        color: PuckeyColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: PuckeyColors.surfaceLight, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: PuckeyColors.teal,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
