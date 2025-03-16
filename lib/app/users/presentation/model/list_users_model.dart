import 'package:storeapp/app/users/presentation/model/users_model.dart';

class ListUsersModel {
  final List<UsersModel> users;

  ListUsersModel({required this.users});

  ListUsersModel copyWith({List<UsersModel>? users}) {
    return ListUsersModel(users: users ?? this.users);
  }
}
