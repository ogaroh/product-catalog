import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/ds_exports.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/l10n.dart';
import '../blocs/category/category_cubit.dart';
import '../blocs/category/category_state.dart';

/// Horizontally scrollable row of [CategoryChip] widgets.
class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({super.key, required this.onCategorySelected});

  final void Function(String? category) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is! CategoryLoaded) return const SizedBox.shrink();

        final categories = state.categories;
        final selected = state.selectedCategory;

        return SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: categories.length + 1, // +1 for "All"
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              if (index == 0) {
                return CategoryChip(
                  label: context.l10n.allCategories,
                  isSelected: selected == null,
                  onTap: () => onCategorySelected(null),
                );
              }
              final cat = categories[index - 1];
              return CategoryChip(
                label: _capitalize(cat),
                isSelected: selected == cat,
                onTap: () => onCategorySelected(cat),
              );
            },
          ),
        );
      },
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
