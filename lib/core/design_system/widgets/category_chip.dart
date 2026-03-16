import 'package:flutter/material.dart';

/// A selectable filter chip for category filtering.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      labelStyle: Theme.of(context).chipTheme.labelStyle?.copyWith(
            color: isSelected
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}
