import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  Future<UserCredential?> loginUser(LoginEntity login);
}
