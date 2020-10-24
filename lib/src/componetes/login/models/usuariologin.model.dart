import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class UsuarioModelResponse extends ResponseModel {

  final Usuario usuario;
  final String token;

  UsuarioModelResponse({this.usuario, this.token});

  factory UsuarioModelResponse.toJson(Map<String, dynamic> json)
      => UsuarioModelResponse(
         usuario: Usuario.toJson(json['usuario']),
         token: json['token']
        ); 


}


