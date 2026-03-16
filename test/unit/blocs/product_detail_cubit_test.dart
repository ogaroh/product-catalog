import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/features/catalog/data/models/product.dart';
import 'package:product_catalog/features/catalog/data/repository/products_repository.dart';
import 'package:product_catalog/features/catalog/presentation/blocs/product_detail/product_detail_cubit.dart';
import 'package:product_catalog/features/catalog/presentation/blocs/product_detail/product_detail_state.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  late MockProductsRepository repository;

  setUp(() {
    repository = MockProductsRepository();
  });

  final tProduct = Product(
    id: 1,
    title: 'Test Product',
    description: 'desc',
    price: 99.99,
    discountPercentage: 0,
    rating: 4.0,
    stock: 10,
    brand: 'Brand',
    category: 'cat',
    thumbnail: null,
    images: const [],
  );

  group('ProductDetailCubit', () {
    blocTest<ProductDetailCubit, ProductDetailState>(
      'loadProduct emits [Loading, Loaded] on success',
      build: () {
        when(() => repository.getProduct(1))
            .thenAnswer((_) async => RepoResult(tProduct));
        return ProductDetailCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProduct(1),
      expect: () => [
        const ProductDetailLoading(),
        ProductDetailLoaded(tProduct),
      ],
    );

    blocTest<ProductDetailCubit, ProductDetailState>(
      'loadProduct emits [Loading, Error] on failure',
      build: () {
        when(() => repository.getProduct(1))
            .thenThrow(Exception('Not found'));
        return ProductDetailCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProduct(1),
      expect: () => [
        const ProductDetailLoading(),
        isA<ProductDetailError>().having(
          (e) => e.productId,
          'productId',
          1,
        ),
      ],
    );
  });
}
