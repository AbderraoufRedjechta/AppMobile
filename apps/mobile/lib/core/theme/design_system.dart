import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GustoDesign {
  // --- COLORS (Authentic & Premium) ---
  static const Color primary = Color(0xFFC15B20); // Rust/Clay (Cooked Food)
  static const Color secondary = Color(0xFF3E5224); // Olive Green (Freshness)
  static const Color background = Color(0xFFFCFBF8); // Warm Paper (Menu)
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF2D3436); // Charcoal (Readable)
  static const Color textLight = Color(0xFF636E72); // Grey text

  // --- GRADIENTS ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE67E22), Color(0xFFC15B20)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient oliveGradient = LinearGradient(
    colors: [Color(0xFF556B2F), Color(0xFF3E5224)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- SHADOWS (Soft & Heavy) ---
  static List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: const Color(0xFF3E5224).withOpacity(0.08),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  // --- BORDER RADIUS (Squircle) ---
  static BorderRadius radiusSmall = BorderRadius.circular(12);
  static BorderRadius radiusMedium = BorderRadius.circular(20);
  static BorderRadius radiusLarge = BorderRadius.circular(32);

  // --- SPACING ---
  static const double paddingS = 12.0;
  static const double paddingM = 20.0;
  static const double paddingL = 32.0;

  // --- TYPOGRAPHY (Outfit) ---
  static TextTheme textTheme = GoogleFonts.outfitTextTheme().copyWith(
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
      letterSpacing: -0.5,
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
}
