import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class Calificacion {

final int id;
final Usuario usuario;
final int extrellas;
final String comentario;

Calificacion({this.id,this.usuario, this.extrellas,this.comentario});

factory Calificacion.toJson(Map<String,dynamic> json)
      => Calificacion(
         id     : json['id'],
         usuario: Usuario.toJson(json['usuario']) ?? null,
         extrellas: json['extrellas'] ?? null,
         comentario : json['comentario'] ?? ''
         );



}