import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/repository/products_repository.dart';
import '../../../../l10n/l10n.dart';
import '../blocs/category/category_cubit.dart';
import '../blocs/product_detail/product_detail_cubit.dart';
import '../blocs/product_list/product_list_cubit.dart';
import '../blocs/product_list/product_list_state.dart';
import '../widgets/product_detail_content.dart';
import 'product_list_screen.dart';

/// Root shell widget.
///
/// At ≥ 768px: side-by-side master-detail layout.
/// At < 768px: renders [child] from GoRouter's ShellRoute (push navigation).
class ProductCatalogShell extends StatelessWidget {
  const ProductCatalogShell({super.key, required this.child});

  /// The current child route provided by GoRouter (phone navigation).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ProductsRepository>();
    final isTablet =
        MediaQuery.of(context).size.width >= AppSpacing.tabletBreakpoint;

    // Provide cubits at the shell level so both panels share them.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductListCubit(repository: repository),
        ),
        BlocProvider(
          create: (_) => CategoryCubit(repository: repository),
        ),
      ],
      child: isTablet
          ? _TabletLayout(repository: repository)
          : child,
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout({required this.repository});
  final ProductsRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      buildWhen: (prev, curr) {
        // Only rebuild when the selection changes
        final prevId = prev is ProductListLoaded ? prev.selectedProductId : null;
        final currId = curr is ProductListLoaded ? curr.selectedProductId : null;
        return prevId != currId;
      },
      builder: (context, state) {
        final selectedId =
            state is ProductListLoaded ? state.selectedProductId : null;

        return Row(
          children: [
            // ── Left panel: list ───────────────────────────────
            SizedBox(
              width: AppSpacing.listPanelWidth,
              child: ProductListScreen(
                onProductTap: (id) {
                  context.read<ProductListCubit>().selectProduct(id);
                },
                selectedProductId: selectedId,
              ),
            ),
            const VerticalDivider(width: 1),
            // ── Right panel: detail ────────────────────────────
            Expanded(
              child: selectedId != null
                  ? BlocProvider(
                      key: ValueKey(selectedId),
                      create: (_) => ProductDetailCubit(
                        repository: repository,
                      )..loadProduct(selectedId),
                      child: ProductDetailContent(productId: selectedId),
                    )
                  : Center(
                      child: Text(
                        context.l10n.noProductSelected,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
