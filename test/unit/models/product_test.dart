import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/features/catalog/data/models/product.dart';

void main() {
  group('Product.validated', () {
    test('parses a valid product correctly', () {
      final json = _validJson();
      final product = Product.validated(json);

      expect(product.id, 1);
      expect(product.title, 'iPhone 15 Pro');
      expect(product.price, 999.99);
      expect(product.discountPercentage, 10.0);
      expect(product.rating, 4.5);
      expect(product.stock, 50);
      expect(product.brand, 'Apple');
      expect(product.category, 'smartphones');
      expect(product.thumbnail, 'https://example.com/thumb.jpg');
      expect(product.images, ['https://example.com/img1.jpg']);
    });

    test('null brand falls back to "Unknown Brand"', () {
      final json = _validJson()..['brand'] = null;
      final product = Product.validated(json);
      expect(product.brand, 'Unknown Brand');
    });

    test('empty brand falls back to "Unknown Brand"', () {
      final json = _validJson()..['brand'] = '';
      final product = Product.validated(json);
      expect(product.brand, 'Unknown Brand');
    });

    test('negative price results in null price', () {
      final json = _validJson()..['price'] = -1;
      final product = Product.validated(json);
      expect(product.price, isNull);
    });

    test('zero price results in null price', () {
      final json = _validJson()..['price'] = 0;
      final product = Product.validated(json);
      expect(product.price, isNull);
    });

    test('missing price results in null price', () {
      final json = _validJson()..remove('price');
      final product = Product.validated(json);
      expect(product.price, isNull);
    });

    test('invalid thumbnail URL results in null thumbnail', () {
      final json = _validJson()..['thumbnail'] = 'not-a-url';
      final product = Product.validated(json);
      expect(product.thumbnail, isNull);
    });

    test('empty thumbnail string results in null thumbnail', () {
      final json = _validJson()..['thumbnail'] = '';
      final product = Product.validated(json);
      expect(product.thumbnail, isNull);
    });

    test('empty images list falls back to thumbnail', () {
      final json = _validJson()..['images'] = <String>[];
      final product = Product.validated(json);
      expect(product.images, ['https://example.com/thumb.jpg']);
    });

    test('images with invalid URLs are filtered out', () {
      final json = _validJson()
        ..['images'] = ['https://valid.com/img.jpg', 'not-valid', ''];
      final product = Product.validated(json);
      expect(product.images, ['https://valid.com/img.jpg']);
    });

    test('missing category falls back to "Uncategorized"', () {
      final json = _validJson()..remove('category');
      final product = Product.validated(json);
      expect(product.category, 'Uncategorized');
    });

    test('discountPercentage is clamped to [0, 100]', () {
      final json = _validJson()..['discountPercentage'] = 150.0;
      final product = Product.validated(json);
      expect(product.discountPercentage, 100.0);
    });

    test('rating is clamped to [0, 5]', () {
      final json = _validJson()..['rating'] = 6.0;
      final product = Product.validated(json);
      expect(product.rating, 5.0);
    });

    test('negative stock is normalised to 0', () {
      final json = _validJson()..['stock'] = -5;
      final product = Product.validated(json);
      expect(product.stock, 0);
    });

    test('discountedPrice calculates correctly', () {
      final json = _validJson();
      // price=999.99, discount=10%
      final product = Product.validated(json);
      expect(product.discountedPrice, closeTo(899.99, 0.01));
    });

    test('discountedPrice is null when price is unavailable', () {
      final json = _validJson()..['price'] = null;
      final product = Product.validated(json);
      expect(product.discountedPrice, isNull);
    });
  });
}

Map<String, dynamic> _validJson() => {
      'id': 1,
      'title': 'iPhone 15 Pro',
      'description': 'A great phone.',
      'price': 999.99,
      'discountPercentage': 10.0,
      'rating': 4.5,
      'stock': 50,
      'brand': 'Apple',
      'category': 'smartphones',
      'thumbnail': 'https://example.com/thumb.jpg',
      'images': ['https://example.com/img1.jpg'],
    };
