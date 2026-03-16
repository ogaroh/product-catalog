import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Skeleton loading placeholder — shown while the first page is loading.
class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key, this.itemCount = 6});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor:
          isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBaseLight,
      highlightColor: isDark
          ? AppColors.shimmerHighlightDark
          : AppColors.shimmerHighlightLight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        itemBuilder: (_, __) => const _ShimmerCard(),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      child: Row(
        children: [
          // Thumbnail placeholder
          Container(
            width: AppSpacing.thumbnailSmall,
            height: AppSpacing.thumbnailSmall,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Text placeholders
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 14, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 12, width: 120, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 12, width: 80, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
