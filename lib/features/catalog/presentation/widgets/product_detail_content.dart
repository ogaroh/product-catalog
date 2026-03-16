import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/ds_exports.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/l10n.dart';
import '../blocs/product_detail/product_detail_cubit.dart';
import '../blocs/product_detail/product_detail_state.dart';
import '../widgets/image_gallery.dart';

/// Shared product detail body used by both the push screen and tablet panel.
class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductDetailError) {
          return ErrorState(
            message: state.message,
            onRetry: () =>
                context.read<ProductDetailCubit>().loadProduct(productId),
          );
        }

        if (state is ProductDetailLoaded) {
          final product = state.product;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageGallery(
                  images: product.images,
                  heroTag: 'detail-hero-${product.id}',
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category chip
                      Chip(
                        label: Text(product.category),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Title
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      // Brand
                      Text(
                        context.l10n.brandLabel(product.brand),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Price
                      PriceWidget(
                        price: product.price,
                        discountPercentage: product.discountPercentage,
                        priceStyle: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Rating row
                      Row(
                        children: [
                          RatingWidget(
                            rating: product.rating,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Stock
                      Text(
                        context.l10n.stockLabel(product.stock),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: product.stock > 0
                                  ? null
                                  : Theme.of(context).colorScheme.error,
                            ),
                      ),
                      const Divider(height: AppSpacing.xxl),
                      // Description
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
