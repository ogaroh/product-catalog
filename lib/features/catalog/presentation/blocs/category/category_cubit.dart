import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog/features/catalog/data/repository/products_repository.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required ProductsRepository repository})
      : _repository = repository,
        super(const CategoryInitial());

  final ProductsRepository _repository;

  Future<void> loadCategories() async {
    emit(const CategoryLoading());
    try {
      final result = await _repository.getCategories();
      emit(CategoryLoaded(categories: result.data));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  void selectCategory(String? category) {
    final current = state;
    if (current is CategoryLoaded) {
      emit(current.copyWith(selectedCategory: category));
    }
  }
}
