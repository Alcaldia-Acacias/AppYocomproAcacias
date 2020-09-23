import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  
  AnimationController controller;
  int page = 0;
  String urlImegenes = 'http://localhost:8000/imagenes';

  @override
  void onInit() {
    super.onInit();
  }

 void selectPage(int page) {
    this.page = page;
    if (page == 0) {
      controller.reset();
      controller.forward();
    }
    update(['bottomBar']);
  }
}
