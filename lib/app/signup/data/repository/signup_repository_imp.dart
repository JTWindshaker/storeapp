// Implementación del repositorio en la capa de datos.
import 'package:storeapp/app/signup/data/remote/dto/signup_data_model.dart';
import 'package:storeapp/app/signup/data/remote/services/signup_service.dart';
import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';

class SignupRepositoryImp implements SignupRepository {
  final SignupService signupService;

  SignupRepositoryImp({required this.signupService});

  @override
  Future<void> registerUser(SignupEntity user) async {
    final userModel = SignupDataModel.fromEntity(user);
    await signupService.registerUser(userModel);
  }
}
