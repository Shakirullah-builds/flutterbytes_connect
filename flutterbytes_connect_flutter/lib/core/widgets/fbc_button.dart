import 'package:flutter/material.dart';

import '../theme/theme.dart';

class FbcButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final double? width;

  const FbcButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, size: 16, color: isOutlined ? FbcColors.sky : Colors.white),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: FbcTypography.buttonText.copyWith(
              color: isOutlined ? FbcColors.sky : Colors.white,
            ),
          ),
        ],
      ],
    );

    if (isOutlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: FbcColors.border),
            shape: const RoundedRectangleBorder(
              borderRadius: FbcDecorations.borderRadiusFull,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          ),
          child: content,
        ),
      );
    }

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: FbcDecorations.borderRadiusFull,
        boxShadow: onPressed != null && !isLoading
            ? FbcDecorations.primaryButtonGlow
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: FbcColors.blue,
          disabledBackgroundColor: FbcColors.blue.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: FbcDecorations.borderRadiusFull,
          ),
          elevation: 0,
        ),
        child: content,
      ),
    );
  }
}
