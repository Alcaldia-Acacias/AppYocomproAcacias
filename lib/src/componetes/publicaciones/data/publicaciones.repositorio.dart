import 'dart:convert';

import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PublicacionesRepositorio {
  Dio _dio = Get.find<Dio>();

  Future<List<Publicacion>> getPublicaciones(int page, int id) async {
    final response =
        await _dio.get('/publicaciones', queryParameters: {'page': page,'id':id});
    return response.data
        .map<Publicacion>((publicacion) => Publicacion.toJson(publicacion))
        .toList();
  }

   Future meGustaPublicacion(int idPublicacion,int idUsuario) async {
      final data = jsonEncode({'id_usuario':idUsuario,'id_publicacion':idPublicacion});
      final response =  await _dio.post('/likes/add',data: data);
      return response.data;
   }

   Future noMeGustaPublicacion(int idPublicacion,int idUsuario) async {
      final data = jsonEncode({'id_usuario':idUsuario,'id_publicacion':idPublicacion});
      final response =  await _dio.delete('/likes/delete',data: data);
      return response.data;
   }


  Future<List<Publicacion>> getPublicacionesByEmpresa(int idEmpresa,int idUsuario) async {
    final response = await _dio.get('/publicaciones/empresa/$idEmpresa',queryParameters: {'id':idUsuario});
    final publicaciones = response.data;
    return publicaciones
        .map<Publicacion>((e) => Publicacion.toJson(e))
        .toList();
  }
}
