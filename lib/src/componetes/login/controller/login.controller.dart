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
  bool loading = false;
  Future dialog;
  void submitFormLogin() async {
    if (formKeyLogin.currentState.validate()) {
      this._openDialog();
      final response = await repositorio.login(
          usuarioLoginController.text, passwordLoginController.text);
      if (response is ErrorLogin) this._loginError(response.error);
      if (response is UsuarioModelLogin) this._loginOk(response);
    }
  }

  void submitFormSingIn() async {
    if (formKeySingin.currentState.validate() && this.comparePassword()) {
      this._openDialog();
      final usuario = {
        "imagen": '',
        "biografia": '',
        "sexo": 'M',
        "numero": '',
        "rol": 0,
        "codigo_recuperacion": '',
        "nombre": nombreSinginController.text,
        "pass": passwordSinginController.text,
        "nacimiento": fechaNacimiento,
        "correo": usuarioSinginController.text
      };
      final response = await repositorio.addUsuario(usuario);
      if (response is ErrorLogin) this._loginError(response.error);
      if (response is UsuarioModelLogin) this._loginOk(response);
    }
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
    Get.back();
    if (error == 'DATA_INCORRECT')
      Get.snackbar('Datos Incorrectos', 'Contraseña no valida');
    if (error == 'USER_NO_EXITS')
      Get.snackbar('Usuario no existe', 'Registrese');
    if (error == 'USER_EXITS')
      Get.snackbar('Usuario ya Registrado', 'Inicia Session');
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

  void _openDialog() {
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
              height: 40, child: Center(child: CircularProgressIndicator())),
          title: Text('Iniciando', textAlign: TextAlign.center),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          elevation: 0,
        ),
        barrierDismissible: false);
  }
}
