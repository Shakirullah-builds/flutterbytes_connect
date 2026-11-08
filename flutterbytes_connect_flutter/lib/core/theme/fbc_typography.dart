import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fbc_colors.dart';

/// Typography definitions matching the official FlutterBytes Conference 2026 website:
/// - Headings: Space Grotesk
/// - Body & UI: Inter
/// - Tags & Code: JetBrains Mono
abstract final class FbcTypography {
  // --- Headings (Space Grotesk) ---
  static TextStyle get heroTitle => GoogleFonts.spaceGrotesk(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        color: FbcColors.white,
        letterSpacing: -1.0,
        height: 1.15,
      );

  static TextStyle get h1 => GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: FbcColors.white,
        letterSpacing: -0.5,
      );

  static TextStyle get h2 => GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: FbcColors.white,
        letterSpacing: -0.3,
      );

  static TextStyle get h3 => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: FbcColors.white,
      );

  // --- Body (Inter) ---
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: FbcColors.white,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: FbcColors.white,
        height: 1.45,
      );

  static TextStyle get bodyMuted => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: FbcColors.muted,
        height: 1.4,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: FbcColors.muted,
      );

  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.2,
      );

  // --- Tags, Code & Badges (JetBrains Mono) ---
  static TextStyle get code => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: FbcColors.sky,
      );

  static TextStyle get skillBadge => GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: FbcColors.sky,
        letterSpacing: 0.3,
      );

  static TextStyle get personaTitle => GoogleFonts.spaceGrotesk(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: FbcColors.sky,
        letterSpacing: -0.2,
      );
}
