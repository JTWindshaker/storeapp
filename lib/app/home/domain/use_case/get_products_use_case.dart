import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase({required this.homeRepository});

  List<ProductModel> invoke() {
    // final List<ProductModel> products = [
    //   ProductModel(
    //     id: "1",
    //     name: "Televisor",
    //     description: "Gran televisor de 42''",
    //     urlImage:
    //         "https://img.freepik.com/vector-premium/logotipo-productos-naturales_1222-726.jpg",
    //     price: 12000,
    //   ),
    // ];

    return homeRepository
        .getProducts()
        .map((item) => item.toProductModel())
        .toList();
  }
}
