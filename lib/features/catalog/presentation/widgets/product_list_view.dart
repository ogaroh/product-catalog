import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/design_system/ds_exports.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/l10n.dart';
import '../blocs/product_list/product_list_cubit.dart';
import '../blocs/product_list/product_list_state.dart';

/// The scrollable list body: shimmer, staggered cards, pagination spinner,
/// error/empty states and the cached-data banner.
class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
    required this.onProductTap,
    this.selectedProductId,
  });

  final void Function(int id) onProductTap;
  final int? selectedProductId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        if (state is ProductListLoading) {
          return const LoadingShimmer();
        }

        if (state is ProductListError) {
          return ErrorState(
            message: state.message,
            onRetry: () =>
                context.read<ProductListCubit>().loadProducts(),
          );
        }

        if (state is ProductListEmpty) {
          return EmptyState(
            message: context.l10n.noResults,
            subtitle: context.l10n.noResultsSubtitle,
          );
        }

        if (state is ProductListLoaded) {
          return _LoadedList(
            state: state,
            onProductTap: onProductTap,
            selectedProductId: selectedProductId,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _LoadedList extends StatelessWidget {
  const _LoadedList({
    required this.state,
    required this.onProductTap,
    this.selectedProductId,
  });

  final ProductListLoaded state;
  final void Function(int id) onProductTap;
  final int? selectedProductId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductListCubit>();

    return Column(
      children: [
        if (state.isFromCache) _CachedBanner(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: cubit.refresh,
            child: AnimationLimiter(
              child: ListView.separated(
                controller: cubit.scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                itemCount:
                    state.products.length + (state.isLoadingMore ? 1 : 0),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  if (index == state.products.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final product = state.products[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 32,
                      child: FadeInAnimation(
                        child: ProductCard(
                          product: product,
                          isSelected: product.id == selectedProductId,
                          onTap: () => onProductTap(product.id),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CachedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: isDark ? AppColors.cachedBannerBgDark : AppColors.cachedBannerBg,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 16,
            color: isDark
                ? AppColors.cachedBannerFgDark
                : AppColors.cachedBannerFg,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            context.l10n.cachedDataBanner,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.cachedBannerFgDark
                  : AppColors.cachedBannerFg,
            ),
          ),
        ],
      ),
    );
  }
}
