import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/fbc_button.dart';
import '../../../../core/widgets/radar_indicator.dart';

class FloatingNavbar extends StatelessWidget {
  final int onlineCount;
  final VoidCallback onClaimCardPressed;

  const FloatingNavbar({
    super.key,
    required this.onlineCount,
    required this.onClaimCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 560;
        final isVerySmall = constraints.maxWidth < 380;

        Widget logoWidget = Image.asset(
          FbcAssets.logoDark,
          height: isMobile ? 22 : 24,
          errorBuilder: (context, error, stackTrace) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.hub_outlined, color: FbcColors.blue, size: 20),
              const SizedBox(width: 8),
              Text(
                'FlutterBytes',
                style: FbcTypography.h3.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );

        if (isMobile) {
          // Mobile Layout: Full-width responsive frosted glass bar
          return ClipRRect(
            borderRadius: FbcDecorations.borderRadiusFull,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: FbcColors.card.withValues(alpha: 0.85),
                  borderRadius: FbcDecorations.borderRadiusFull,
                  border: Border.all(
                    color: FbcColors.border.withValues(alpha: 0.8),
                    width: 1.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo & Status Dot
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: logoWidget),
                          const SizedBox(width: 8),
                          const RadarIndicator(size: 6),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Claim Action
                    FbcButton(
                      label: isVerySmall ? 'Claim' : 'Claim Card',
                      icon: Icons.person_add_alt_outlined,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      fontSize: 12,
                      onPressed: onClaimCardPressed,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Desktop / Tablet Layout: Centered floating pill with frosted glass
        return ClipRRect(
          borderRadius: FbcDecorations.borderRadiusFull,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: FbcColors.card.withValues(alpha: 0.82),
                borderRadius: FbcDecorations.borderRadiusFull,
                border: Border.all(
                  color: FbcColors.border.withValues(alpha: 0.8),
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x44000000),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  logoWidget,
                  const SizedBox(width: 14),

                  // Vertical Divider
                  Container(
                    height: 18,
                    width: 1,
                    color: FbcColors.border,
                  ),
                  const SizedBox(width: 14),

                  // Telemetry Counter
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RadarIndicator(size: 7),
                      const SizedBox(width: 8),
                      Text(
                        '$onlineCount Builders Connected',
                        style: FbcTypography.caption.copyWith(
                          color: FbcColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 18),

                  // Claim Button
                  FbcButton(
                    label: 'Claim Your Card',
                    icon: Icons.person_add_alt_outlined,
                    onPressed: onClaimCardPressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
