import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';

class Calificacion {

final int id;
final Usuario usuario;
final int extrellas;

Calificacion({this.id,this.usuario, this.extrellas});

factory Calificacion.toJson(Map<String,dynamic> json)
      => Calificacion(
         id     : json['id'],
         usuario: Usuario.toJson(json['usuario']) ?? null,
         extrellas: json['extrellas'] ?? null
         );



}