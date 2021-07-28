import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:intl/intl.dart';

class Notificacion {
  
  final int id;
  final Usuario usuario;
  final String titulo, mensaje, fecha;
  final NotificacionTipo tipo;
  final bool leida;
  final int idPublicacion, idEmpresa;

  Notificacion(
      {
      this.id,
      this.usuario,
      this.titulo,
      this.mensaje,
      this.tipo,
      this.leida,
      this.fecha,
      this.idPublicacion,
      this.idEmpresa});

  factory Notificacion.toJson(Map<String, dynamic> json) => Notificacion(
        id            : json['id'],
        usuario       : Usuario.toJson(json['usuario_remitente']) ?? Usuario(),
        mensaje       : json['mensaje'] ?? '',
        titulo        : json['titulo'] ?? '',
        idEmpresa     : json['id_empresa'] ?? 0,
        idPublicacion : json['id_publicacion'] ?? 0,
        leida         : json['leida'],
        tipo          : NotificacionTipo.values.firstWhere((tipo) => tipo.toString().split('.').last == json['tipo']),
        fecha         : json['fecha'] ?? '',
  );

  String formatFecha() => DateFormat("dd MMMM 'del' yyyy  h:mm a")
      .format(DateTime.parse(this.fecha));


Notificacion copyWith(
 {int id,
 Usuario usuario,
 String titulo,
 String mensaje,
 NotificacionTipo tipo,
 bool leida,
 String fecha,
 int idPublicacion,
 int idEmpresa}
) => Notificacion(
     id            :  id            ?? this.id,
     usuario       :  usuario       ?? this.usuario,
     titulo        :  titulo        ?? this.titulo,
     mensaje       :  mensaje       ?? this.mensaje,
     tipo          :  tipo          ?? this.tipo,
     leida         :  leida         ?? this.leida,
     fecha         :  fecha         ?? this.fecha,
     idPublicacion :  idPublicacion ?? this.idPublicacion,
     idEmpresa     :  idEmpresa     ?? this.idEmpresa
);

   static NotificacionTipo getTipo(dynamic json) {
    return NotificacionTipo.values
        .firstWhere((tipo) => tipo.toString().split('.').last == json);
  }
}

enum NotificacionTipo { MEGUSTA, COMENTARIO, MENSAJE, CALIFICACION }
