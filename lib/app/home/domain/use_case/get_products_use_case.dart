// import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase({required this.homeRepository});

  Future<List<ProductModel>> invoke() async {
    final List<ProductModel> products = [];
    try {
      final result = await homeRepository.getProducts();

      for (var element in result) {
        products.add(element.toProductModel());
      }
    } catch (e) {
      throw (Exception(e));
    }
    return products;

    // try {
    //   List<ProductEntity> products = await homeRepository.getProducts();
    //   return products.map((item) => item.toProductModel()).toList();
    // } catch (e) {
    //   throw (Exception("Error: $e"));
    // }
  }
}
