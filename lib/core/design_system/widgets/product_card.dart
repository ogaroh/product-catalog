import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../../features/catalog/data/models/product.dart';
import '../../../l10n/l10n.dart';
import 'price_widget.dart';
import 'rating_widget.dart';

/// Card displaying product thumbnail, title, price, rating and discount badge.
///
/// Wrap in an [AnimationConfiguration] for staggered list animations.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.isSelected = false,
    this.heroTagPrefix = 'list',
  });

  final Product product;
  final VoidCallback? onTap;

  /// Highlights the card when selected in tablet master-detail layout.
  final bool isSelected;

  /// Prefix used for the Hero tag so list and detail panel heroes never
  /// share the same tag while both are visible on a tablet (same route).
  ///
  /// Defaults to `'list'`. Pass `'detail'` in the detail panel.
  final String heroTagPrefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: isSelected
          ? (isDark
              ? AppColors.primaryDark.withValues(alpha: 0.15)
              : AppColors.primary.withValues(alpha: 0.08))
          : null,
      shape: isSelected
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              side: BorderSide(
                color: isDark ? AppColors.primaryDark : AppColors.primary,
                width: 1.5,
              ),
            )
          : null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(product: product, heroTagPrefix: heroTagPrefix),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _Info(product: product)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.product, required this.heroTagPrefix});
  final Product product;
  final String heroTagPrefix;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$heroTagPrefix-hero-${product.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: SizedBox(
          width: AppSpacing.thumbnailSmall,
          height: AppSpacing.thumbnailSmall,
          child: product.thumbnail != null
              ? CachedNetworkImage(
                  imageUrl: product.thumbnail!,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _PlaceholderBox(),
                  errorWidget: (_, __, ___) => _PlaceholderBox(),
                )
              : _PlaceholderBox(),
        ),
      ),
    );
  }
}

class _PlaceholderBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Icon(Icons.image_outlined, size: 32, color: Colors.grey),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          product.title,
          style: AppTextStyles.productTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs),
        // Brand
        Text(
          product.brand,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.sm),
        // Price + discount badge row
        Row(
          children: [
            Expanded(
              child: PriceWidget(
                price: product.price,
                discountPercentage: product.discountPercentage,
              ),
            ),
            if (product.discountPercentage > 0)
              _DiscountBadge(
                percent: product.discountPercentage,
                l10nPercent: product.discountPercentage
                    .toStringAsFixed(0),
                l10n: l10n,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        // Rating
        RatingWidget(rating: product.rating),
      ],
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({
    required this.percent,
    required this.l10nPercent,
    required this.l10n,
  });

  final double percent;
  final String l10nPercent;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs + 1,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.discountGradientStart,
            AppColors.discountGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Text(
        context.l10n.discountLabel(l10nPercent),
        style: AppTextStyles.discountBadge,
      ),
    );
  }
}
