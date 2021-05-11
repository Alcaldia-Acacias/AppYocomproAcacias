import 'dart:convert';
import 'dart:io';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/reporte.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/updateresponse.model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UsuarioRepocitorio {

  final _dio = Get.find<dio.Dio>();
  Future<ResponseModel> updateUsuario(int id, Map<String, dynamic> update,
      [String currentPassword, String token]) async {
    this._verificarToken(token);
    String data;
    if (currentPassword == null)
      data = jsonEncode({"update": update, "id": id});
    else
      data = jsonEncode(
          {"update": update, "id": id, "currentPassword": currentPassword});
    try {
      final response = await this._dio.put('/usuarios/update', data: data);
      return UsuarioResponse.toJson(response.data);
    } on dio.DioError catch (error) {
      return ErrorResponse(error);
    }
  }
  Future<ResponseModel> sendReporte(Reporte reporte) async {
    final data = jsonEncode(
     reporte.toMap()
    );
    try {
      final response = await this._dio.post('/reportes/add', data: data);
      return UsuarioResponse.toJson(response.data);
    } on dio.DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  

  void _verificarToken(String token) {
    if (!GetStorage().hasData('token') && !token.isNullOrBlank) 
      this._dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token'
    };
  }
}
