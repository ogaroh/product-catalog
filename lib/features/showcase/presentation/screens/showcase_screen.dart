import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/ds_exports.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/catalog/data/models/product.dart';
import '../../../../features/catalog/presentation/blocs/theme/theme_cubit.dart';
import '../../../../features/catalog/presentation/blocs/theme/theme_state.dart';
import '../../../../l10n/l10n.dart';

/// Developer-only component showcase screen.
/// Accessible at /showcase (dev flavor only).
class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.showcaseTitle),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final icon = switch (state.themeMode) {
                ThemeMode.light => Icons.dark_mode_outlined,
                ThemeMode.dark => Icons.light_mode_outlined,
                ThemeMode.system => Icons.brightness_auto_outlined,
              };
              return IconButton(
                icon: Icon(icon),
                tooltip: 'Toggle theme',
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _Section(title: 'ProductCard', children: [
            // Each card must have a unique heroTagPrefix to avoid same-route
            // Hero tag collisions when multiple cards are visible at once.
            ProductCard(
              product: _sampleProduct,
              heroTagPrefix: 'showcase-1',
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            ProductCard(
              product: _sampleProduct,
              heroTagPrefix: 'showcase-2',
              isSelected: true,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            ProductCard(
              product: _noImageProduct,
              heroTagPrefix: 'showcase-3',
              onTap: () {},
            ),
          ]),
          _Section(title: 'PriceWidget', children: [
            PriceWidget(price: 49.99),
            const SizedBox(height: AppSpacing.sm),
            const PriceWidget(price: 99.99, discountPercentage: 20),
            const SizedBox(height: AppSpacing.sm),
            const PriceWidget(price: null),
          ]),
          _Section(title: 'RatingWidget (Stars)', children: [
            RatingWidget(rating: 5),
            const SizedBox(height: AppSpacing.sm),
            const RatingWidget(rating: 3.5),
            const SizedBox(height: AppSpacing.sm),
            const RatingWidget(rating: 0),
          ]),
          _Section(title: 'RatingWidget (Numeric)', children: [
            const RatingWidget(rating: 4.2, mode: RatingDisplayMode.numeric),
          ]),
          _Section(title: 'AppSearchBar', children: [
            AppSearchBar(onChanged: (_) {}),
          ]),
          _Section(title: 'CategoryChip', children: [
            Wrap(spacing: 8, children: [
              CategoryChip(
                  label: 'All', isSelected: true, onTap: () {}),
              CategoryChip(
                  label: 'Electronics', isSelected: false, onTap: () {}),
              CategoryChip(
                  label: 'Clothing', isSelected: false, onTap: () {}),
            ]),
          ]),
          _Section(title: 'EmptyState', children: [
            SizedBox(
              height: 280,
              child: EmptyState(
                message: context.l10n.noResults,
                subtitle: context.l10n.noResultsSubtitle,
              ),
            ),
          ]),
          _Section(title: 'ErrorState', children: [
            SizedBox(
              height: 280,
              child: ErrorState(
                message: 'Something went wrong',
                onRetry: () {},
              ),
            ),
          ]),
          _Section(title: 'LoadingShimmer', children: [
            SizedBox(height: 400, child: LoadingShimmer(itemCount: 3)),
          ]),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          ...children,
        ],
      ),
    );
  }
}

// ── Mock data ────────────────────────────────────────────────

final _sampleProduct = Product(
  id: 1,
  title: 'iPhone 15 Pro Max',
  description: 'The latest iPhone with a titanium frame.',
  price: 1299.99,
  discountPercentage: 10,
  rating: 4.7,
  stock: 24,
  brand: 'Apple',
  category: 'smartphones',
  thumbnail: null,
  images: const [],
);

final _noImageProduct = Product(
  id: 2,
  title: 'Mystery Product',
  description: 'No image available.',
  price: null,
  discountPercentage: 0,
  rating: 0,
  stock: 0,
  brand: 'Unknown Brand',
  category: 'Uncategorized',
  thumbnail: null,
  images: const [],
);
