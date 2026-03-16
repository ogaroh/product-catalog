import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/product.dart';
import '../models/products_response.dart';

/// Fetches product data from the DummyJSON remote API.
class ProductsRemoteSource {
  ProductsRemoteSource({Dio? dio}) : _dio = dio ?? DioClient.instance.dio;

  final Dio _dio;

  Future<ProductsResponse> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    return _execute(
      () => _dio.get<Map<String, dynamic>>(
        ApiEndpoints.products,
        queryParameters: {'limit': limit, 'skip': skip},
      ),
      ProductsResponse.fromValidatedJson,
    );
  }

  Future<ProductsResponse> searchProducts(String query) async {
    return _execute(
      () => _dio.get<Map<String, dynamic>>(
        ApiEndpoints.productSearch,
        queryParameters: {'q': query},
      ),
      ProductsResponse.fromValidatedJson,
    );
  }

  Future<List<String>> getCategories() async {
    try {
      final response =
          await _dio.get<List<dynamic>>(ApiEndpoints.productCategories);
      final data = response.data;
      if (data == null) throw const ParseException('Null category data');
      // DummyJSON returns a list of category objects with {slug, name, url}
      return data
          .map((e) {
            if (e is Map) return e['slug'] as String? ?? e['name'] as String? ?? '';
            return e.toString();
          })
          .where((s) => s.isNotEmpty)
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<ProductsResponse> getProductsByCategory(String category) async {
    return _execute(
      () => _dio.get<Map<String, dynamic>>(
        ApiEndpoints.productsByCategory(category),
      ),
      ProductsResponse.fromValidatedJson,
    );
  }

  Future<Product> getProduct(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.productById(id),
      );
      final data = response.data;
      if (data == null) throw const ParseException('Null product data');
      return Product.validated(data);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<T> _execute<T>(
    Future<Response<Map<String, dynamic>>> Function() request,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) throw const ParseException('Null response data');
      return fromJson(data);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  /// Serialise a [ProductsResponse] to a JSON string for caching.
  static String encodeResponse(ProductsResponse r) => jsonEncode(r.toJson());

  /// Deserialise a cached JSON string back to a [ProductsResponse].
  static ProductsResponse decodeResponse(String raw) =>
      ProductsResponse.fromValidatedJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );

  /// Serialise a single [Product] to JSON string for caching.
  static String encodeProduct(Product p) => jsonEncode(p.toJson());

  /// Deserialise a cached product JSON string.
  static Product decodeProduct(String raw) =>
      Product.validated(jsonDecode(raw) as Map<String, dynamic>);
}
