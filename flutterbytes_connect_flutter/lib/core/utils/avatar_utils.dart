import 'package:flutter/material.dart';

abstract final class AvatarUtils {
  /// Deterministic gradient generator based on an avatar seed or name hash
  static LinearGradient getGradient(int seed) {
    const gradients = [
      LinearGradient(
        colors: [Color(0xFF2A9DF4), Color(0xFF187BCD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFF38BDF8), Color(0xFF0284C7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFFA855F7), Color(0xFF7E22CE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF047857)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ];
    return gradients[seed.abs() % gradients.length];
  }

  /// Extracts 1-2 uppercase initials from a person's name
  static String getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'FB';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, parts.first.length.clamp(1, 2)).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  /// Constructs a GitHub avatar URL if a valid handle is provided
  static String? getGithubAvatarUrl(String? githubHandle) {
    if (githubHandle == null) return null;
    final clean = githubHandle.replaceAll('@', '').trim();
    if (clean.isEmpty) return null;
    return 'https://github.com/$clean.png?size=120';
  }
}
