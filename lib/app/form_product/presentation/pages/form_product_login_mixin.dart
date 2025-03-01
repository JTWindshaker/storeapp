mixin FormProductLoginMixin {
  String? validatePassword(value) {
    value ??= "";
    if (value.length < 8) {
      return "La contraseña debe tener 8 caracteres";
    }

    return null;
  }

  String? validateEmail(value) {
    value = value ?? "";
    final bool isValid = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
    ).hasMatch(value);

    return isValid ? null : "Email no válido";
  }
}
