import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TColors {
  TColors._();

  static const primary = Color(0xFFE8500A); // Orange principal
  static const primaryDark = Color(0xFFC44008); // Orange foncé
  static const bg = Color(0xFF08102C); // Fond sombre bleu
  static const surface = Color(0xFF1A2B40); // Surfaces cartes
  static const border = Color(0xFF2A3F58); // Bordures
  static const text = Color(0xFFFFFFFF); // Texte principal
  static const textMuted = Color(0xFF8A9BB0); // Texte secondaire
  static const textLight = Color(0xFF5A7080); // Texte léger
  static const success = Color(0xFF16A34A); // Vert succès
  static const successLight = Color(0xFF0D2B1A); // Vert clair sombre
  static const warning = Color(0xFFD97706); // Ambre retard
  static const warningLight = Color(0xFF2B1F0A); // Ambre clair sombre
  static const danger = Color(0xFFDC2626); // Rouge fraude
  static const dangerLight = Color(0xFF2B0A0A); // Rouge clair sombre
  static const card = Color(0xFF1A2B40); // Fond cartes
}

class TText {
  TText._();

  static TextStyle get h1 => GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: TColors.text,
      );
  static TextStyle get h2 => GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: TColors.text,
      );
  static TextStyle get h3 => GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: TColors.text,
      );
  static TextStyle get body => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: TColors.text,
      );
  static TextStyle get bodyMuted => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: TColors.textMuted,
      );
  static TextStyle get caption => GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: TColors.textLight,
      );
  static TextStyle get button => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );
  static TextStyle get label => GoogleFonts.spaceGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: TColors.text,
      );
}

class TTheme {
  TTheme._();

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: TColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: TColors.primary,
          secondary: TColors.success,
          error: TColors.danger,
          surface: TColors.surface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: TColors.bg,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: TColors.text,
          ),
          iconTheme: const IconThemeData(color: TColors.text),
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
            textStyle: GoogleFonts.spaceGrotesk(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: TColors.primary,
            side: const BorderSide(color: TColors.primary, width: 1.5),
            minimumSize: const Size(double.infinity, 56),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle: GoogleFonts.spaceGrotesk(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: TColors.surface,
          hintStyle:
              GoogleFonts.spaceGrotesk(fontSize: 14, color: TColors.textLight),
          labelStyle:
              GoogleFonts.spaceGrotesk(fontSize: 14, color: TColors.textMuted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: TColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: TColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: TColors.primary, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        cardTheme: CardThemeData(
          color: TColors.card,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: TColors.border, width: 0.5),
          ),
          margin: EdgeInsets.zero,
        ),
        dividerColor: TColors.border,
      );
}
