import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class SkillFilterBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onSearchChanged;

  const SkillFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSearchChanged,
  });

  static const List<String> filters = [
    'All',
    'Flutter',
    'Serverpod',
    'Riverpod',
    'Dart',
    'AI',
    'UI/UX',
    'Backend',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Input
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: TextField(
            onChanged: onSearchChanged,
            style: FbcTypography.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Search by engineer name, skills (e.g. Riverpod, Serverpod), or role...',
              prefixIcon: const Icon(Icons.search, size: 20, color: FbcColors.muted),
              filled: true,
              fillColor: FbcColors.dark,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Filter Chips Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: filters.map((f) {
              final isSelected = f == selectedFilter;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () => onFilterChanged(f),
                  borderRadius: FbcDecorations.borderRadiusFull,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: isSelected ? FbcColors.blue : FbcColors.card,
                      borderRadius: FbcDecorations.borderRadiusFull,
                      border: Border.all(
                        color: isSelected ? FbcColors.sky : FbcColors.border,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      f,
                      style: FbcTypography.caption.copyWith(
                        color: isSelected ? Colors.white : FbcColors.muted,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
