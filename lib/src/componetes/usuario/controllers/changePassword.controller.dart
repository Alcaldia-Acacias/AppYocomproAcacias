import 'package:comproacacias/src/componetes/login/models/recovery.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/models/updateresponse.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode currentPasswordFoco = FocusNode();
  FocusNode newPasswordFoco = FocusNode();
  FocusNode confirmPasswordFoco = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();
  int idUsuario;
  final Usuario usuario;
  final UsuarioRepocitorio repositorio;
  final RecoveryData recoveryData;
  ChangePasswordController({this.usuario, this.repositorio, this.recoveryData});

  @override
  void onInit() {
    if (recoveryData?.token != null) {
      this.idUsuario = recoveryData.idUsuario;
    } else
      this.idUsuario = usuario.id;
    super.onInit();
  }

  void changePassword() async {
    if (this.comparePassword()) {
      final update = {"password": newPasswordController.text};
      final response = await this.repositorio.updateUsuario(idUsuario, update,
          currentPasswordController.text, recoveryData?.token);
      if (response is ErrorResponse) this._errorUpdate(response.getError);
      if (response is UsuarioResponse) this._updateOK(response);
    }
    if (!this.comparePassword())
      Get.snackbar('Error', 'las contraseñas no coinciden');
  }

  bool comparePassword() {
    if (newPasswordController.text == confirmPasswordController.text)
      return true;
    return false;
  }

  void _errorUpdate(String error) {
    if (error == 'PASS_INVALID')
      Get.snackbar('Contraseña Actual', 'La contresaña actual es invalida');
  }

  void _updateOK(UsuarioResponse response) {
    if (response.update) {
      Get.snackbar(
          'Contraseña Actualizada', 'La contresaña ha sido actualizada',
          snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED) {
          // ignore: null_aware_in_logical_operator
          if (!(recoveryData?.token == null)){
              Get.offAllNamed('/');
          }
        }
      });
      this._resetForm();
    } else
      Get.snackbar('Ocurrio un error', '');
  }

  void _resetForm() {
    currentPasswordController?.clear();
    newPasswordController?.clear();
    confirmPasswordController?.clear();

    update();
  }
}
