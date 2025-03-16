import 'package:storeapp/app/login/domain/entity/login_entity.dart';

class LoginDataModel {
  final String email;
  final String password;

  LoginDataModel({required this.email, required this.password});

  // Convierte una entidad en un modelo de datos
  // Constructor de fábrica: Permiten devolver una instancia de una subclase, realizar lógica adicional antes de crear una instancia y reutilizar instancias existentes en lugar de crear nuevas.
  factory LoginDataModel.fromEntity(LoginEntity loginEntity) {
    return LoginDataModel(
      email: loginEntity.email,
      password: loginEntity.password,
    );
  }

  // Convierte el modelo en un mapa JSON para Firestore
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
