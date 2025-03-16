// Define los eventos relacionados con el registro de usuario.
sealed class SignupEvent {}

final class NameChangedEvent extends SignupEvent {
  final String name;
  NameChangedEvent({required this.name});
}

final class EmailChangedEvent extends SignupEvent {
  final String email;
  EmailChangedEvent({required this.email});
}

final class PasswordChangedEvent extends SignupEvent {
  final String password;
  PasswordChangedEvent({required this.password});
}

final class ConfirmPasswordChangedEvent extends SignupEvent {
  final String confirmPassword;
  ConfirmPasswordChangedEvent({required this.confirmPassword});
}

final class UrlImageChangedEvent extends SignupEvent {
  final String imageUrl;
  UrlImageChangedEvent({required this.imageUrl});
}

final class SubmitEvent extends SignupEvent {
  SubmitEvent();
}
