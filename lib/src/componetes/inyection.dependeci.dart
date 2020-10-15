import 'dart:io';

import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/login/data/login.repositorio.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'login/controller/login.controller.dart';

class Dependecias {
 
  static init() {

  final box = GetStorage();
  final token = box.read('token');

  Get.lazyPut(()=>LoginController(repositorio:LoginRepositorio()));
  Get.lazyPut(()=>Dio(
                  BaseOptions(
                      baseUrl: 'http://localhost:8000',
                      contentType: Headers.jsonContentType,
                      headers:{HttpHeaders.authorizationHeader: 'Bearer $token'}
                  )
  ));
  Get.put(HomeController(repositorio:HomeRepocitorio()));

  
  

  }
}
