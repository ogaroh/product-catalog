import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/features/catalog/data/models/product.dart';
import 'package:product_catalog/features/catalog/data/models/products_response.dart';
import 'package:product_catalog/features/catalog/data/repository/products_repository.dart';
import 'package:product_catalog/features/catalog/presentation/blocs/product_list/product_list_cubit.dart';
import 'package:product_catalog/features/catalog/presentation/blocs/product_list/product_list_state.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  late MockProductsRepository repository;

  setUpAll(() {
    registerFallbackValue(const ProductsResponse(
      products: [],
      total: 0,
      skip: 0,
      limit: 20,
    ));
  });

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

  final tResponse = ProductsResponse(
    products: [tProduct],
    total: 1,
    skip: 0,
    limit: 20,
  );

  void mockLoadProducts({ProductsResponse? response, Exception? error}) {
    if (error != null) {
      when(() => repository.getProducts(
            limit: any(named: 'limit'),
            skip: any(named: 'skip'),
          )).thenThrow(error);
    } else {
      when(() => repository.getProducts(
            limit: any(named: 'limit'),
            skip: any(named: 'skip'),
          )).thenAnswer((_) async => RepoResult(response ?? tResponse));
    }
  }

  group('ProductListCubit', () {
    blocTest<ProductListCubit, ProductListState>(
      'loadProducts emits [Loading, Loaded] on success',
      build: () {
        mockLoadProducts();
        return ProductListCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductListLoading(),
        ProductListLoaded(
          products: [tProduct],
          total: 1,
          currentSkip: 0,
        ),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'loadProducts emits [Loading, Error] on failure',
      build: () {
        mockLoadProducts(error: Exception('Network error'));
        return ProductListCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductListLoading(),
        isA<ProductListError>(),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'loadProducts emits [Loading, Empty] when response has no products',
      build: () {
        when(() => repository.getProducts(
              limit: any(named: 'limit'),
              skip: any(named: 'skip'),
            )).thenAnswer((_) async => RepoResult(const ProductsResponse(
              products: [],
              total: 0,
              skip: 0,
              limit: 20,
            )));
        return ProductListCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductListLoading(),
        const ProductListEmpty(),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'search emits [Loading, Loaded] with search results',
      build: () {
        when(() => repository.searchProducts(any()))
            .thenAnswer((_) async => RepoResult(tResponse));
        return ProductListCubit(repository: repository);
      },
      act: (cubit) => cubit.search('laptop'),
      expect: () => [
        const ProductListLoading(),
        ProductListLoaded(
          products: [tProduct],
          total: 1,
          currentSkip: 0,
          activeQuery: 'laptop',
        ),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'filterByCategory emits [Loading, Loaded] with filtered results',
      build: () {
        when(() => repository.getProductsByCategory(any()))
            .thenAnswer((_) async => RepoResult(tResponse));
        return ProductListCubit(repository: repository);
      },
      act: (cubit) => cubit.filterByCategory('electronics'),
      expect: () => [
        const ProductListLoading(),
        ProductListLoaded(
          products: [tProduct],
          total: 1,
          currentSkip: 0,
          activeCategory: 'electronics',
        ),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'selectProduct updates selectedProductId',
      build: () {
        mockLoadProducts();
        return ProductListCubit(repository: repository);
      },
      seed: () => ProductListLoaded(
        products: [tProduct],
        total: 1,
        currentSkip: 0,
      ),
      act: (cubit) => cubit.selectProduct(42),
      expect: () => [
        ProductListLoaded(
          products: [tProduct],
          total: 1,
          currentSkip: 0,
          selectedProductId: 42,
        ),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'isFromCache is true when repository returns cached result',
      build: () {
        when(() => repository.getProducts(
              limit: any(named: 'limit'),
              skip: any(named: 'skip'),
            )).thenAnswer((_) async => RepoResult(tResponse, isFromCache: true));
        return ProductListCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        const ProductListLoading(),
        ProductListLoaded(
          products: [tProduct],
          total: 1,
          currentSkip: 0,
          isFromCache: true,
        ),
      ],
    );
  });
}
