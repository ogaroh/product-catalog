import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n.dart';

enum RatingDisplayMode { stars, numeric }

/// Displays a product rating as icons or a numeric label.
class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
    this.mode = RatingDisplayMode.stars,
    this.size = 16.0,
    this.color,
  });

  final double rating;
  final RatingDisplayMode mode;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final clampedRating = rating.clamp(0.0, 5.0);
    final effectiveColor = color ?? AppColors.rating;

    if (mode == RatingDisplayMode.numeric) {
      return Semantics(
        label: context.l10n.ratingLabel(clampedRating.toStringAsFixed(1)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, size: size, color: effectiveColor),
            const SizedBox(width: 2),
            Text(
              clampedRating.toStringAsFixed(1),
              style: AppTextStyles.labelMedium.copyWith(color: effectiveColor),
            ),
          ],
        ),
      );
    }

    // Stars mode
    return Semantics(
      label: context.l10n.ratingLabel(clampedRating.toStringAsFixed(1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final filled = clampedRating - index;
          final IconData icon;
          if (filled >= 1) {
            icon = Icons.star_rounded;
          } else if (filled >= 0.5) {
            icon = Icons.star_half_rounded;
          } else {
            icon = Icons.star_outline_rounded;
          }
          return Icon(icon, size: size, color: effectiveColor);
        }),
      ),
    );
  }
}
