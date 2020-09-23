import 'package:intl/intl.dart';

class Comentario {

  final int id, idUsuario;
  final String comentario, nombreUsuario, imagenUsuario,fecha;

  Comentario(
      {this.id,
      this.idUsuario,
      this.comentario,
      this.nombreUsuario,
      this.imagenUsuario,
      this.fecha});

  factory Comentario.toJson(Map<String,dynamic> json)
          => Comentario(
             id            : json['id'],
             comentario    : json['comentario'],
             idUsuario     : json['id_usuario'],
             nombreUsuario : json['nombre_usuario'],
             imagenUsuario : json['imagen_usuario'],
             fecha         : json['fecha_comentario']
          );
    String formatFecha() => DateFormat("dd MMMM 'del' yyyy  h:mm a")
                          .format(DateTime.parse(this.fecha));
}
