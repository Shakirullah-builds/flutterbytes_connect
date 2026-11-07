import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/fbc_chip.dart';

class HeroTelemetry extends StatelessWidget {
  final int totalBuilders;

  const HeroTelemetry({
    super.key,
    required this.totalBuilders,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        const SizedBox(height: 16),
        // Conference Pill Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: FbcColors.card,
            borderRadius: FbcDecorations.borderRadiusFull,
            border: Border.all(color: FbcColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bolt, size: 14, color: FbcColors.sky),
              const SizedBox(width: 6),
              Text(
                'FlutterBytes 2026 · AI Flutter Engineers',
                style: FbcTypography.caption.copyWith(
                  color: FbcColors.sky,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Hero Title
        Text(
          'Build With Anyone at FlutterBytes',
          textAlign: TextAlign.center,
          style: isMobile ? FbcTypography.h1 : FbcTypography.heroTitle,
        ),
        const SizedBox(height: 12),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            'Discover engineering peers, synthesize your AI developer persona, and auto-generate collaborative hackathon architectures deployed live on Serverpod Cloud.',
            textAlign: TextAlign.center,
            style: FbcTypography.bodyLarge.copyWith(color: FbcColors.muted),
          ),
        ),
        const SizedBox(height: 24),

        // Telemetry Chips
        Wrap(
          spacing: 10,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            const FbcChip(
              label: 'Serverpod Cloud 4.1',
              hasDot: true,
              dotColor: FbcColors.emerald,
            ),
            const FbcChip(
              label: 'Google Gemini 2.5 Flash',
              hasDot: true,
              dotColor: FbcColors.purple,
            ),
            const FbcChip(
              label: 'PostgreSQL Vector DB',
              hasDot: true,
              dotColor: FbcColors.blue,
            ),
            FbcChip(
              label: '$totalBuilders Profiles Indexed',
              hasDot: true,
              dotColor: FbcColors.sky,
            ),
          ],
        ),
      ],
    );
  }
}
