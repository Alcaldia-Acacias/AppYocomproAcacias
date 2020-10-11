import 'dart:io';

import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/login/data/login.repositorio.dart';
import 'package:comproacacias/src/componetes/login/models/error.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class LoginController extends GetxController {

  final LoginRepositorio repositorio;

  LoginController({this.repositorio});

  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  TextEditingController usuarioLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  FocusNode passwordFocoLogin = FocusNode();
  FocusNode usuarioFocoLogin = FocusNode();

  GlobalKey<FormState> formKeySingin = GlobalKey<FormState>();
  TextEditingController usuarioSinginController = TextEditingController();
  TextEditingController nombreSinginController = TextEditingController();
  TextEditingController fechaSinginController = TextEditingController();
  TextEditingController passwordSinginController = TextEditingController();
  TextEditingController confirmPasswordSinginController =
      TextEditingController();

  FocusNode usuarioFocoSingin = FocusNode();
  FocusNode nombreFocoSingin = FocusNode();
  FocusNode passwordFocoSingin = FocusNode();
  FocusNode confirmPasswordFocoSingin = FocusNode();

  DateTime fechaNacimiento = DateTime.now();
  Usuario usuario;
  void submitFormLogin() async {
    if (formKeyLogin.currentState.validate()) {
      final response = await repositorio.login(
          usuarioLoginController.text, passwordLoginController.text);
      if (response is ErrorLogin) this._loginError(response.error);
      if (response is UsuarioModelLogin) this._loginOk(response);
    }
  }

  void submitFormSingIn() {
    print(confirmPasswordSinginController.text);
    print(passwordSinginController.text);
    if (formKeySingin.currentState.validate() && this.comparePassword())
      print('listo');
    if (!this.comparePassword())
      Get.snackbar("Error", "no coinciden las contraseñas");
  }

  bool comparePassword() {
    if (passwordSinginController.text == confirmPasswordSinginController.text)
      return true;
    return false;
  }

  String formatFecha(DateTime fecha) {
    if (!fecha.isNull) return DateFormat("dd MMMM 'del' yyyy").format(fecha);
    return '';
  }

  void _loginError(String error) {
    if (error == 'DATA_INCORRECT')
      Get.snackbar('Datos Incorrectos', 'Contraseña no valida');
    if (error == 'USER_NO_EXITS')
      Get.snackbar('Usuario no existe', 'Registrese');
  }

  void _loginOk(UsuarioModelLogin response) async {
    final box = GetStorage();
    await box.write('token', response.token);
    await box.write('id', response.usuario.id);
    Get.find<Dio>().options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${box.read('token')}'
    };
    Get.find<HomeController>().usuario = response.usuario;
    Get.offNamed('/home');
    
  }
}
