import 'package:storeapp/app/users/domain/entity/users_entity.dart';

abstract class UsersRepository {
  Future<List<UsersEntity>> getUsers();
}
