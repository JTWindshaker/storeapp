// Representa la entidad del usuario en la capa de dominio.
class SignupEntity {
  final String id; // Identificador único del usuario
  final String name; // Nombre del usuario
  final String email; // Correo del usuario
  final String password; // Contraseña del usuario
  final String imageUrl; // URL de la imagen de perfil del usuario

  SignupEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.imageUrl,
  });
}
