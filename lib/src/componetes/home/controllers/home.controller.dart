import 'dart:io';

import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final HomeRepocitorio repositorio;
  HomeController({this.repositorio});
  AnimationController controller;
  int page = 0;
  String urlImegenes;
  Usuario usuario;
  File image;
  ImageCapture imageCapture = Get.find<ImageCapture>();

  @override
  void onInit() async {
    super.onInit();
    if (GetPlatform.isAndroid)
      urlImegenes = 'http://10.0.2.2:8000/imagenes';
    else
      urlImegenes = 'http://localhost:8000/imagenes';
    if (this.usuario.isNullOrBlank)
      this.usuario = await repositorio.getUsuario();
  }

  void updateUsuario(Usuario usuario) {
    this.usuario = usuario;
    update();
  }

  void selectPage(int page) {
    this.page = page;
    switch (page) {
      case 0:
        controller?.reset();
        controller?.forward();
        break;
      case 2:
        print('object');
        break;
      default:
    }
    update(['bottomBar']);
  }

  void logOut() async {
    await GetStorage().erase();
    Get.offAllNamed('/');
  }

  void getImage(String tipo) async {
    image = await imageCapture.getImage(tipo);
    if (!image.isNullOrBlank) {
      final response = await repositorio.updateImagen(image.path, usuario.id);
      if (response is UpdateImageResponse) {
        Get.back();
        update();
      }
      if (response is ErrorResponse) this._errorResponse(response.getError);
    }
    if (image.isNullOrBlank) {
      Get.back();
      Get.snackbar('No seleciono ninguna Imagen', '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _errorResponse(String error) {
    if (error == 'Connection refused')
      Get.snackbar('No estas Conectdo', 'Conectate a Internet');
  }
}
