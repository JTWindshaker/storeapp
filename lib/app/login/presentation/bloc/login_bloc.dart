import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);
    // _loginUseCase = LoginUseCase();
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
    // final newData = LoginFormModel(
    //   email: event.email,
    //   password: state.model.password,
    // );

    final newState = DataUpdateState(
      model: state.model.copyWith(email: event.email),
    );

    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  void _submitEvent(SubmitEvent event, Emitter<LoginState> emit) async {
    late final LoginState newState;

    try {
      print('😍😍😍😍😍😍😍😍${state.model.email}😍😍😍😍😍😍😍😍');
      print('😍😍😍😍😍😍😍😍${state.model.password}😍😍😍😍😍😍😍😍');
      final result = await loginUseCase.invoke(state.model);
      print('😍😍😍😍😍😍😍😍${result}😍😍😍😍😍😍😍😍');
      if (result == null) {
        throw Exception();
      }
      newState = LoginSuccessState(model: state.model);
    } catch (e) {
      print('😍😍😍😍😍😍😍😍ERROR ERROR😍😍😍😍😍😍😍😍');
      print('No user found for that email.');
      newState = LoginErrorState(
        model: state.model,
        message: "Error en el inicio de sesión",
      );
    }

    emit(newState);
  }
}
