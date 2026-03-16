import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/products_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({required ProductsRepository repository})
      : _repository = repository,
        super(const ProductDetailInitial());

  final ProductsRepository _repository;

  Future<void> loadProduct(int id) async {
    emit(const ProductDetailLoading());
    try {
      final result = await _repository.getProduct(id);
      emit(ProductDetailLoaded(result.data));
    } catch (e) {
      emit(ProductDetailError(message: e.toString(), productId: id));
    }
  }
}
