import 'package:equatable/equatable.dart';
import '../../../data/models/product.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
  @override
  List<Object?> get props => [];
}

/// Shown only on the very first load (shimmer placeholder).
class ProductListLoading extends ProductListState {
  const ProductListLoading();
  @override
  List<Object?> get props => [];
}

class ProductListLoaded extends ProductListState {
  const ProductListLoaded({
    required this.products,
    required this.total,
    required this.currentSkip,
    this.isLoadingMore = false,
    this.activeQuery,
    this.activeCategory,
    this.isFromCache = false,
    this.selectedProductId,
  });

  final List<Product> products;
  final int total;
  final int currentSkip;

  /// True while fetching the next page (shows spinner at list bottom).
  final bool isLoadingMore;

  final String? activeQuery;
  final String? activeCategory;

  /// True when data came from local cache — shows offline banner.
  final bool isFromCache;

  /// The currently selected product id (used in tablet master-detail).
  final int? selectedProductId;

  bool get hasMore => currentSkip + products.length < total;

  ProductListLoaded copyWith({
    List<Product>? products,
    int? total,
    int? currentSkip,
    bool? isLoadingMore,
    Object? activeQuery = _sentinel,
    Object? activeCategory = _sentinel,
    bool? isFromCache,
    Object? selectedProductId = _sentinel,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      total: total ?? this.total,
      currentSkip: currentSkip ?? this.currentSkip,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      activeQuery:
          activeQuery == _sentinel ? this.activeQuery : activeQuery as String?,
      activeCategory: activeCategory == _sentinel
          ? this.activeCategory
          : activeCategory as String?,
      isFromCache: isFromCache ?? this.isFromCache,
      selectedProductId: selectedProductId == _sentinel
          ? this.selectedProductId
          : selectedProductId as int?,
    );
  }

  static const Object _sentinel = Object();

  @override
  List<Object?> get props => [
        products,
        total,
        currentSkip,
        isLoadingMore,
        activeQuery,
        activeCategory,
        isFromCache,
        selectedProductId,
      ];
}

class ProductListError extends ProductListState {
  const ProductListError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class ProductListEmpty extends ProductListState {
  const ProductListEmpty({this.activeQuery, this.activeCategory});
  final String? activeQuery;
  final String? activeCategory;
  @override
  List<Object?> get props => [activeQuery, activeCategory];
}
