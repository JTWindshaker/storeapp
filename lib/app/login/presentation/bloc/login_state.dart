import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

sealed class LoginState {
  final LoginFormModel model;

  LoginState({required this.model});
}

final class InitialState extends LoginState {
  InitialState() : super(model: LoginFormModel(email: "", password: ""));
}

final class DataUpdateState extends LoginState {
  DataUpdateState({required super.model});
}

final class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.model});
}

final class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({required super.model, required this.message});
}
