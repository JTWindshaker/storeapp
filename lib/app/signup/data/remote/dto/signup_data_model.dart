// Modelo de datos que mapea la entidad a JSON para Firestore.
import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';

class SignupDataModel {
  String id;
  final String name;
  final String email;
  final String password;
  final String imageUrl;

  SignupDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.imageUrl,
  });

  // Convierte una entidad en un modelo de datos
  // Constructor de fábrica: Permiten devolver una instancia de una subclase, realizar lógica adicional antes de crear una instancia y reutilizar instancias existentes en lugar de crear nuevas.
  factory SignupDataModel.fromEntity(SignupEntity signupEntity) {
    return SignupDataModel(
      id: signupEntity.id,
      name: signupEntity.name,
      email: signupEntity.email,
      password: signupEntity.password,
      imageUrl: signupEntity.imageUrl,
    );
  }

  // Convierte el modelo en un mapa JSON para Firestore
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "imageUrl": imageUrl,
    };
  }
}
