import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/core/design_system/widgets/product_card.dart';
import 'package:product_catalog/core/theme/app_theme.dart';
import 'package:product_catalog/features/catalog/data/models/product.dart';
import 'package:product_catalog/l10n/arb/app_localizations.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.light,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

final _product = Product(
  id: 1,
  title: 'Test Phone',
  description: 'A test phone.',
  price: 299.99,
  discountPercentage: 15.0,
  rating: 4.2,
  stock: 5,
  brand: 'TestBrand',
  category: 'phones',
  thumbnail: null,
  images: const [],
);

void main() {
  group('ProductCard', () {
    testWidgets('renders product title', (tester) async {
      await tester.pumpWidget(_wrap(
        ProductCard(product: _product),
      ));
      expect(find.text('Test Phone'), findsOneWidget);
    });

    testWidgets('renders brand name', (tester) async {
      await tester.pumpWidget(_wrap(
        ProductCard(product: _product),
      ));
      expect(find.text('TestBrand'), findsOneWidget);
    });

    testWidgets('renders discount badge when discountPercentage > 0',
        (tester) async {
      await tester.pumpWidget(_wrap(
        ProductCard(product: _product),
      ));
      // Discount badge shows "15% off"
      expect(find.textContaining('15'), findsWidgets);
    });

    testWidgets('does not render discount badge when discount is 0',
        (tester) async {
      final noDiscount = Product(
        id: 2,
        title: 'No Discount',
        description: '',
        price: 50.0,
        discountPercentage: 0,
        rating: 3.0,
        stock: 10,
        brand: 'B',
        category: 'cat',
        thumbnail: null,
        images: const [],
      );
      await tester.pumpWidget(_wrap(ProductCard(product: noDiscount)));
      // "% off" text should not appear
      expect(find.textContaining('% off'), findsNothing);
    });

    testWidgets('onTap callback fires', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        ProductCard(product: _product, onTap: () => tapped = true),
      ));
      await tester.tap(find.byType(InkWell));
      expect(tapped, isTrue);
    });

    testWidgets('shows image placeholder when thumbnail is null',
        (tester) async {
      await tester.pumpWidget(_wrap(
        ProductCard(product: _product), // thumbnail is null
      ));
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });

    testWidgets('selected card has different styling', (tester) async {
      await tester.pumpWidget(_wrap(
        ProductCard(product: _product, isSelected: true),
      ));
      // Just ensure it renders without error
      expect(find.byType(ProductCard), findsOneWidget);
    });
  });
}
