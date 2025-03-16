// Servicio que interactúa con Firestore para registrar el usuario.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/signup/data/remote/dto/signup_data_model.dart';

class SignupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registra un usuario en la colección "users"
  Future<void> registerUser(SignupDataModel signupDataModel) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: signupDataModel.email,
            password: signupDataModel.password,
          );

      User? user = userCredential.user;

      if (user != null) {
        signupDataModel.id = user.uid;

        await _firestore
            .collection("users")
            .doc(signupDataModel.id)
            .set(signupDataModel.toJson());
      }
    } catch (e) {
      print("Error en el registro: $e");
    }
  }
}
