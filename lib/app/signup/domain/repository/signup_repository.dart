// Define el contrato del repositorio que se implementará en la capa de datos.
import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';

abstract class SignupRepository {
  // Método para registrar un usuario
  Future<void> registerUser(SignupEntity signupEntity);
}
