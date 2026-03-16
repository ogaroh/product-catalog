import 'dart:developer' as dev;
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/utils/image_utils.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  final int id;
  final String title;
  final String description;
  final double? price;
  final double discountPercentage;
  final double rating;
  final int stock;
  @JsonKey(defaultValue: '')
  final String brand;
  @JsonKey(defaultValue: '')
  final String category;
  final String? thumbnail;
  final List<String> images;

  /// Discounted price, or null when price is unavailable.
  double? get discountedPrice {
    if (price == null) return null;
    if (discountPercentage <= 0) return price;
    return price! * (1 - discountPercentage / 100);
  }

  /// Parses raw JSON and applies validation / sensible defaults.
  factory Product.validated(Map<String, dynamic> json) {
    final raw = _$ProductFromJson(json);

    final rawPrice = json['price'];
    double? validatedPrice;
    if (rawPrice is num && rawPrice > 0) {
      validatedPrice = rawPrice.toDouble();
    } else {
      dev.log(
        'Product id=${json['id']}: invalid price "$rawPrice"',
        name: 'Product',
        level: 1000, // ERROR
      );
    }

    final rawBrand = json['brand'];
    final validatedBrand = (rawBrand is String && rawBrand.isNotEmpty)
        ? rawBrand
        : 'Unknown Brand';
    if (validatedBrand == 'Unknown Brand' && rawBrand != null) {
      dev.log(
        'Product id=${json['id']}: missing brand',
        name: 'Product',
        level: 800,
      );
    }

    final rawCategory = json['category'];
    final validatedCategory =
        (rawCategory is String && rawCategory.isNotEmpty)
            ? rawCategory
            : 'Uncategorized';

    final rawTitle = json['title'];
    final validatedTitle =
        (rawTitle is String && rawTitle.isNotEmpty) ? rawTitle : 'Unknown Product';

    final validatedThumbnail = ImageUtils.validateUrl(
      raw.thumbnail,
      fieldName: 'thumbnail',
    );

    final rawImages = json['images'];
    final List<String> rawImagesList =
        rawImages is List ? rawImages.cast<String>() : [];
    List<String> validatedImages =
        ImageUtils.filterUrls(rawImagesList, fieldName: 'images');
    if (validatedImages.isEmpty && validatedThumbnail != null) {
      validatedImages = [validatedThumbnail];
    }

    return Product(
      id: raw.id,
      title: validatedTitle,
      description: raw.description,
      price: validatedPrice,
      discountPercentage: raw.discountPercentage.clamp(0, 100),
      rating: raw.rating.clamp(0, 5),
      stock: raw.stock < 0 ? 0 : raw.stock,
      brand: validatedBrand,
      category: validatedCategory,
      thumbnail: validatedThumbnail,
      images: validatedImages,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
