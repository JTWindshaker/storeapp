import 'package:storeapp/app/users/domain/repository/users_repository.dart';
import 'package:storeapp/app/users/presentation/model/users_model.dart';

class GetUsersUseCase {
  final UsersRepository usersRepository;

  GetUsersUseCase({required this.usersRepository});

  Future<List<UsersModel>> invoke() async {
    final List<UsersModel> users = [];
    try {
      final result = await usersRepository.getUsers();

      for (var element in result) {
        users.add(element.toUsersModel());
      }
    } catch (e) {
      throw (Exception(e));
    }
    return users;
  }
}
