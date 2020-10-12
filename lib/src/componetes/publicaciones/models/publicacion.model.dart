import 'package:comproacacias/src/componetes/publicaciones/models/categoria.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/cometario.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/like.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:intl/intl.dart';

class Publicacion {

  final int id, likes, numeroComentarios, tipo;
  final String  texto,fecha;
  final Empresa empresa;
  final Usuario usuario;
  final Categoria categoria;
  final List<Comentario> comentarios;
  final List<String> imagenes;
  final List<LikePublicacion> usuariosLike;

  Publicacion( 
      {this.id,
      this.likes,
      this.numeroComentarios,
      this.texto,
      this.tipo,
      this.fecha,
      this.empresa,
      this.usuario,
      this.categoria,
      this.imagenes,
      this.comentarios, 
      this.usuariosLike,});

factory Publicacion.toJson(Map<String,dynamic> json,)
   =>Publicacion(
     id                : json['id'] ?? 0,
     likes             : json['likes'] ?? '',
     numeroComentarios : json['numero_comentarios'],
     texto             : json['texto'] ?? '',
     imagenes          : json['imagenes'].map<String>((imagen)=>'${imagen['nombre']}.jpg').toList() ?? '',
     tipo              : json['tipo'] ?? '',
     fecha             : json['fecha'] ?? '',
     empresa           : Empresa?.toJson(json['empresa']) ?? '',
     comentarios       : json['comentarios']?.map<Comentario>((comentario)=> Comentario.toJson(comentario))?.toList(),
     usuariosLike      : json["likes_usuarios"]?.map<LikePublicacion>((like)=> LikePublicacion.toJson(like))?.toList() 
   );

   String formatFecha() => DateFormat("dd MMMM 'del' yyyy  h:mm a")
                          .format(DateTime.parse(this.fecha));
  
}
        