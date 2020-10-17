import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final HomeRepocitorio repositorio;
  HomeController({this.repositorio});
  AnimationController controller;
  int page = 0;
  String urlImegenes = 'http://10.0.2.2:8000/imagenes';
  Usuario usuario;

  @override
  void onInit() async {
    super.onInit();
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
}
