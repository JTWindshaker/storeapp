import 'package:storeapp/app/users/data/remote/services/users_service.dart';
import 'package:storeapp/app/users/domain/entity/users_entity.dart';
import 'package:storeapp/app/users/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersService usersService;

  UsersRepositoryImpl({required this.usersService});

  @override
  Future<List<UsersEntity>> getUsers() async {
    final List<UsersEntity> users = [];

    try {
      final response = await usersService.getAllUsers();
      
      for (var obj in response) {
        users.add(obj.toEntity());
      }
    } catch (e) {
      throw (Exception("Error: $e"));
    }

    return users;
  }
}
