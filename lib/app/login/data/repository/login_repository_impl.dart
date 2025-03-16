// Implementación del repositorio en la capa de datos.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/login/data/remote/dto/login_data_model.dart';
import 'package:storeapp/app/login/data/remote/services/login_service.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService loginService;

  LoginRepositoryImpl({required this.loginService});

  @override
  Future<UserCredential?> loginUser(LoginEntity loginEntity) async {
    final userModel = LoginDataModel.fromEntity(loginEntity);
    late final UserCredential? resultLogin;

    try {
      resultLogin = await loginService.login(userModel);

      if (resultLogin == null) {
        throw Exception("❌❌❌❌❌❌❌❌Error macabro❌❌❌❌❌❌❌❌");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("login", true);

      return resultLogin;
    } catch (e) {
      print("🤣🤣🤣🤣🤣🤣ERROR EN EL LOGIN 🤣🤣🤣🤣🤣🤣");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("login", false);
      return null;
    }
  }
}
