import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/products_repository.dart';
import '../../../../l10n/l10n.dart';
import '../blocs/product_detail/product_detail_cubit.dart';
import '../widgets/product_detail_content.dart';

/// Full-screen product detail — used on phone via push navigation.
///
/// On tablet the detail is rendered inline via [ProductDetailContent] inside
/// the master-detail shell.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailCubit(
        repository: context.read<ProductsRepository>(),
      )..loadProduct(productId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.productDetailTitle),
        ),
        body: ProductDetailContent(productId: productId),
      ),
    );
  }
}
