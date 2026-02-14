import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final adminTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFE65100), // Deep Terracotta
    primary: const Color(0xFFE65100),
    secondary: const Color(0xFF2D3436), // Charcoal
    surface: Colors.white,
    background: const Color(0xFFF5F5F5), // Light Grey for Dashboard bg
  ),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  textTheme: GoogleFonts.outfitTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: const Color(0xFF2D3436),
    elevation: 0,
    centerTitle: false,
    titleTextStyle: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF2D3436),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF2D3436)),
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
    selectedIconTheme: const IconThemeData(color: Color(0xFFE65100)),
    unselectedIconTheme: const IconThemeData(color: Colors.grey),
    selectedLabelTextStyle: GoogleFonts.outfit(
      color: const Color(0xFFE65100),
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelTextStyle: GoogleFonts.outfit(color: Colors.grey),
  ),
);
