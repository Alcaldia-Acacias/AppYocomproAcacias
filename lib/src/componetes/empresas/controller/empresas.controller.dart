import 'dart:io';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/calificacion.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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
  File image;
  ImageCapture imageCapture = Get.find<ImageCapture>();

  TextEditingController calificarController = TextEditingController();

  TextEditingController nombreProductoController = TextEditingController();
  TextEditingController descripcionProductoController = TextEditingController();
  TextEditingController precioProductoController = TextEditingController();

  FocusNode nombreProductoFoco = FocusNode();
  FocusNode descripcionProductoFoco = FocusNode();
  FocusNode precioProductoFoco = FocusNode();

  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  final uid = Uuid();

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

  void gotoMail(String email) async {
    final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: '$email');
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      print('Could not launch $_emailLaunchUri');
      throw 'Could not launch $_emailLaunchUri';
    }
  }

  void gotoWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  void goToWhatsapp(
    String telefono,
  ) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$telefono/?text=${Uri.parse('')}";
      } else {
        return "whatsapp://send?phone=$telefono&text=${Uri.parse('')}";
      }
    }
    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
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
    final idUsuario = box.read('id');
    if (extrellas > 0) {
      final response = await this.repositorio.calificarEmpresa(
          idUsuario, empresa.id, extrellas, calificarController.text);
      if (response is ErrorResponse) this._error(response.getError);
      if (response is ResponseEmpresa) {
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
    this._initCalificacion();
  }

  void deleteProducto(int idProducto, int index) async {
    final response = await repositorio.deleteProducto(idProducto);
    if (response is ErrorResponse) this._error(response.getError);
    if (response is ResponseEmpresa) {
      if (response.delete) this.productos.removeAt(index);
      Get.back();
      update();
    }
  }

  void getImage(String tipo) async {
    image = await imageCapture.getImage(tipo);
    if (!image.isNullOrBlank) {
      Get.back();
      update();
    }
    if (image.isNullOrBlank) {
      Get.back();
      Get.snackbar('No seleciono ninguna Imagen', '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _error(String error) {
    if (error == 'CALIFICACION_EXITS') {
      Get.back();
      Get.snackbar('Error', 'Ya calificaste esta empresa',
          snackPosition: SnackPosition.BOTTOM);
    }
    if (error == 'ERROR_DATA_BASE') {
      Get.back();
      Get.snackbar('Error', 'ocurrio un error',
          snackPosition: SnackPosition.BOTTOM);
    }
    if (error == 'Connection refused' || error == 'Network is unreachable') {
      if (Get.isDialogOpen) Get.back();
      Get.snackbar('No estas Conectdo', 'Conectate a Internet');
    }
  }

  void addProductoList(Producto producto) {
    productos.add(producto);
    update();
  }

  void updateProductoList(Producto producto) {
    final index = this
        .productos
        .indexWhere((productoList) => producto.id == productoList.id);
    this.productos[index] = producto;
    update();
  }

  void _initCalificacion() {
    this.startValue = List.generate(5, (index) => false);
    this.extrellas = 0;
    this.calificarController.clear();
  }
}
