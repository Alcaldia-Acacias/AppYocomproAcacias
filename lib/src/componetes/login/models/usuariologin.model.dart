import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class UsuarioModelResponse extends ResponseModel {

  final Usuario usuario;
  final String token;
  final int idUsuario;
  final String codigoRecuperacion;
  UsuarioModelResponse({this.usuario, this.token,this.idUsuario,this.codigoRecuperacion});

  factory UsuarioModelResponse.toJson(Map<String, dynamic> json)
      => UsuarioModelResponse(
         usuario: Usuario.toJson(json['usuario']) ?? null,
         token: json['token'] ?? '',
         codigoRecuperacion: json['codigo_recuperacion'] ?? '',
         idUsuario: json['id'] ?? 0 
        ); 


}


