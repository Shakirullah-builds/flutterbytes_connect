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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: FbcColors.card.withValues(alpha: 0.85),
        borderRadius: FbcDecorations.borderRadiusFull,
        border: Border.all(color: FbcColors.border, width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FlutterBytes Logo
          Image.asset(
            FbcAssets.logoDark,
            height: 24,
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
          ),
          const SizedBox(width: 14),

          // Divider
          Container(
            height: 18,
            width: 1,
            color: FbcColors.border,
          ),
          const SizedBox(width: 14),

          // Live Radar Status Chip
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

          // CTA Action
          FbcButton(
            label: 'Claim Your Card',
            icon: Icons.person_add_alt_outlined,
            onPressed: onClaimCardPressed,
          ),
        ],
      ),
    );
  }
}
