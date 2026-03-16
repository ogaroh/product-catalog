import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n.dart';

/// Displays a product price, with optional strikethrough when discounted.
class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    this.discountPercentage,
    this.priceStyle,
  });

  final double? price;
  final double? discountPercentage;
  final TextStyle? priceStyle;

  @override
  Widget build(BuildContext context) {
    if (price == null || price! <= 0) {
      return Text(
        context.l10n.priceUnavailable,
        style: (priceStyle ?? AppTextStyles.productPrice).copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    final hasDiscount =
        discountPercentage != null && discountPercentage! > 0;
    final discounted = hasDiscount
        ? price! * (1 - discountPercentage! / 100)
        : null;

    final accentColor = Theme.of(context).colorScheme.primary;
    final effectivePriceStyle = priceStyle ?? AppTextStyles.productPrice;

    if (!hasDiscount) {
      return Text(
        '\$${price!.toStringAsFixed(2)}',
        style: effectivePriceStyle,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\$${discounted!.toStringAsFixed(2)}',
          style: effectivePriceStyle.copyWith(color: accentColor),
        ),
        const SizedBox(width: 6),
        Text(
          '\$${price!.toStringAsFixed(2)}',
          style: AppTextStyles.productPriceStrikethrough.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
