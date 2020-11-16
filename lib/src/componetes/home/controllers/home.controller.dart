import 'dart:io';

import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
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
  ImageCaptureAvatar imageCapture = ImageCaptureAvatar();
  
  List<Empresa> empresas = [];


  @override
  void onInit() async {
    super.onInit();
    if (GetPlatform.isAndroid)
      urlImegenes = 'http://165.22.239.235/imagenes';
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
    final imageCap = await imageCapture.getImage(tipo);
    if (!imageCap.isNullOrBlank) {
          image = await CompressImagePlugin.getImage(
          imageCap, imageCapture.height, imageCapture.width);
      final response =
          await repositorio.updateImagen(image.path, usuario.id);
      if (response is HomeResponse) {
        Get.back();
        imageCap.delete();
        update();
      }
      if (response is ErrorResponse) this._errorResponse(response.getError);
    }
    if (imageCap.isNullOrBlank) {
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
