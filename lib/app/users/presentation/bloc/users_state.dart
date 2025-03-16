import 'package:storeapp/app/users/presentation/model/list_users_model.dart';

sealed class UsersState {
  final ListUsersModel model;

  UsersState({required this.model});
}

final class EmptyState extends UsersState {
  EmptyState() : super(model: ListUsersModel(users: []));
}

final class LoadingState extends UsersState {
  final String message;
  LoadingState({this.message = "Cargando Usuarios..."})
    : super(model: ListUsersModel(users: []));
}

final class LoadDataState extends UsersState {
  LoadDataState({required super.model});
}

final class UsersErrorState extends UsersState {
  final String message;
  UsersErrorState({required super.model, required this.message});
}
