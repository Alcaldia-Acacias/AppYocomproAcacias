
import 'package:comproacacias/src/componetes/login/models/error.model.dart';
import 'package:comproacacias/src/componetes/login/models/login.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginRepositorio {
  final _dio = Get.find<Dio>();

  Future<LoginModel> login(String correo, String password) async {
    try {
      final response = await this
          ._dio
          .post('/usuarios/login', data: {"correo": correo, "pass": password});
      return UsuarioModelLogin.toJson(response.data);
    } on DioError catch (error) {
      return ErrorLogin.toJson(error.response.data);
    }
  }
}
