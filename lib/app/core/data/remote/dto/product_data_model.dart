import 'package:storeapp/app/core/domain/entity/product_entity.dart';

class ProductDataModel {
  final String id;
  late final String name;
  late final String description;
  late final String imageURL;
  late final int price;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.price,
  });

  //Constructor con Nombre
  ProductDataModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json["name"];
    description = "xxx";
    price = json["price"];
    imageURL = json["image"];
  }

  // Acá se harían las converciones o cualquier mapeo que se requiera de un dato que venga del service y queramos pasarle a nuestro modelo de negocio
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      image: imageURL,
      price: price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": imageURL,
      "price": price,
    };
  }
}
