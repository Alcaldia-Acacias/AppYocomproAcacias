import 'dart:io';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/login/data/login.repositorio.dart';
import 'package:comproacacias/src/componetes/login/models/login_user.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/login/models/usuariologin.model.dart';
import 'package:comproacacias/src/componetes/login/models/recovery.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/usuario/views/cambiarContrase%C3%B1a.view.dart';
import 'package:comproacacias/src/componetes/widgets/dialogAlert.widget.dart';
import 'package:comproacacias/src/plugins/apple_sing.dart';
import 'package:comproacacias/src/plugins/facebook_sing.dart';
import 'package:comproacacias/src/plugins/google_sing_in.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  LoginUsuario _usuario;
  HomeController homeController = Get.find<HomeController>();
  PublicacionesController publicacionesController =
      Get.find<PublicacionesController>();

  void submitFormLogin() async {
    if (formKeyLogin.currentState.validate()) {
      this._openDialog();
      final response = await repositorio.login(
          usuarioLoginController.text, passwordLoginController.text);
      this._verificarResponse(response);
    }
  }

  void submitFormSingIn() async {
    if (!this._comparePassword())
      Get.snackbar("Error", "no coinciden las contraseñas");
    if (formKeySingin.currentState.validate() && this._comparePassword()) {
      this._openDialog();
      _usuario = _formularioAsingUsuario();
    }
    if (!_usuario.isNullOrBlank) {
      final response = await repositorio.addUsuario(_usuario.toMap());
      this._verificarResponse(response);
    }
  }

  void singInGoogleUsuario() async {
    Get.back();
    _usuario = await _googleAsingUsuario();
    if (!_usuario.isNullOrBlank) {
      final response = await repositorio.addUsuario(_usuario.toMap());
      this._verificarResponse(response);
    }
  }

  void singInFacebookUsuario() async {
    Get.back();
    _usuario = await _facebookAsingUsuario();
    if (!_usuario.isNullOrBlank) {
      final response = await repositorio.addUsuario(_usuario.toMap());
      this._verificarResponse(response);
    }
  }

  void singInAppleUsuario() async {
    Get.back();
    _usuario = await _appleAsingUsuario();
    if (!_usuario.isNullOrBlank) {
      final response = await repositorio.addUsuario(_usuario.toMap());
      this._verificarResponse(response);
    }
  }

  void loginGoogle() async {
    this._openDialog();
    _usuario = await _googleAsingUsuario();
    if (!_usuario.isNullOrBlank) {
      final response =
          await repositorio.login(_usuario.email, '', _usuario.googleId);
      this._verificarResponse(response);
    }
  }

  void loginFacebook() async {
    this._openDialog();
    _usuario = await _facebookAsingUsuario();
    if (!_usuario.isNullOrBlank) {
      final response =
          await repositorio.login(_usuario.email, '', _usuario.facebookId);
      this._verificarResponse(response);
    }
  }

  void loginApple() async {
    this._openDialog();
    _usuario = await _appleAsingUsuario();
    if (!_usuario.isNullOrBlank) {
      final response =
          await repositorio.login(_usuario.email, '', _usuario.appleId);
      this._verificarResponse(response);
    }
  }

  void sendEmail() async {
    if (this.formKeyRecovery.currentState.validate()) {
      this._loading();
      final response =
          await repositorio.sendEmailRecovery(emailRecoveryController.text);
      this._verificarResponse(response, true);
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

  String formatFecha(DateTime fecha) {
    if (!fecha.isNull) return DateFormat("dd MMMM 'del' yyyy").format(fecha);
    return '';
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

  void _loginError(String error) async {
    if (error == 'DATA_INCORRECT') {
      Get.back();
      Get.snackbar('Datos Incorrectos', 'Contraseña no valida');
    }
    if (error == 'USER_NO_EXITS') {
      Get.back();
      Get.snackbar('Usuario no existe', '');
      this.resetSendEmail();
    }
    if (error == 'USER_EXITS')
      Get.snackbar('Usuario ya Registrado', 'Inicia Sesion');
    if (error == 'Connection refused')
      Get.snackbar('No estas Conectado', 'Conectate a Internet');
    await googleLogOut();
  }

  void _loginOk(UsuarioModelResponse response) async {
    final box = GetStorage();
    await box.write('token', response.token);
    await box.write('id', response.usuario.id);
    Get.find<Dio>().options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${box.read('token')}'
    };
    await homeController.loginInitOption();
    homeController.selectPage(1);
    publicacionesController.updateIdUsuario();
    Get.back();
  }

  void _openDialog() {
    Get.dialog(AlertDialogLoading(titulo: 'Iniciando'),
            barrierDismissible: false)
        .whenComplete(() => Get.back());
  }

  void _loading() {
    this.loading = !this.loading;
    update();
  }

  void _recoveryPassword(UsuarioModelResponse response) {
    Get.snackbar('Codigo enviado', 'el codigo fue enviado');
    this.codigo = true;
    this.recovery = RecoveryData(
        idUsuario: response.idUsuario,
        codigoRecuperacion: response.codigoRecuperacion,
        token: response.token);
    this._loading();
  }

  void _verificarResponse(ResponseModel response,
      [bool passwordRecovery = false]) {
    if (response is UsuarioModelResponse && passwordRecovery)
      this._recoveryPassword(response);
    if (response is UsuarioModelResponse && !passwordRecovery)
      this._loginOk(response);
    if (response is ErrorResponse) this._loginError(response.getError);
  }

  Future<LoginUsuario> _googleAsingUsuario() async {
    try {
      final UserCredential credential = await signInWithGoogle();
      final userGoogle = credential.user;
      return LoginUsuario(
          imagen: '',
          nombre: userGoogle.displayName,
          usuario: userGoogle.email,
          administrador: false,
          googleId: userGoogle.uid);
    } catch (error) {
      Get.back();
      Get.snackbar('Error', 'Ocurrio un error');
      return null;
    }
  }

  Future<LoginUsuario> _facebookAsingUsuario() async {
    try {
      final UserCredential credential = await signInWithFacebook();
      final userFacebook = credential.user;
      return LoginUsuario(
          imagen: '',
          nombre: userFacebook.displayName,
          usuario: userFacebook.email,
          administrador: false,
          facebookId: userFacebook.uid);
    } catch (error) {
      Get.back();
      Get.snackbar('Error', 'Ocurrio un error');
      return null;
    }
  }

  Future<LoginUsuario> _appleAsingUsuario() async {
    try {
      final UserCredential credential = await signInWithApple();
      final userApple = credential.user;
      return LoginUsuario(
          imagen: '',
          nombre: userApple.displayName,
          usuario: userApple.email,
          administrador: false,
          appleId: userApple.uid);
    } catch (error) {
      Get.back();
      Get.snackbar('Error', 'Ocurrio un error');
      return null;
    }
  }

  LoginUsuario _formularioAsingUsuario() {
    return LoginUsuario(
        imagen: '',
        cedula: cedulaSinginController.text,
        nombre: nombreSinginController.text,
        password: passwordSinginController.text,
        usuario: usuarioSinginController.text,
        administrador: false);
  }

  bool _comparePassword() {
    if (passwordSinginController.text == confirmPasswordSinginController.text)
      return true;
    return false;
  }
}
