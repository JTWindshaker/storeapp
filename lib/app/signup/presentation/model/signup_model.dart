import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';

final class SignupModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String imageUrl;

  SignupModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.imageUrl,
  });

  SignupModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? imageUrl,
  }) {
    return SignupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  SignupEntity toEntity() => SignupEntity(
    id: id,
    name: name,
    email: email,
    password: password,
    imageUrl: imageUrl,
  );
}
