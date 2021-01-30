import 'dart:io';

import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:comproacacias/src/plugins/google_sing_in.dart';

class HomeController extends GetxController {
  
  final HomeRepocitorio repositorio;
  final String urlImagenes;
  HomeController({this.repositorio,this.urlImagenes});
  AnimationController controller;
  int page = 0;
  Usuario usuario;
  File image;
  ImageCaptureAvatar imageCapture = ImageCaptureAvatar();
  
  List<Empresa> empresas = [];


  @override
  void onInit() async {
    super.onInit();
    if (this.usuario.isNullOrBlank){
        this.usuario = await repositorio.getUsuario();
        this.registroActividad();
        this.updateUsuario(usuario);
    }
   
    
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
      default:
    }
    update(['bottomBar']);
  }

  void logOut() async {
    await GetStorage().erase();
    await googleLogOut();
    await FacebookAuth.instance.logOut();
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

  void registroActividad() async {
     final response = await repositorio.registroActividad(this.usuario.id);
     if(response is ErrorResponse) print(response.error);
     if(response is HomeResponse)  print(response);
  }



  
}
