import 'package:storeapp/app/users/domain/entity/users_entity.dart';

final class UsersModel {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  UsersModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.email,
  });

  UsersModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? email,
  }) {
    return UsersModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  UsersEntity toEntity() =>
      UsersEntity(id: id, name: name, imageUrl: imageUrl, email: email);
}
