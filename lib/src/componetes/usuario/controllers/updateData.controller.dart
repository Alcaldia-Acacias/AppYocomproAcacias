import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/models/error.model.dart';
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
  TextEditingController fechaController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();

  FocusNode nombreFoco = FocusNode();
  FocusNode fechaFoco = FocusNode();
  FocusNode usuarioFoco = FocusNode();
  DateTime fechaNacimiento;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    this._initialValues();
  }

  void updateData() async {
    if (this.formKey.currentState.validate()) {
      print(fechaNacimiento.toString());
      final update = {
        "correo": usuarioController.text,
        "nacimiento": fechaNacimiento.toString(),
        "nombre": nombreController.text
      };
      final response = await this.repositorio.updateUsuario(usuario.id, update);
      if (response is ErrorResponseUpdate) this._errorUpdate(response);
      if (response is UpdateResponse) this._updateOK(response);
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
    fechaController.text = this.formatFechaString(usuario.fechaNacimiento);
    fechaNacimiento = DateTime.parse(usuario.fechaNacimiento);
    update();
  }

  void _errorUpdate(ErrorResponseUpdate response) {
    print(response);
  }

  void _updateOK(UpdateResponse response) {
    print(response.update);
    final usuarioupdate = usuario.copyWith(
    email: usuarioController.text,
    nombre: nombreController.text,
    fechaNacimiento: fechaNacimiento.toString()
    );
    Get.find<HomeController>().updateUsuario(usuarioupdate);
    update();
  }
}
