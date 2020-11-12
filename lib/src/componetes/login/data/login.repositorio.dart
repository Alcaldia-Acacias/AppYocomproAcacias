
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginRepositorio {
  final _dio = Get.find<Dio>();

  Future<ResponseModel> login(String correo, String password) async {
    try {
      await new Future.delayed(new Duration(milliseconds: 500));
      final response = await this
          ._dio
          .post('/usuarios/login', data: {"correo": correo, "pass": password});
      return UsuarioModelResponse.toJson(response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

Future<ResponseModel> addUsuario(Map<String, dynamic> usuario) async {
     FormData formData = new FormData.fromMap(usuario);
     try {
      await new Future.delayed(new Duration(milliseconds: 1000));
     final response = await this._dio.post('/usuarios/add',data:formData);
      return UsuarioModelResponse.toJson(response.data); 
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
Future<ResponseModel> sendEmailRecovery(String email) async {
     FormData formData = new FormData.fromMap({
       "email" : email
     });
     try {
     final response = await this._dio.post('/usuarios/get/codigo_recuperacion',data:formData);
      return UsuarioModelResponse.toJson(response.data); 
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
}
