import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WajabatTheme {
  // --- COLORS ---
  static const Color primary = Color(0xFF933D41);     // Rouge Terre (Chaleur)
  static const Color primaryDark = Color(0xFF7A2A2E); // Darker Rouge
  static const Color secondary = Color(0xFFE9B949);   // Jaune Safran (Énergie)
  static const Color background = Color(0xFFF8F4E9);  // Blanc Chaud (Propreté)
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF2D2D2D);    // Noir (Structure)
  static const Color textLight = Color(0xFF6B7280);   // Cool Grey
  static const Color success = Color(0xFF22C55E);     // Green
  static const Color error = Color(0xFFEF4444);       // Red

  // --- GRADIENTS ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFA54B51), Color(0xFF933D41)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF933D41), Color(0xFFB35A5E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.transparent, Color(0x99000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // --- TEXT STYLES (Outfit) ---
  static TextTheme get textTheme => GoogleFonts.outfitTextTheme().copyWith(
    displayLarge: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: textDark,
      letterSpacing: -1,
    ),
    displayMedium: GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textDark,
    ),
    titleLarge: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: textDark,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textDark,
    ),
    bodyMedium: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: textLight,
    ),
    labelLarge: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: surface,
    ),
  );

  // --- SHADOWS ---
  static List<BoxShadow> get shadowHero => [
    BoxShadow(
      color: primary.withOpacity(0.15),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> get shadowGlass => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get shadowSmall => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  // --- SHAPES ---
  static BorderRadius get radiusXL => BorderRadius.circular(32);
  static BorderRadius get radiusL => BorderRadius.circular(24);
  static BorderRadius get radiusM => BorderRadius.circular(16);
  static BorderRadius get radiusS => BorderRadius.circular(8);

  // --- FULL THEME DATA ---
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      surface: surface,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: background,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ),
  );
}
