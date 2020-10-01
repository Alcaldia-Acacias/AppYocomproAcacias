import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/producto.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpresasController extends GetxController {
  final EmpresaRepositorio repositorio;

  EmpresasController({this.repositorio});
  Empresa empresa;
  PageController pageViewController;
  String titulo = "Información";
  int pagina = 0;
  List<Publicacion> publicaciones = [];
  List<Producto> productos = [];
  bool loading = true;
  List<bool> startValue = List.generate(5, (index) => false);


  @override
  void onReady() {
    pageViewController = PageController(initialPage: 0);
    super.onReady();
   }

  
  @override
  Future<void> onClose(){
     print('close');
    pageViewController?.dispose();
    Get.find<PublicacionesController>().publicacionesByempresa = [];
    return  super.onClose();
  }

  void getTitulo(int page) async {
    this.pagina = page;
    switch (page) {
      case 0:
        this.titulo = "Informacion";
        break;
      case 1:
        this.titulo = "Publicaciones";
        this.getPublicaciones(empresa.id);
        break;
      case 2:
        this.titulo = "Vitrina";
        this.getProductosByEmpresa(empresa.id);
        break;
      default:
        break;
      
    }
    update(['empresa']);
  }

  void changePage(String direccion) {
    if (direccion == 'adelante')
      pageViewController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    if (direccion == 'atras')
      pageViewController.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void gotoMap(String latitud, String longitud) async {
    final url =
        "https://www.google.com/maps/search/?api=1&query=${empresa.latitud},${empresa.longitud}";
    final String encodedURl = Uri.encodeFull(url);
    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
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
  void getPublicaciones(int id) async {
    Get.find<PublicacionesController>().getPublicacionesByempresa(id);
  }

  void getProductosByEmpresa(int id) async {
    this.loading = true;
    this.productos = await this.repositorio.getProductosByEmpresa(id);
    this.loading = false;
    update();
  }

  void calificarEmpresa(int start){
    this.startValue = List.generate(5, (index) => false);
    for (var i = 0; i <= start; i++) {
        this.startValue[i] = true;
    }
    update();
  
  }
}
