import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/models/updateresponse.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateDataController extends GetxController {
  
  final Usuario usuario;
  final UsuarioRepocitorio repositorio;
  UpdateDataController({this.usuario, this.repositorio});

  TextEditingController nombreController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();

  FocusNode nombreFoco = FocusNode();
  FocusNode usuarioFoco = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    this._initialValues();
  }

  void updateData() async {
    if (this.formKey.currentState.validate()) {
      final update = {
        "correo": usuarioController.text,
        "nombre": nombreController.text
      };
      final response = await this.repositorio.updateUsuario(usuario.id, update);
      if (response is ErrorResponse) this._errorUpdate(response.getError);
      if (response is UsuarioResponse) this._updateOK(response);
    }
  }

  String formatFecha(DateTime fecha) {
    if (fecha != null) return DateFormat("dd MMMM 'del' yyyy").format(fecha);
    return '';
  }

  String formatFechaString(String fecha) {
    if (fecha != null)
      return DateFormat("dd MMMM 'del' yyyy").format(DateTime.parse(fecha));
    return '';
  }

  void _initialValues() {
    usuarioController.text = usuario.email;
    nombreController.text = usuario.nombre;
    update();
  }

  void _errorUpdate(String error) {
    print(error);
  }

  void _updateOK(UsuarioResponse response) {
    if (response.update) {
      final usuarioupdate = usuario.copyWith(
        email: usuarioController.text,
        nombre: nombreController.text,
      );
      Get.find<HomeController>().updateUsuario(usuarioupdate);
      Get.snackbar('Datos Actulizados', '');
      update();
    } else
      Get.snackbar('Ocurrio un error', '');
  }
}
