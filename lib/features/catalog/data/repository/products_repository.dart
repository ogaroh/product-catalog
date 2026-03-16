import '../../../../core/cache/cache_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../datasources/products_local_source.dart';
import '../datasources/products_remote_source.dart';
import '../models/product.dart';
import '../models/products_response.dart';

/// Result wrapper that carries whether data was served from local cache.
class RepoResult<T> {
  const RepoResult(this.data, {this.isFromCache = false});
  final T data;
  final bool isFromCache;
}

/// Remote-first repository with Hive cache fallback.
/// On network error, stale cache is served with [isFromCache] = true.
class ProductsRepository {
  ProductsRepository({
    ProductsRemoteSource? remote,
    ProductsLocalSource? local,
  })  : _remote = remote ?? ProductsRemoteSource(),
        _local = local ?? ProductsLocalSource();

  final ProductsRemoteSource _remote;
  final ProductsLocalSource _local;

  Future<RepoResult<ProductsResponse>> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    final key = CacheConstants.listKey(skip, limit);
    return _fetchResponse(
      key: key,
      remote: () => _remote.getProducts(limit: limit, skip: skip),
    );
  }

  Future<RepoResult<ProductsResponse>> searchProducts(String query) async {
    final key = CacheConstants.searchKey(query);
    return _fetchResponse(
      key: key,
      remote: () => _remote.searchProducts(query),
    );
  }

  Future<RepoResult<List<String>>> getCategories() async {
    if (_local.areCategoriesFresh()) {
      final cached = _local.getCategories();
      if (cached != null) return RepoResult(cached, isFromCache: true);
    }

    try {
      final cats = await _remote.getCategories();
      await _local.putCategories(cats);
      return RepoResult(cats);
    } catch (e) {
      final cached = _local.getCategories();
      if (cached != null) return RepoResult(cached, isFromCache: true);
      throw _noDataOrRethrow(e);
    }
  }

  Future<RepoResult<ProductsResponse>> getProductsByCategory(
    String category,
  ) async {
    final key = CacheConstants.categoryKey(category);
    return _fetchResponse(
      key: key,
      remote: () => _remote.getProductsByCategory(category),
    );
  }

  Future<RepoResult<Product>> getProduct(int id) async {
    if (_local.isProductFresh(id)) {
      final cached = _local.getProduct(id);
      if (cached != null) return RepoResult(cached, isFromCache: true);
    }

    try {
      final product = await _remote.getProduct(id);
      await _local.putProduct(product);
      return RepoResult(product);
    } catch (e) {
      final cached = _local.getProduct(id);
      if (cached != null) return RepoResult(cached, isFromCache: true);
      throw _noDataOrRethrow(e);
    }
  }

  // ── Private helpers ───────────────────────────────────────

  Future<RepoResult<ProductsResponse>> _fetchResponse({
    required String key,
    required Future<ProductsResponse> Function() remote,
  }) async {
    if (_local.isResponseFresh(key)) {
      final cached = _local.getResponse(key);
      if (cached != null) return RepoResult(cached, isFromCache: true);
    }

    try {
      final response = await remote();
      await _local.putResponse(key, response);
      return RepoResult(response);
    } catch (e) {
      final cached = _local.getResponse(key);
      if (cached != null) return RepoResult(cached, isFromCache: true);
      throw _noDataOrRethrow(e);
    }
  }

  AppException _noDataOrRethrow(Object e) {
    if (e is AppException) return e;
    return NoDataException(e.toString());
  }
}
