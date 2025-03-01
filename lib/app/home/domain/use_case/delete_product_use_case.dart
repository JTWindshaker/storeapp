import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class DeleteProductUseCase {
  final HomeRepository homeRepository;

  DeleteProductUseCase({required this.homeRepository});

  bool invoke(String id) {
    return homeRepository.deleteProduct(id);
  }
}
