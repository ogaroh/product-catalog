import 'package:equatable/equatable.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
  @override
  List<Object?> get props => [];
}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded({
    required this.categories,
    this.selectedCategory,
  });

  final List<String> categories;
  /// null means "All categories" is selected.
  final String? selectedCategory;

  CategoryLoaded copyWith({
    List<String>? categories,
    // Use a sentinel to distinguish "set to null" from "keep existing"
    Object? selectedCategory = _sentinel,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory == _sentinel
          ? this.selectedCategory
          : selectedCategory as String?,
    );
  }

  static const Object _sentinel = Object();

  @override
  List<Object?> get props => [categories, selectedCategory];
}

class CategoryError extends CategoryState {
  const CategoryError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
