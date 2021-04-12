import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:intl/intl.dart';

class Comentario {

  final int id;
  final String comentario,fecha;
  final Usuario usuario;

  Comentario(
      {this.id,
      this.comentario,
      this.usuario,
      this.fecha});

  factory Comentario.toJson(Map<String,dynamic> json)
          => Comentario(
             id            : json['id'] ?? 0,
             comentario    : json['comentario'] ?? '',
             fecha         : json['fecha'] ?? '',
             usuario       : Usuario?.toJson(json['usuario']) 
          );
    String formatFecha() => DateFormat("dd MMMM 'del' yyyy  h:mm a")
                          .format(DateTime.parse(this.fecha));
}
