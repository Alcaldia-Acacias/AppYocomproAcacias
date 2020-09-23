import 'package:comproacacias/src/componetes/publicaciones/models/cometario.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PublicacionesRepositorio {
  Dio _dio = Get.find<Dio>();

  Future<List<Publicacion>> getPublicaciones(int page) async {
    final response =
        await _dio.get('/publicaciones', queryParameters: {'page': page});
    return response.data
        .map<Publicacion>((publicacion) => Publicacion.toJson(publicacion))
        .toList();
  }

  updatePublicacion(int id) async {}

  Future<List<Comentario>> getComentariosByPublicacion(
      int idPublicacion) async {
    final response =
        await _dio.get('/publicaciones/comentarios/$idPublicacion');
    return response.data
        .map<Comentario>((comentario) => Comentario.toJson(comentario))
        .toList();
  }

  Future<List<Usuario>> getUsuarioLike(int idPublicacion) async {
    final response =
        await _dio.get('/publicaciones/likes/$idPublicacion');
    return response.data
        .map<Usuario>((usuario) => Usuario.toJson(usuario))
        .toList();
  }
}
