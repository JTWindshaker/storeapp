import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';

final class ProductService {
  final Dio dio; // clientHTTP
  final String _baseUrl = "https://storeapp-37369-default-rtdb.firebaseio.com";

  ProductService({required this.dio});

  // Endpoints

  //Listar todo
  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];

    try {
      final Response<Map> response = await dio.get("$_baseUrl/products.json");

      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      throw (Exception("Error: $e"));
    }

    return products;
  }

  //Borrar Producto
  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseUrl/products/$id.json");
    } catch (e) {
      throw (Exception("Error: $e"));
    }

    return true;
  }

  //Crear Producto
  Future<bool> add(ProductDataModel product) async {
    try {
      await dio.post(
        "$_baseUrl/products.json",
        data: product.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (e) {
      throw (Exception("Error: $e"));
    }

    return true;
  }

  Future<ProductDataModel> getProduct(String id) async {
    late final ProductDataModel product;

    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/products/$id.json",
      );

      if (response.data != null) {
        product = ProductDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw (Exception("Error: $e"));
    }

    return product;
  }

  Future<bool> update(ProductDataModel productDataModel) async {
    try {
      await dio.patch(
        "$_baseUrl/products/${productDataModel.id}.json",
        data: productDataModel.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (e) {
      throw (Exception("Error: $e"));
    }

    return true;
  }
}
