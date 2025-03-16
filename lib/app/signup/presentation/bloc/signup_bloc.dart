import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/signup/domain/use_case/register_user_use_case.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUserUseCase registerUserUseCase;

  SignupBloc({required this.registerUserUseCase}) : super(InitialState()) {
    on<NameChangedEvent>(_nameChangedEvent);
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<ConfirmPasswordChangedEvent>(_confirmPasswordChangedEvent);
    on<UrlImageChangedEvent>(_urlImageChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  void _nameChangedEvent(NameChangedEvent event, Emitter<SignupState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(name: event.name),
    );

    emit(newState);
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<SignupState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(email: event.email),
    );

    emit(newState);
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  void _confirmPasswordChangedEvent(
    ConfirmPasswordChangedEvent event,
    Emitter<SignupState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(confirmPassword: event.confirmPassword),
    );

    emit(newState);
  }

  void _urlImageChangedEvent(
    UrlImageChangedEvent event,
    Emitter<SignupState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(imageUrl: event.imageUrl),
    );

    emit(newState);
  }

  void _submitEvent(SubmitEvent event, Emitter<SignupState> emit) async {
    late SignupState newState;

    try {
      // newState = LoadingState();
      // emit(newState);

      await registerUserUseCase.invoke(state.model);
      newState = SubmitSuccessState(model: state.model);
    } catch (e) {
      print("👌👌👌👌👌👌$e👌👌👌👌👌👌");
      newState = SubmitErrorState(
        model: state.model,
        message: "Error al Guardar el Usuario",
      );
    }

    emit(newState);
  }
}
