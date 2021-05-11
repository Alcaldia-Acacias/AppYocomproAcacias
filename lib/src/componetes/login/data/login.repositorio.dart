
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class LoginRepositorio {
  final _dio = Get.find<dio.Dio>();

  Future<ResponseModel> login(String correo, String password,[String socialId]) async {
    try {
      final response = await this
          ._dio
          .post('/usuarios/login', data: {"usuario": correo, "password": password,"social_id": socialId});
      return UsuarioModelResponse.toJson(response.data);
    } on dio.DioError catch (error) {
      return ErrorResponse(error);
    }
  }

Future<ResponseModel> addUsuario(Map<String, dynamic> usuario) async {
     dio.FormData formData = new dio.FormData.fromMap(usuario);
     try {
     final response = await this._dio.post('/usuarios/add',data:formData);
      return UsuarioModelResponse.toJson(response.data); 
    } on dio.DioError catch (error) {
      return ErrorResponse(error);
    }
  }
Future<ResponseModel> sendEmailRecovery(String email) async {
     dio.FormData formData = new dio.FormData.fromMap({
       "email" : email
     });
     try {
     final response = await this._dio.post('/usuarios/get/codigo_recuperacion',data:formData);
      return UsuarioModelResponse.toJson(response.data); 
    } on dio.DioError catch (error) {
      return ErrorResponse(error);
    }
  }
}
