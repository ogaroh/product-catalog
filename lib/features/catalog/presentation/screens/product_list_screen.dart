import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/ds_exports.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../flavors.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routing/route_names.dart';
import '../blocs/category/category_cubit.dart';
import '../blocs/product_list/product_list_cubit.dart';
import '../blocs/product_list/product_list_state.dart';
import '../blocs/theme/theme_cubit.dart';
import '../blocs/theme/theme_state.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/product_list_view.dart';

/// Phone version of the product list (scroll + search + filter).
///
/// The tablet version is hosted inside [ProductCatalogShell].
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
    this.onProductTap,
    this.selectedProductId,
  });

  /// Called when the user taps a product card.
  /// Defaults to GoRouter push when null (phone), or master-detail select (tablet).
  final void Function(int id)? onProductTap;
  final int? selectedProductId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProductListCubit>();
    if (cubit.state is ProductListInitial) {
      cubit.loadProducts();
    }
    context.read<CategoryCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.productListTitle),
        actions: [
          // Showcase entry point — hidden in production
          if (getFlavor() != Flavor.prod)
            IconButton(
              icon: const Icon(CupertinoIcons.wand_stars),
              tooltip: context.l10n.showcaseTitle,
              onPressed: () => context.push(RouteNames.showcase),
            ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final icon = switch (themeState.themeMode) {
                ThemeMode.light => CupertinoIcons.sun_max,
                ThemeMode.dark => CupertinoIcons.moon_stars,
                ThemeMode.system => Icons.brightness_auto_outlined,
              };

              return IconButton(
                tooltip: "Change Application Theme",
                icon: Icon(icon),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: AppSearchBar(
              onChanged: (q) => context.read<ProductListCubit>().search(q),
              onClear: () => context.read<ProductListCubit>().loadProducts(),
            ),
          ),
          CategoryFilterBar(
            onCategorySelected: (cat) {
              context.read<CategoryCubit>().selectCategory(cat);
              context.read<ProductListCubit>().filterByCategory(cat);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ProductListView(
              onProductTap:
                  widget.onProductTap ?? (id) => _defaultNavigate(context, id),
              selectedProductId: widget.selectedProductId,
            ),
          ),
        ],
      ),
    );
  }

  void _defaultNavigate(BuildContext context, int id) {
    // When used standalone (phone), the shell/router handles push navigation.
    // This callback is replaced by the shell for tablet.
  }
}
