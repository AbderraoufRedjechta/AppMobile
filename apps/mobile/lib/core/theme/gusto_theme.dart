import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GustoTheme {
  // --- COLORS ---
  static const Color primary = Color(0xFFC15B20); // Rust (Cooked Earth)
  static const Color secondary = Color(0xFF3E5224); // Olive (Fresh)
  static const Color background = Color(0xFFFCFBF8); // Cream (Menu Paper)
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF2D3436); // Charcoal
  static const Color textLight = Color(0xFF636E72); // Grey

  // --- GRADIENTS ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE67E22), Color(0xFFC15B20)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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
  );

  // --- SHADOWS ---
  static List<BoxShadow> get shadowHero => [
    BoxShadow(
      color: secondary.withOpacity(0.1),
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
}
