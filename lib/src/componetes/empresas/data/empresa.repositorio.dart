import 'dart:convert';

import 'package:comproacacias/src/componetes/empresas/models/calificacion.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class EmpresaRepositorio {
  final _dio = Get.find<Dio>();

  Future<List<Producto>> getProductosByEmpresa(int idproductos) async {
    final response = await this._dio.get('/productos/empresa/$idproductos');
    return response.data
        ?.map<Producto>((producto) => Producto.toJson(producto))
        ?.toList();
  }

  Future<ResponseModel> getEmpresaByid(int idEmpresa) async {
   try {
    final response = await this._dio.get('/empresas/id/$idEmpresa');
    return ResponseEmpresa(empresa: Empresa.toJson(response.data));
   } catch (error) {
     return ErrorResponse(error);
   }
    
  }

  Future<List<Calificacion>> getCalificacionesByEmpresa(int idEmpresa) async {
    final response = await this._dio.get('/calificaciones/empresa/$idEmpresa');
    return response.data
        ?.map<Calificacion>((calificacion) => Calificacion.toJson(calificacion))
        ?.toList();
  }

  Future<ResponseModel> addEmpresa(
      Empresa empresa, int idUsuario, String path) async {
    FormData data = FormData.fromMap({
      ...empresa.toMap(idUsuario),
      "file": await MultipartFile.fromFile(path, filename: "imagen.jpg")
    });
    try {
      final response = await this._dio.post('/empresas/add/',
          data: data, options: Options(contentType: 'multipart/form-data'));
      print(response.data);
      return ResponseEmpresa(id: response.data['id']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> deleteEmpresa(int id) async {
    try {
      final response = await this._dio.delete('/empresas/delete/$id');
      return ResponseEmpresa(delete: response.data['delete']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> updateEmpresa(Empresa empresa, int idUsuario,
      {String path}) async {
    try {
      FormData data = FormData.fromMap({
        ...empresa.toMap(idUsuario),
        "file": path.isNull
            ? null
            : await MultipartFile.fromFile(path, filename: "imagen.jpg")
      });
      final response = await this._dio.put('/empresas/update', data: data);
      return ResponseEmpresa(update: response.data['update']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> calificarEmpresa(
      int idUsuario, int idEmpresa, int extrellas,int idDestinatario,
      [String comentario]) async {
    final data = jsonEncode({
      "id_usuario": idUsuario,
      "id_empresa": idEmpresa,
      "extrellas" : extrellas,
      "comentario": comentario,
      "id_usuario_destinatario": idDestinatario
    });
    try {
      final response = await this._dio.post('/calificaciones/add', data: data);
      return ResponseEmpresa(calificacion: Calificacion.toJson(response.data));
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  /* Future<ResponseModel> addProducto(Producto producto, int idEmpresa,
      {String path}) async {
    try {
      FormData data = FormData.fromMap({
        ...producto.toMap(idEmpresa),
        "file": path.isNull
            ? null
            : await MultipartFile.fromFile(path, filename: "${producto.imagen}")
      });
      final response = await this._dio.post('/productos/add', data: data);
      print(response.data);
      return ResponseEmpresa(idProducto: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  } */

  Future<ResponseModel> deleteProducto(int idProducto) async {
    try {
      final response = await this._dio.delete('/productos/delete/$idProducto');
      return ResponseEmpresa(delete: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  /* Future<ResponseModel> updateProducto(Producto producto, int idEmpresa,
      {String path}) async {
    try {
      FormData data = FormData.fromMap({
        "id": producto.id,
        ...producto.toMap(idEmpresa),
        "file": path.isNull
            ? null
            : await MultipartFile.fromFile(path, filename: "${producto.imagen}")
      });
      final response = await this._dio.put('/productos/update', data: data);
      return ResponseEmpresa(update: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  } */

  Future<ResponseModel> searchEmpresa(String texto) async {
    try {
      final response = await _dio.get('/empresas/buscar/$texto');
      final empresas = response.data
          ?.map<Empresa>((empresa) => Empresa?.toJson(empresa))
          ?.toList();
      return ResponseEmpresa(empresas: empresas);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> registrarVisitaEmpresa(
      int idEmpresa, int idUsuario) async {
    try {
      FormData data =
          FormData.fromMap({"id_empresa": idEmpresa, "id_usuario": idUsuario});
      final response = await _dio.post('/visitas/add/', data: data);
      return ResponseEmpresa(visita: response.data['visita']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  
}
