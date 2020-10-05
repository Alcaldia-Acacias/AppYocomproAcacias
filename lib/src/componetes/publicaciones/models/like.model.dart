import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class LikePublicacion {
  final String fecha;
  final Usuario usuario;

  LikePublicacion({this.fecha, this.usuario});

  factory LikePublicacion.toJson(Map<String,dynamic> json)
      => json == null
         ? LikePublicacion()
         : LikePublicacion(
           fecha: json['fecha'],
           usuario: Usuario.toJson(json['usuario'])
         );
}
