import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'products_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsResponse {
  const ProductsResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  bool get hasMore => skip + products.length < total;

  factory ProductsResponse.fromValidatedJson(Map<String, dynamic> json) {
    final rawList = json['products'];
    final List<Map<String, dynamic>> rawProducts =
        rawList is List ? rawList.cast<Map<String, dynamic>>() : [];
    final validatedProducts =
        rawProducts.map(Product.validated).toList(growable: false);

    return ProductsResponse(
      products: validatedProducts,
      total: (json['total'] as num?)?.toInt() ?? 0,
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
