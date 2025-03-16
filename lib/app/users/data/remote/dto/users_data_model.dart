import 'package:storeapp/app/users/domain/entity/users_entity.dart';

class UsersDataModel {
  late final String id;
  late final String name;
  late final String email;
  late final String imageUrl;

  UsersDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  //Constructor con Nombre
  UsersDataModel.fromJson(this.id, Map<String, dynamic> json) {
    // id = json["id"];
    name = json["name"];
    email = json["email"];
    imageUrl = json["imageUrl"];
  }

  // Acá se harían las converciones o cualquier mapeo que se requiera de un dato que venga del service y queramos pasarle a nuestro modelo de negocio
  UsersEntity toEntity() {
    return UsersEntity(id: id, name: name, imageUrl: imageUrl, email: email);
  }

  // Convierte una entidad en un modelo de datos
  // Constructor de fábrica: Permiten devolver una instancia de una subclase, realizar lógica adicional antes de crear una instancia y reutilizar instancias existentes en lugar de crear nuevas.
  factory UsersDataModel.fromEntity(UsersEntity usersEntity) {
    return UsersDataModel(
      id: usersEntity.id,
      name: usersEntity.name,
      email: usersEntity.email,
      imageUrl: usersEntity.imageUrl,
    );
  }

  // Convierte el modelo en un mapa JSON para Firestore
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "imageUrl": imageUrl, "email": email};
  }
}
