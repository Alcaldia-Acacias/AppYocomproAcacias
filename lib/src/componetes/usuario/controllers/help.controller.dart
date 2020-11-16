import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/models/reporte.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/updateresponse.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpController extends GetxController {
  final UsuarioRepocitorio repocitorio;
  final int idUsuario;
  HelpController({this.repocitorio, this.idUsuario});
  int valueRadio = -1;
  String option;
  TextEditingController mensaje = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void changeRadio(int value) {
    this.valueRadio = value;
    switch (value) {
      case 0:
        this.option = 'funcionamiento';
        break;
      case 1:
        this.option = 'contenido inadecuado';
        break;
      case 2:
        this.option = 'suplantacion';
        break;
      case 2:
        this.option = 'otro motivo';
        break;
    }
    update();
  }

  sendReporte() async {
    if (formKey.currentState.validate() && valueRadio != -1) {
      final reporte = Reporte(
          idUsuario: idUsuario, motivo: valueRadio, detalle: mensaje.text);
      final response = await repocitorio.sendReporte(reporte);
      if (response is UsuarioResponse) print(response.reporte);
      if (response is ErrorResponse) print(response.getError);
    }
    else Get.snackbar('Faltan Datos', '');
  }

  void gotoCall(String telefono) async {
    final url = 'tel:+57$telefono';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  void gotoMail(String email) async {
    final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: '$email');
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      print('Could not launch $_emailLaunchUri');
      throw 'Could not launch $_emailLaunchUri';
    }
  }
}
