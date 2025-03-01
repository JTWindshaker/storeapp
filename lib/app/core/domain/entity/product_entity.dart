import 'package:storeapp/app/home/presentation/model/product_model.dart';

final class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final int price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      urlImage: image,
      price: price,
    );
  }
}
