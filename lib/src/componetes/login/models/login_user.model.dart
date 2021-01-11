import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class LoginUsuario extends Usuario {
  final String password;
  final bool administrador;
  final String googleId;
  LoginUsuario(
      {nombre,
      usuario,
      cedula,
      imagen,
      this.password,
      this.administrador,
      this.googleId})
      : super(nombre: nombre, email: usuario, cedula: cedula, imagen: imagen);

  toMap() => {
        "imagen": imagen,
        "cedula": cedula ?? null,
        "nombre": nombre,
        "password": password ?? null,
        "usuario": email,
        "administrador": administrador,
        "google_id": googleId
      };
}
