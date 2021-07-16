import 'dart:io';
import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
//import 'package:comproacacias/src/componetes/productos/models/response.producto.dart';
//import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:uuid/uuid.dart';

class ProductosController extends GetxController {
  final ProductosRepositorio repositorio;
  final int idEmpresa;
  final Producto producto;
  final bool actualizar;

  ProductosController(
      {this.repositorio,
      this.idEmpresa,
      this.producto,
      this.actualizar = false});

  File image;
  ImageCapture imageCapture = Get.find<ImageCapture>();

  TextEditingController calificarController = TextEditingController();

 /*  TextEditingController nombreProductoController = TextEditingController();
  TextEditingController descripcionProductoController = TextEditingController();
  TextEditingController precioProductoController = TextEditingController(); */

/*   FocusNode nombreProductoFoco = FocusNode();
  FocusNode descripcionProductoFoco = FocusNode();
  FocusNode precioProductoFoco = FocusNode(); */
  
  /* ImageSelect imageSelect;
  final formKey = GlobalKey<FormState>();
  final uid = Uuid();
 */

  @override
  void onInit() {
    //if (actualizar) this.initUpdateProducto();
    super.onInit();
  }

  /* Producto _getProducto() {
    return Producto(
        id: actualizar ? producto.id : null,
        nombre: nombreProductoController.text,
        descripcion: descripcionProductoController.text,
        imagen: this._getimageUrl(),
        precio: int.parse(precioProductoController.text));
  } */

  void _addProductoList(int idProducto, Producto producto) {
    final newProducto = producto.copyWith(id: idProducto);
    Get.find<EmpresasController>().addProductoList(newProducto);
    //this._resetFormProductos();
    Get.back();
  }

  /* void addProducto() async {
    if (formKey.currentState.validate()) {
      final producto = this._getProducto();
      final response = await repositorio.addProducto(producto, idEmpresa,
          path: this._fileExist());
      if (response is ErrorResponse) this._error(response.getError);
      if (response is ResponseProducto)
        this._addProductoList(response.idProducto, producto);
    } else
      Get.snackbar('Error', 'Faltan Datos');
  } */

  /* void updateProducto() async {
    if (formKey.currentState.validate()) {
      final producto = this._getProducto();
      final response = await repositorio.updateProducto(producto, idEmpresa,
          path: this._fileExist());
      if (response is ErrorResponse) this._error(response.getError);
      if (response is ResponseProducto) this._updateProductoList(producto);
    } else
      Get.snackbar('Error', 'Faltan Datos');
  } */

 /*  void updateOrAddProducto(bool update) {
    if (update)
      this.updateProducto();
    else
      this.addProducto();
  } */

 /*  void _resetFormProductos() {
    nombreProductoController.text = '';
    descripcionProductoController.text = '';
    precioProductoController.text = '';
    image.delete();
  } */

  String _fileExist() {
    if (image?.path == null)
      return null;
    else
      return image?.path;
  }

  void _error(String error) {
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

  void getImage(String tipo) async {
    final imagecapture = await imageCapture.getImage(tipo);
    if (!imagecapture.isNullOrBlank) {
      image = await CompressImagePlugin.getImage(imagecapture);
      Get.back();
      update();
    }
    if (imagecapture.isNullOrBlank) {
      Get.back();
      Get.snackbar('No seleciono ninguna Imagen', '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /* void initUpdateProducto() async {
    nombreProductoController.text = producto.nombre;
    descripcionProductoController.text = producto.descripcion;
    precioProductoController.text = producto.precio.toString();
    if (image?.path != null) await image.delete();
  } */

 /*  ImageSelect selectImage() {
    if (actualizar && producto.imagen != '' && image?.path == null)
      return ImageSelect.URL;
    if (actualizar && producto.imagen != '' && image?.path != null)
      return ImageSelect.PATH_IMAGE;
    if (actualizar && producto.imagen == '' && image?.path == null)
      return ImageSelect.NO_IMAGE;
    if (actualizar && producto.imagen == '' && image?.path != null)
      return ImageSelect.PATH_IMAGE;
    if (!actualizar && image?.path != null) return ImageSelect.PATH_IMAGE;
    if (!actualizar && image?.path == null) return ImageSelect.NO_IMAGE;
    return null;
  } */

  /* String _getimageUrl() {
    if (image?.path == null && actualizar) return producto.imagen;
    if (image?.path == null && !actualizar) return '';
    if (image?.path != null) return '${uid.v4()}.jpg';
    return null;
  } */

  void _updateProductoList(Producto producto) {
    Get.find<EmpresasController>().updateProductoList(producto);
    Get.back();
  }
}

enum ImageSelect { NO_IMAGE, URL, PATH_IMAGE }
