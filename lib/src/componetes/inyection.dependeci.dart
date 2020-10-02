import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/data/categorias.repositorio.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'login/controller/login.controller.dart';

class Dependecias {

  static init() {
    
  Get.put(LoginController());
  Get.put(HomeController());
  Get.lazyPut(()=>Dio(BaseOptions(baseUrl: 'http://localhost:8000')));
  Get.put(PublicacionesController(repositorio: PublicacionesRepositorio()));
  Get.put(CategoriasController(repositorio: CategoriaRepositorio()));

  }
}
