import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/catalog/presentation/screens/product_catalog_shell.dart';
import '../features/catalog/presentation/screens/product_detail_screen.dart';
import '../features/catalog/presentation/screens/product_list_screen.dart';
import '../features/catalog/presentation/blocs/product_list/product_list_cubit.dart';
import '../features/showcase/presentation/screens/showcase_screen.dart';
import '../flavors.dart';
import 'route_names.dart';

/// Centralised [GoRouter] configuration.
final appRouter = GoRouter(
  initialLocation: RouteNames.catalog,
  routes: [
    // ── Main catalog shell (list + detail) ─────────────────
    ShellRoute(
      builder: (context, state, child) =>
          ProductCatalogShell(child: child),
      routes: [
        GoRoute(
          path: RouteNames.catalog,
          builder: (context, state) => ProductListScreen(
            onProductTap: (id) {
              final isTablet = MediaQuery.of(context).size.width >= 768;
              if (!isTablet) {
                context.push(RouteNames.productDetailPath(id));
              } else {
                // Tablet: handled inside the shell
                context
                    .read<ProductListCubit>()
                    .selectProduct(id);
              }
            },
          ),
          routes: [
            GoRoute(
              path: 'products/:id',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return ProductDetailScreen(productId: id);
              },
            ),
          ],
        ),
      ],
    ),

    // ── Dev-only showcase ───────────────────────────────────
    if (getFlavor() == Flavor.dev)
      GoRoute(
        path: RouteNames.showcase,
        builder: (context, state) => const ShowcaseScreen(),
      ),
  ],
);
