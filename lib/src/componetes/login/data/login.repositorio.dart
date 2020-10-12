
import 'package:comproacacias/src/componetes/login/models/error.model.dart';
import 'package:comproacacias/src/componetes/login/models/login.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginRepositorio {
  final _dio = Get.find<Dio>();

  Future<LoginModel> login(String correo, String password) async {
    try {
      await new Future.delayed(new Duration(milliseconds: 1000));
      final response = await this
          ._dio
          .post('/usuarios/login', data: {"correo": correo, "pass": password});
      return UsuarioModelLogin.toJson(response.data);
    } on DioError catch (error) {
      return ErrorLogin.toJson(error.response.data);
    }
  }

Future<LoginModel> addUsuario(Map<String, dynamic> usuario) async {
     FormData formData = new FormData.fromMap(usuario);
     try {
      await new Future.delayed(new Duration(milliseconds: 1000));
     final response = await this._dio.post('/usuarios/add',data:formData);
      return UsuarioModelLogin.toJson(response.data); 
    } on DioError catch (error) {
      return ErrorLogin.toJson(error.response.data);
    }
  }
}
