import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product.dart';
import '../../../data/repository/products_repository.dart';
import 'product_list_state.dart';

const int _pageSize = 20;

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit({required ProductsRepository repository})
      : _repository = repository,
        scrollController = ScrollController(),
        super(const ProductListInitial()) {
    scrollController.addListener(_onScroll);
  }

  final ProductsRepository _repository;

  /// Preserved across navigation so the list position is restored on back.
  final ScrollController scrollController;

  String? _activeQuery;
  String? _activeCategory;

  // ── Public API ────────────────────────────────────────────

  Future<void> loadProducts() async {
    _activeQuery = null;
    _activeCategory = null;
    emit(const ProductListLoading());
    await _fetch(skip: 0, replace: true);
  }

  Future<void> refresh() async {
    _activeQuery = null;
    _activeCategory = null;
    await _fetch(skip: 0, replace: true);
  }

  Future<void> search(String query) async {
    _activeQuery = query.trim().isEmpty ? null : query.trim();
    _activeCategory = null;
    emit(const ProductListLoading());
    await _fetch(skip: 0, replace: true);
  }

  Future<void> filterByCategory(String? category) async {
    _activeCategory = category;
    emit(const ProductListLoading());
    await _fetch(skip: 0, replace: true);
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! ProductListLoaded) return;
    if (current.isLoadingMore || !current.hasMore) return;

    emit(current.copyWith(isLoadingMore: true));
    await _fetch(skip: current.currentSkip + current.products.length);
  }

  void selectProduct(int? id) {
    final current = state;
    if (current is ProductListLoaded) {
      emit(current.copyWith(selectedProductId: id));
    }
  }

  // ── Internal ──────────────────────────────────────────────

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final max = scrollController.position.maxScrollExtent;
    final pos = scrollController.offset;
    if (pos >= max * 0.9) {
      loadMore();
    }
  }

  Future<void> _fetch({required int skip, bool replace = false}) async {
    try {
      final RepoResult result;

      if (_activeQuery != null) {
        result = await _repository.searchProducts(_activeQuery!);
      } else if (_activeCategory != null) {
        result = await _repository.getProductsByCategory(_activeCategory!);
      } else {
        result = await _repository.getProducts(limit: _pageSize, skip: skip);
      }

      final response = result.data as dynamic;
      final List<Product> newProducts =
          (response.products as List<dynamic>).cast<Product>();
      final int total = response.total as int;
      final int respondedSkip = response.skip as int;

      if (newProducts.isEmpty && replace) {
        emit(ProductListEmpty(
          activeQuery: _activeQuery,
          activeCategory: _activeCategory,
        ));
        return;
      }

      final current = state;
      final existing = (current is ProductListLoaded && !replace)
          ? current.products
          : <Product>[];

      final int? preservedSelection =
          current is ProductListLoaded ? current.selectedProductId : null;

      emit(ProductListLoaded(
        products: [...existing, ...newProducts],
        total: total,
        currentSkip: respondedSkip,
        isFromCache: result.isFromCache,
        activeQuery: _activeQuery,
        activeCategory: _activeCategory,
        selectedProductId: preservedSelection,
      ));
    } catch (e) {
      // If a reload fails and we have existing data, keep it
      final current = state;
      if (current is ProductListLoaded && current.products.isNotEmpty) {
        emit(current.copyWith(isLoadingMore: false));
      } else {
        emit(ProductListError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    return super.close();
  }
}
