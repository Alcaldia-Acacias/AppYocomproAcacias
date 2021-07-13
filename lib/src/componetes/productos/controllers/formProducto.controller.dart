import 'dart:io';

import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/imageFile.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:uuid/uuid.dart';
class FormProductoController extends GetxController {

   final bool updateProducto;
  List<ImageFile> imagenes = [];
  List<ImageFile> imagenesUpdate = [];
  ImageCapture imageCapture = ImageCapture();

  TextEditingController nombreController            = TextEditingController();
  TextEditingController descripcionController       = TextEditingController();
  TextEditingController precioController            = TextEditingController();
  TextEditingController descripcionOfertaController = TextEditingController();

  FocusNode nombreFoco             = FocusNode();
  FocusNode descripcionFoco        = FocusNode();
  FocusNode precioFoco             = FocusNode();
  FocusNode descripcionOfertaFoco  = FocusNode();

  ProductoState status = ProductoState.noAction;

  bool oferta = false;
  final formKey = GlobalKey<FormState>();
  final uid = Uuid();

  FormProductoController({this.updateProducto});
      
 
  void selectOferta(bool value){
    this.oferta = value;
    update(['formulario_producto']);
  }

  void getImage(String tipo, [bool cambiar = false, int index]) async {
    final imagecapture = await imageCapture.getImage(tipo);
    if (!imagecapture.isNullOrBlank) {
      final image = await CompressImagePlugin.getImage(imagecapture);
      if (cambiar)
        this._updateImage(image, index);
      else
        this._addImage(image);
    }
    if (imagecapture.isNullOrBlank) {
      status = ProductoState.notImage;
      Get.back();
    }
    Get.back();
    update(['formulario_producto']);
  }
  void _updateImage(File image, int index) async {
    if(!updateProducto)
    this.imagenes[index] = this.imagenes[index].copyWith(file: image);
    if(updateProducto){
      this.imagenesUpdate[index] = this.imagenesUpdate[index].copyWith(file: image,isaFile: true);
     await DefaultCacheManager().removeFile('${Get.find<HomeController>().urlImagenes}/galeria/${ this.imagenesUpdate[index].nombre}');
    }
  }
  void _addImage(File image) {
    if(!updateProducto)
    imagenes.add(ImageFile(file: image, nombre: '${uid.v4()}.jpg'));
    if(updateProducto)
    imagenesUpdate.add(ImageFile(file: image, nombre: '${uid.v4()}.jpg',isaFile: true));
  }
}

enum ProductoState { notImage, notAuthEmpresa, errorForm, noAction }