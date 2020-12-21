import 'dart:io';
import 'package:comproacacias/src/componetes/login/data/login.repositorio.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:comproacacias/src/componetes/login/models/recovery.model.dart';
import 'package:comproacacias/src/componetes/usuario/views/cambiarContrase%C3%B1a.view.dart';
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
  TextEditingController cedulaSinginController = TextEditingController();
  TextEditingController passwordSinginController = TextEditingController();
  TextEditingController confirmPasswordSinginController =
      TextEditingController();

  FocusNode usuarioFocoSingin = FocusNode();
  FocusNode nombreFocoSingin = FocusNode();
  FocusNode cedulaFocoSingin = FocusNode();
  FocusNode passwordFocoSingin = FocusNode();
  FocusNode confirmPasswordFocoSingin = FocusNode();

  TextEditingController emailRecoveryController = TextEditingController();
  TextEditingController codigoRecoveryController = TextEditingController();
  final formKeyRecovery = GlobalKey<FormState>();
  RecoveryData recovery;
  bool loading = false;
  bool codigo = false;
  Future dialog;

  void submitFormLogin() async {
    if (formKeyLogin.currentState.validate()) {
      this._openDialog();
      final response = await repositorio.login(
          usuarioLoginController.text, passwordLoginController.text);
      if (response is ErrorResponse) this._loginError(response.getError);
      if (response is UsuarioModelResponse) this._loginOk(response);
    }
  }

  void submitFormSingIn() async {
    if (formKeySingin.currentState.validate() && this._comparePassword()) {
      this._openDialog();
      final usuario = {
        "imagen": '',
        "cedula": cedulaSinginController.text,
        "nombre": nombreSinginController.text,
        "password": passwordSinginController.text,
        "usuario": usuarioSinginController.text,
        "administrador": false
      };
      final response = await repositorio.addUsuario(usuario);
      if (response is ErrorResponse) this._loginError(response.getError);
      if (response is UsuarioModelResponse) this._loginOk(response);
    }
    if (!this._comparePassword())
      Get.snackbar("Error", "no coinciden las contraseñas");
  }

  void sendEmail() async {
    if (this.formKeyRecovery.currentState.validate()) {
      this._loading();
      final response =
          await repositorio.sendEmailRecovery(emailRecoveryController.text);
      if (response is UsuarioModelResponse) this._recoveryPassword(response);
      if (response is ErrorResponse) this._emailError(response.getError);
    }
  }

  void verficarCodigo() {
    if (recovery.codigoRecuperacion == codigoRecoveryController.text)
      Get.offAll(CambiarPasswordPage(dataRecovery: recovery));
    else
      Get.snackbar('Codigo incorrecto', '');
  }

  void resetSendEmail() {
    this.emailRecoveryController.text = '';
    this.loading = false;
    this.codigo = false;
    update();
  }

  bool _comparePassword() {
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
    if (error == 'Connection refused')
      Get.snackbar('No estas Conectado', 'Conectate a Internet');
  }

  void _loginOk(UsuarioModelResponse response) async {
    final box = GetStorage();
    await box.write('token', response.token);
    await box.write('id', response.usuario.id);
    Get.find<Dio>().options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${box.read('token')}'
    };
    Get.offAllNamed('/home');
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

  void _loading() {
    this.loading = !this.loading;
    update();
  }

  void _recoveryPassword(UsuarioModelResponse response) {
    print(response.codigoRecuperacion);
    Get.snackbar('Codigo enviado', 'el codigo fue enviado');
    this.codigo = true;
    this.recovery = RecoveryData(
        idUsuario: response.idUsuario,
        codigoRecuperacion: response.codigoRecuperacion,
        token: response.token);
    this._loading();
  }

  internetCheck() async {
    final box = GetStorage();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty &&
          result[0].rawAddress.isNotEmpty &&
          box.hasData('token')) {
        Get.offNamed('/home');
      }
      if (result.isNotEmpty &&
          result[0].rawAddress.isNotEmpty &&
          !box.hasData('token')) {
        Get.offNamed('/');
      }
    } on SocketException catch (_) {
      print(_);
    }
  }

  void _emailError(String error) {
    if (error == 'USER_NO_EXITS') {
      Get.snackbar('Usuario no existe', '');
      this.resetSendEmail();
    }
  }
}
