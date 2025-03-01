import 'package:storeapp/app/core/data/remote/services/product_service.dart';
import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';

class FormProductRepositoryImpl implements FormProductRepository {
  final ProductService productService;

  FormProductRepositoryImpl({required this.productService});

  @override
  Future<bool> addProduct(ProductEntity productEntity) async {
    try {
      return productService.add(productEntity.toProductDataModel());
    } catch (e) {
      throw (Exception("Error: $e"));
    }
  }

  @override
  Future<ProductEntity> getProduct(String id) async {
    try {
      final response = await productService.getProduct(id);
      return response.toEntity();
    } catch (e) {
      throw (Exception("Error: $e"));
    }
  }
}
