import 'dart:convert';
import '../../../../core/cache/cache_constants.dart';
import '../../../../core/cache/hive_service.dart';
import '../models/product.dart';
import '../models/products_response.dart';
import 'products_remote_source.dart';

/// Reads and writes product data to/from the local Hive cache.
class ProductsLocalSource {
  final _products = HiveService.instance.products;
  final _timestamps = HiveService.instance.timestamps;

  bool _isFresh(String key) {
    final ts = _timestamps.get(key);
    if (ts == null) return false;
    final stored = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateTime.now().difference(stored) < CacheConstants.cacheTtl;
  }

  // ── ProductsResponse cache ────────────────────────────────

  ProductsResponse? getResponse(String key) {
    final raw = _products.get(key);
    if (raw == null) return null;
    try {
      return ProductsRemoteSource.decodeResponse(raw);
    } catch (_) {
      return null;
    }
  }

  bool isResponseFresh(String key) => _isFresh(key);

  Future<void> putResponse(String key, ProductsResponse r) async {
    await _products.put(key, ProductsRemoteSource.encodeResponse(r));
    await _timestamps.put(key, DateTime.now().millisecondsSinceEpoch);
  }

  // ── Categories cache ──────────────────────────────────────

  List<String>? getCategories() {
    final raw = _products.get('categories');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<String>();
    } catch (_) {
      return null;
    }
  }

  bool areCategoriesFresh() => _isFresh('categories');

  Future<void> putCategories(List<String> cats) async {
    await _products.put('categories', jsonEncode(cats));
    await _timestamps.put('categories', DateTime.now().millisecondsSinceEpoch);
  }

  // ── Single product cache ──────────────────────────────────

  Product? getProduct(int id) {
    final key = CacheConstants.productKey(id);
    final raw = _products.get(key);
    if (raw == null) return null;
    try {
      return ProductsRemoteSource.decodeProduct(raw);
    } catch (_) {
      return null;
    }
  }

  bool isProductFresh(int id) => _isFresh(CacheConstants.productKey(id));

  Future<void> putProduct(Product p) async {
    final key = CacheConstants.productKey(p.id);
    await _products.put(key, ProductsRemoteSource.encodeProduct(p));
    await _timestamps.put(key, DateTime.now().millisecondsSinceEpoch);
  }
}
