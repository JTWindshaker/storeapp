// Define los posibles estados del proceso de registro.
import 'package:storeapp/app/signup/presentation/model/signup_model.dart';

sealed class SignupState {
  final SignupModel model;

  SignupState({required this.model});
}

final class InitialState extends SignupState {
  InitialState()
    : super(
        model: SignupModel(
          id: "",
          name: "",
          email: "",
          password: "",
          confirmPassword: "",
          imageUrl:
              "https://img.freepik.com/vector-premium/imagen-perfil-avatar-hombre-ilustracion-vectorial_268834-538.jpg?semt=ais_hybrid",
        ),
      );
}

final class DataUpdateState extends SignupState {
  DataUpdateState({required super.model});
}

// final class LoadingState extends SignupState {
//   final String message;
//   LoadingState({this.message = "Guardando Usuario..."})
//     : super(
//         model: SignupModel(
//           id: "",
//           name: "",
//           email: "",
//           password: "",
//           confirmPassword: "",
//           imageUrl: "",
//         ),
//       );
// }

final class SubmitSuccessState extends SignupState {
  SubmitSuccessState({required super.model});
}

final class SubmitErrorState extends SignupState {
  final String message;
  SubmitErrorState({required super.model, required this.message});
}
