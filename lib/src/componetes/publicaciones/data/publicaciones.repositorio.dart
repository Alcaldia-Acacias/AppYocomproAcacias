import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
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


  Future<List<Publicacion>> getPublicacionesByEmpresa(int id) async {
    Dio _dio = Get.find<Dio>();
    final response = await _dio.get('/publicaciones/empresa/$id');
    final publicaciones = response.data;
    return publicaciones
        .map<Publicacion>((e) => Publicacion.toJson(e))
        .toList();
  }
}
