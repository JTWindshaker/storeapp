// Caso de uso que maneja la lógica de negocio para el registro de usuario.
import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/presentation/model/signup_model.dart';

class RegisterUserUseCase {
  final SignupRepository signupRepository;

  RegisterUserUseCase({required this.signupRepository});

  Future<void> invoke(SignupModel signupModel) async {
    try {
      final SignupEntity data = signupModel.toEntity();
      return signupRepository.registerUser(data);
    } catch (e) {
      throw ("Error: $e");
    }
  }
}
