import 'package:flutter/material.dart';

/// Exact color palette extracted from the official FlutterBytes Conference 2026 website
/// (https://www.flutterbytesconf.com).
abstract final class FbcColors {
  // --- Core Palette ---
  /// Deep background navy (--color-navy: 5 14 31) -> #050E1F
  static const Color navy = Color(0xFF050E1F);

  /// Elevated dark container (--color-dark: 10 22 40) -> #0A1628
  static const Color dark = Color(0xFF0A1628);

  /// Card surface (--color-card: 15 30 56) -> #0F1E38
  static const Color card = Color(0xFF0F1E38);

  /// Elevated card hover surface -> #142544
  static const Color cardElevated = Color(0xFF142544);

  /// Border and divider (--color-border: 30 58 95) -> #1E3A5F
  static const Color border = Color(0xFF1E3A5F);

  /// Subtle border highlight -> #2A4E7E
  static const Color borderLight = Color(0xFF2A4E7E);

  /// Primary Brand Blue (--color-blue: 42 157 244) -> #2A9DF4
  static const Color blue = Color(0xFF2A9DF4);

  /// Brand Glow Blue (--color-glow: 24 123 205) -> #187BCD
  static const Color glow = Color(0xFF187BCD);

  /// Sky Cyan accent (--color-sky: 56 189 248) -> #38BDF8
  static const Color sky = Color(0xFF38BDF8);

  /// Muted Slate text (--color-muted: 148 163 184) -> #94A3B8
  static const Color muted = Color(0xFF94A3B8);

  /// High-contrast Pure White text (--color-white: 248 250 255) -> #F8FAFF
  static const Color white = Color(0xFFF8FAFF);

  // --- Semantic & Accent Colors ---
  /// Live streaming status indicator
  static const Color emerald = Color(0xFF10B981);

  /// AI Persona accent
  static const Color purple = Color(0xFFA855F7);

  /// Matchmaker synergy orange/amber
  static const Color amber = Color(0xFFF59E0B);

  // --- Brand Gradients ---
  static const LinearGradient brandGradient = LinearGradient(
    colors: [blue, sky],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF2A9DF4), Color(0xFFA855F7)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0F1E38), Color(0xFF0A1628)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
