import 'package:storeapp/app/core/domain/repository/sesion_repository.dart';

class LogoutUseCase {
  final SesionRepository sesionRepository;

  LogoutUseCase({required this.sesionRepository});

  Future<bool> invoke() {
    try {
      return sesionRepository.logout();
    } catch (e) {
      throw ("Error: $e");
    }
  }
}
