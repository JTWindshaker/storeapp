import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class DeleteProductUseCase {
  final HomeRepository homeRepository;

  DeleteProductUseCase({required this.homeRepository});

  // Si no se coloca async, es porque no dependo de esperar nada.
  Future<bool> invoke(String id) {
    try {
      return homeRepository.deleteProduct(id);
    } catch (e) {
      throw (Exception("Error: $e"));
    }
  }
}
