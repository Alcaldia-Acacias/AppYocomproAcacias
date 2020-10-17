import 'package:comproacacias/src/componetes/publicaciones/models/cometario.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/like.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:intl/intl.dart';

class Publicacion {

  final int id, likes, numeroComentarios;
  final String  texto,fecha;
  final Empresa empresa;
  final Usuario usuario;
  final List<Comentario> comentarios;
  final List<String> imagenes;
  final List<LikePublicacion> usuariosLike;
  final bool megusta;

  Publicacion( 
      {this.id,
      this.likes,
      this.numeroComentarios,
      this.texto,
      this.fecha,
      this.empresa,
      this.usuario,
      this.imagenes,
      this.comentarios, 
      this.usuariosLike,
      this.megusta});

factory Publicacion.toJson(Map<String,dynamic> json,)
   =>Publicacion(
     id                : json['id'] ?? 0,
     likes             : json['likes'] ?? '',
     numeroComentarios : json['comentarios'],
     texto             : json['texto'] ?? '',
     imagenes          : json['imagenes'].map<String>((imagen)=>'${imagen['nombre']}').toList() ?? '',
     fecha             : json['fecha'] ?? '',
     megusta           : json['megusta'] ?? false,
     empresa           : Empresa?.toJson(json['empresa']) ?? '',
     comentarios       : json['data_comentarios']?.map<Comentario>((comentario)=> Comentario.toJson(comentario))?.toList(),
     usuariosLike      : json["likes_usuarios"]?.map<LikePublicacion>((like)=> LikePublicacion.toJson(like))?.toList() 
   );

   String formatFecha() => DateFormat("dd MMMM 'del' yyyy  h:mm a")
                          .format(DateTime.parse(this.fecha));
  
   Publicacion copyWith(
     {int id, 
      int likes, 
      int numeroComentarios,
      String  texto, 
      String fecha,
      Empresa empresa,
      Usuario usuario,
      List<Comentario> comentarios,
      List<String> imagenes,
      List<LikePublicacion> usuariosLike,
      bool megusta
     }
   ) => Publicacion(
        id                : id                ?? this.id,
        likes             : likes             ?? this.likes,
        numeroComentarios : numeroComentarios ?? this.numeroComentarios,
        texto             : texto             ?? this.texto,
        fecha             : fecha             ?? this.fecha,
        empresa           : empresa           ?? this.empresa,
        usuario           : usuario           ?? this.usuario,
        comentarios       : comentarios       ?? this.comentarios,
        imagenes          : imagenes          ?? this.imagenes,
        usuariosLike      : usuariosLike      ?? this.usuariosLike,
        megusta           : megusta           ?? this.megusta
    );
}
        