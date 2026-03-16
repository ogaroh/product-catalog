import 'package:equatable/equatable.dart';
import '../../../data/models/product.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
  @override
  List<Object?> get props => [];
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
  @override
  List<Object?> get props => [];
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded(this.product);
  final Product product;
  @override
  List<Object?> get props => [product];
}

class ProductDetailError extends ProductDetailState {
  const ProductDetailError({required this.message, required this.productId});
  final String message;
  final int productId;
  @override
  List<Object?> get props => [message, productId];
}
