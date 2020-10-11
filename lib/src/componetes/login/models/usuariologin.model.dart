import 'package:comproacacias/src/componetes/login/models/login.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class UsuarioModelLogin extends LoginModel {

  final Usuario usuario;
  final String token;

  UsuarioModelLogin({this.usuario, this.token});

  factory UsuarioModelLogin.toJson(Map<String, dynamic> json)
      => UsuarioModelLogin(
         usuario: Usuario.toJson(json['usuario']),
         token: json['token']
        ); 


}


