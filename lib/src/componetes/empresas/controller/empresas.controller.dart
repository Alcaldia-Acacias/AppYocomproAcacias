import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/calificacion.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/producto.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpresasController extends GetxController {
  List<Empresa> empresas;
  final EmpresaRepositorio repositorio;
  EmpresasController({this.repositorio, this.empresas});
  Empresa empresa;
  PageController pageViewController;
  String titulo = "Información";
  int pagina = 0;
  List<Publicacion> publicaciones = [];
  List<Producto> productos = [];
  List<Calificacion> calificaciones = [];
  bool loading = true;
  List<bool> startValue = List.generate(5, (index) => false);
  int extrellas = 0;
  final box = GetStorage();

  @override
  void onInit() {
    pageViewController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    if (pageViewController.hasClients) pageViewController?.dispose();
    Get.find<PublicacionesController>().publicacionesByempresa = [];
    super.onClose();
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
        this.titulo = "Calificaciones";
        this.getCalificaciones(empresa.id);
        break;
      case 3:
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

  void getCalificaciones(int id) async {
    this.loading = true;
    this.calificaciones = await this.repositorio.getCalificacionesByEmpresa(id);
    this.loading = false;
    update();
  }

  void calificarEmpresa(int start) {
    this.startValue = List.generate(5, (index) => false);
    for (var i = 0; i <= start; i++) {
      this.startValue[i] = true;
    }
    this.extrellas = start + 1;
    update();
  }

  void addEmpresa(Empresa empresa) {
    this.empresas.insert(0, empresa);
    update(['empresas']);
  }

  void updateEmpresa(Empresa empresa) {
    final index =
        this.empresas.indexWhere((empresaItem) => empresaItem.id == empresa.id);
    this.empresas[index] = empresa;
    update(['empresas']);
  }

  void deleteEmpresa(int index, int id) async {
    final response = await this.repositorio.deleteEmpresa(id);
    if (response is ErrorResponse) {
      print(response.error.error);
    }
    if (response is ResponseEmpresa) {
      if (response.delete) {
        this.empresas.removeAt(index);
        Get.back();
        update(['empresas']);
      }
    }
  }

  void addCalificacionEmpresa() async {
    this.startValue = List.generate(5, (index) => false);
    final idUsuario = box.read('id');
    if (extrellas > 0) {
      final response = await this
          .repositorio
          .calificarEmpresa(idUsuario, empresa.id, extrellas);
      if (response is ErrorResponse) this._error(response.getError);
      if (response is ResponseEmpresa){
        Get.back();
        Get.snackbar('Tu calificacion $extrellas', 'Gracias por calificar',
          snackPosition: SnackPosition.BOTTOM);
        update();
      }
    }
    if (extrellas == 0) {
      Get.back();
      Get.snackbar('Error', 'Debes Calificar',
          snackPosition: SnackPosition.BOTTOM);
    }

  }

  void _error(String error) {
    if (error == 'CALIFICACION_EXITS') {
      Get.back();
      Get.snackbar('Error', 'Ya calificaste esta empresa',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
