import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WajabatTheme {
  // --- COLORS ---
  static const Color primary = Color(0xFF933D41);     // Rouge Terre (Chaleur)
  static const Color primaryDark = Color(0xFF7A2A2E); // Darker Rouge
  static const Color secondary = Color(0xFFE9B949);   // Jaune Safran (Énergie)
  static const Color background = Color(0xFFF8F4E9);  // Blanc Chaud (Propreté)
  static const Color surface = Colors.white;          // White cards/nav
  static const Color inputFill = Color(0xFFF2F2F2);   // Light grey inputs
  static const Color textDark = Color(0xFF1E1E1E);    // Darkest grey/black
  static const Color textLight = Color(0xFF757575);   // Secondary text
  static const Color success = Color(0xFF22C55E);     // Green
  static const Color error = Color(0xFFEF4444);       // Red

  // --- TEXT STYLES (Montserrat) ---
  static TextTheme get textTheme => GoogleFonts.montserratTextTheme().copyWith(
    displayLarge: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: textDark,
      letterSpacing: -1,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textDark,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: textDark,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textDark,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: textLight,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: surface,
    ),
  );

  // --- SHADOWS ---
  // Minimalist Jahez-style shadows (very subtle)
  static List<BoxShadow> get shadowSmall => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get shadowFloating => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

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
      backgroundColor: Colors.transparent, // Clean, modern app bars
      foregroundColor: textDark,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: textDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0, // Flat design
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), // Pill shaped
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50), // Pill search bars
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: GoogleFonts.montserrat(color: textLight),
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
