import 'package:flutter/material.dart';

import '../theme/theme.dart';

class FbcChip extends StatelessWidget {
  final String label;
  final bool hasDot;
  final Color? dotColor;
  final Color? backgroundColor;
  final Color? textColor;

  const FbcChip({
    super.key,
    required this.label,
    this.hasDot = false,
    this.dotColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor ?? FbcColors.dark,
        borderRadius: FbcDecorations.borderRadiusSm,
        border: Border.all(
          color: FbcColors.border,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor ?? FbcColors.sky,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: FbcTypography.skillBadge.copyWith(
              color: textColor ?? FbcColors.sky,
            ),
          ),
        ],
      ),
    );
  }
}
