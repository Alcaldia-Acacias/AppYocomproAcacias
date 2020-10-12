import 'dart:convert';

import 'package:comproacacias/src/componetes/usuario/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/update.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/updateresponse.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UsuarioRepocitorio {
  final _dio = Get.find<Dio>();

  Future<UpdateModel> updateUsuario(int id, Map<String, dynamic> update,[String currentPassword]) async {
    String data;
    if(currentPassword == null)
       data = jsonEncode({"update":update,"id":id});
    else
       data = jsonEncode({"update":update,"id":id,"currentPassword":currentPassword});
    try {
      final response =
          await this._dio.put('/usuarios/update', data: data );
      return UpdateResponse.toJson(response.data);
    } on DioError catch (error) {
      return ErrorResponseUpdate.toJson(error.response.data);
    }
  }
}
