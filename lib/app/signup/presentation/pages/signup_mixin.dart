mixin SignupMixin {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "El nombre es obligatorio";
    }

    return null;
  }

  String? validateURL(String? value) {
    if (value == null || value.isEmpty) {
      return "La URL de la imagen es obligatoria";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "La contraseña es obligatoria";
    }
    if (value.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "La contraseña de confirmación es obligatoria";
    }
    if (value.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    }
    if (value != password) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "El correo es obligatorio";
    }
    final bool isValid = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
    ).hasMatch(value);

    return isValid ? null : "Correo no válido";
  }
}
