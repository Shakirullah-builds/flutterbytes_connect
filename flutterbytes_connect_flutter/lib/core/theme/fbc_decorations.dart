import 'package:flutter/material.dart';

import 'fbc_colors.dart';

/// Design tokens for borders, shadows, border-radii, and frosted card containers.
abstract final class FbcDecorations {
  // --- Border Radii ---
  static const double radiusSm = 8.0;
  static const double radiusMd = 14.0;
  static const double radiusLg = 20.0;
  static const double radiusFull = 9999.0;

  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusFull = BorderRadius.all(Radius.circular(radiusFull));

  // --- Glow Shadows (Extracted from website shadow tokens) ---
  /// Primary blue neon button glow
  static const List<BoxShadow> primaryButtonGlow = [
    BoxShadow(
      color: Color(0x662A9DF4),
      blurRadius: 20,
      spreadRadius: 0,
      offset: Offset(0, 0),
    ),
  ];

  /// Hover glow for cards and active items
  static const List<BoxShadow> cardHoverGlow = [
    BoxShadow(
      color: Color(0x332A9DF4),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  /// AI Persona card glow
  static const List<BoxShadow> personaGlow = [
    BoxShadow(
      color: Color(0x3338BDF8),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  // --- Container Decorations ---
  /// Standard Attendee Card Decoration
  static BoxDecoration cardDecoration({bool isHovered = false, Color? borderColor}) {
    return BoxDecoration(
      color: isHovered ? FbcColors.cardElevated : FbcColors.card,
      borderRadius: borderRadiusLg,
      border: Border.all(
        color: borderColor ?? (isHovered ? FbcColors.sky : FbcColors.border),
        width: 1.0,
      ),
      boxShadow: isHovered ? cardHoverGlow : null,
    );
  }

  /// Skill chip decoration
  static BoxDecoration skillChipDecoration = BoxDecoration(
    color: FbcColors.dark,
    borderRadius: borderRadiusSm,
    border: Border.all(
      color: FbcColors.border,
      width: 1.0,
    ),
  );

  /// Top pill navbar container decoration
  static BoxDecoration pillNavDecoration = BoxDecoration(
    color: FbcColors.card.withValues(alpha: 0.75),
    borderRadius: borderRadiusFull,
    border: Border.all(
      color: FbcColors.border,
      width: 1.0,
    ),
  );
}
