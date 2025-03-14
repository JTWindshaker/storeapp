import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/domain/repository/sesion_repository.dart';

class SesionRepositoryImp implements SesionRepository {
  SesionRepositoryImp();

  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", false);
    return true;
  }
}
