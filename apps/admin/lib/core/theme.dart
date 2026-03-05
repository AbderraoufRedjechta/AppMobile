import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final adminTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF933D41), // Rouge Terre
    primary: const Color(0xFF933D41),
    secondary: const Color(0xFFE9B949), // Jaune Safran
    surface: Colors.white,
    background: const Color(0xFFF8F4E9), // Blanc Chaud
  ),
  scaffoldBackgroundColor: const Color(0xFFF8F4E9),
  textTheme: GoogleFonts.outfitTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: const Color(0xFF2D2D2D),
    elevation: 0,
    centerTitle: false,
    titleTextStyle: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF2D2D2D),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF2D2D2D)),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey.withOpacity(0.1)),
    ),
    margin: EdgeInsets.zero,
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.white,
    selectedIconTheme: const IconThemeData(color: Color(0xFF933D41)),
    unselectedIconTheme: const IconThemeData(color: Colors.grey),
    selectedLabelTextStyle: GoogleFonts.outfit(
      color: const Color(0xFF933D41),
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelTextStyle: GoogleFonts.outfit(color: Colors.grey),
  ),
);
