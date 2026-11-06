import 'package:flutter/material.dart';

import 'fbc_colors.dart';
import 'fbc_decorations.dart';
import 'fbc_typography.dart';

/// Complete ThemeData for the FlutterBytes Connect application.
abstract final class FbcTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: FbcColors.navy,
      canvasColor: FbcColors.navy,
      cardColor: FbcColors.card,
      dividerColor: FbcColors.border,

      colorScheme: const ColorScheme.dark(
        primary: FbcColors.blue,
        onPrimary: Colors.white,
        secondary: FbcColors.sky,
        onSecondary: FbcColors.navy,
        surface: FbcColors.card,
        onSurface: FbcColors.white,
        error: Colors.redAccent,
        onError: Colors.white,
      ),

      textTheme: TextTheme(
        headlineLarge: FbcTypography.heroTitle,
        headlineMedium: FbcTypography.h1,
        titleLarge: FbcTypography.h2,
        titleMedium: FbcTypography.h3,
        bodyLarge: FbcTypography.bodyLarge,
        bodyMedium: FbcTypography.bodyMedium,
        bodySmall: FbcTypography.bodyMuted,
        labelLarge: FbcTypography.buttonText,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: FbcColors.navy.withValues(alpha: 0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: FbcTypography.h2,
        iconTheme: const IconThemeData(color: FbcColors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FbcColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: FbcDecorations.borderRadiusFull,
          ),
          textStyle: FbcTypography.buttonText,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: FbcColors.sky,
          side: const BorderSide(color: FbcColors.border, width: 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: const RoundedRectangleBorder(
            borderRadius: FbcDecorations.borderRadiusFull,
          ),
          textStyle: FbcTypography.buttonText.copyWith(color: FbcColors.sky),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: FbcColors.dark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: FbcTypography.bodyMuted,
        labelStyle: FbcTypography.bodyMedium.copyWith(color: FbcColors.sky),
        border: OutlineInputBorder(
          borderRadius: FbcDecorations.borderRadiusMd,
          borderSide: const BorderSide(color: FbcColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: FbcDecorations.borderRadiusMd,
          borderSide: const BorderSide(color: FbcColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: FbcDecorations.borderRadiusMd,
          borderSide: const BorderSide(color: FbcColors.sky, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: FbcDecorations.borderRadiusMd,
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: FbcColors.dark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: FbcDecorations.borderRadiusLg,
          side: const BorderSide(color: FbcColors.border),
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: FbcColors.dark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          side: BorderSide(color: FbcColors.border),
        ),
      ),
    );
  }
}
