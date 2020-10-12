import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/models/error.model.dart';
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

  final Usuario usuario;
  final UsuarioRepocitorio repositorio;
  ChangePasswordController({this.usuario, this.repositorio});

  void changePassword() async {
    if (this.comparePassword()) {
      final update = {"pass": newPasswordController.text};
      final response = await this
          .repositorio
          .updateUsuario(usuario.id, update, currentPasswordController.text);
      if (response is ErrorResponseUpdate) this._errorUpdate(response);
      if (response is UpdateResponse) this._updateOK(response);
    }
    if (!this.comparePassword())
      Get.snackbar('Error', 'las contraseñas no coinciden');
  }

  bool comparePassword() {
    if (newPasswordController.text == confirmPasswordController.text)
      return true;
    return false;
  }

  void _errorUpdate(ErrorResponseUpdate response) {
    if (response.error == 'PASS_INVALID')
      Get.snackbar('Contraseña Actual', 'La contresaña actual es invalidad');
  }

  void _updateOK(UpdateResponse response) {
    if (response.update) {
      Get.snackbar(
          'Contraseña Actualizada', 'La contresaña ha sido actulizada');
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
