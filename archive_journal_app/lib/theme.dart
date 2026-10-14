import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const cream = Color(0xFFFFF8E7);
  static const sidebar = Color(0xFFEFE0B0);
  static const brown = Color(0xFF8B5A3C);
  static const darkBrown = Color(0xFF4A2511);
  static const peach = Color(0xFFFBD9C8);
  static const ink = Color(0xFF1E1B13);
  static const inkSoft = Color(0xFF3F3A2E);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brown),
    scaffoldBackgroundColor: AppColors.cream,
  );
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme(base.textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cream,
      foregroundColor: AppColors.darkBrown,
      elevation: 0,
    ),
  );
}

// Big italic headings (greeting).
TextStyle displayStyle(double size) => GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic,
      letterSpacing: -1,
      color: AppColors.ink,
    );

TextStyle get titleStyle => GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    );

// Italic serif for note excerpts.
TextStyle get bodyStyle => GoogleFonts.newsreader(
      fontSize: 16,
      fontStyle: FontStyle.italic,
      height: 1.6,
      color: AppColors.inkSoft,
    );

TextStyle get labelStyle => GoogleFonts.inter(
      fontSize: 12,
      letterSpacing: 1.2,
      color: AppColors.darkBrown,
    );
