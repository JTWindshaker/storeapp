import 'dart:math';

import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  bool deleteProduct(String id) {
    return Random().nextBool();
  }

  @override
  List<ProductEntity> getProducts() {
    return [
      ProductEntity(
        id: "1",
        name: "TV",
        description: "Descripcion del TV",
        image:
            "https://img.freepik.com/vector-premium/logotipo-productos-naturales_1222-726.jpg",
        price: 12000,
      ),
    ];
  }
}
