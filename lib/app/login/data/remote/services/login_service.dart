import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/login/data/remote/dto/login_data_model.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> login(LoginDataModel loginDataModel) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: loginDataModel.email,
        password: loginDataModel.password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("❌ Error en el login: ${e.code} - ${e.message}");
      return null;
      // throw _handleAuthError(e);
    }
  }

  // Exception _handleAuthError(FirebaseAuthException e) {
  //   switch (e.code) {
  //     case "invalid-email":
  //       return Exception("El formato del email es inválido.");
  //     case "user-disabled":
  //       return Exception("Este usuario ha sido deshabilitado.");
  //     case "user-not-found":
  //       return Exception("No existe una cuenta con este correo.");
  //     case "wrong-password":
  //       return Exception("Contraseña incorrecta.");
  //     default:
  //       return Exception("Error desconocido: ${e.message}");
  //   }
  // }
}
