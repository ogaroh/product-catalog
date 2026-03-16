import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/features/catalog/data/repository/products_repository.dart';
import 'package:product_catalog/features/catalog/presentation/blocs/category/category_cubit.dart';
import 'package:product_catalog/features/catalog/presentation/blocs/category/category_state.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  late MockProductsRepository repository;

  setUp(() {
    repository = MockProductsRepository();
  });

  group('CategoryCubit', () {
    blocTest<CategoryCubit, CategoryState>(
      'loadCategories emits [Loading, Loaded] on success',
      build: () {
        when(() => repository.getCategories()).thenAnswer(
          (_) async =>
              RepoResult(['smartphones', 'laptops', 'fragrances']),
        );
        return CategoryCubit(repository: repository);
      },
      act: (cubit) => cubit.loadCategories(),
      expect: () => [
        const CategoryLoading(),
        const CategoryLoaded(
          categories: ['smartphones', 'laptops', 'fragrances'],
        ),
      ],
    );

    blocTest<CategoryCubit, CategoryState>(
      'loadCategories emits [Loading, Error] on failure',
      build: () {
        when(() => repository.getCategories())
            .thenThrow(Exception('Network error'));
        return CategoryCubit(repository: repository);
      },
      act: (cubit) => cubit.loadCategories(),
      expect: () => [
        const CategoryLoading(),
        isA<CategoryError>(),
      ],
    );

    blocTest<CategoryCubit, CategoryState>(
      'selectCategory updates selected category',
      build: () => CategoryCubit(repository: repository),
      seed: () => const CategoryLoaded(
        categories: ['smartphones', 'laptops'],
      ),
      act: (cubit) => cubit.selectCategory('laptops'),
      expect: () => [
        const CategoryLoaded(
          categories: ['smartphones', 'laptops'],
          selectedCategory: 'laptops',
        ),
      ],
    );

    blocTest<CategoryCubit, CategoryState>(
      'selectCategory with null selects "All"',
      build: () => CategoryCubit(repository: repository),
      seed: () => const CategoryLoaded(
        categories: ['smartphones'],
        selectedCategory: 'smartphones',
      ),
      act: (cubit) => cubit.selectCategory(null),
      expect: () => [
        const CategoryLoaded(
          categories: ['smartphones'],
        ),
      ],
    );
  });
}
