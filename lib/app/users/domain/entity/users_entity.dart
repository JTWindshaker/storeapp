import 'package:storeapp/app/users/data/remote/dto/users_data_model.dart';
import 'package:storeapp/app/users/presentation/model/users_model.dart';

final class UsersEntity {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  UsersEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.email,
  });

  UsersModel toUsersModel() {
    return UsersModel(id: id, name: name, imageUrl: imageUrl, email: email);
  }

  UsersDataModel toUsersDataModel() {
    return UsersDataModel(id: id, name: name, imageUrl: imageUrl, email: email);
  }
}
