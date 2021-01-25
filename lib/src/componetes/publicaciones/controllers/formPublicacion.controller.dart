import 'dart:io';

import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/imageFile.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/reponse.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/widgets/dialogAlert.widget.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FormPublicacionesController extends GetxController {
  final PublicacionesRepositorio repositorio;
  FormPublicacionesController({this.repositorio});

  TextEditingController publicacionController = TextEditingController();
  List<ImageFile> imagenes = [];
  ImageCapture imageCapture = ImageCapture();
  List<Empresa> empresas;
  Empresa empresa;

  final formKey = GlobalKey<FormState>();
  final uid = Uuid();

  @override
  void onInit() {
    this.empresas = Get.find<HomeController>().usuario.empresas;
    super.onInit();
  }

  void getImage(String tipo, [bool cambiar = false, int index]) async {
    final imagecapture = await imageCapture.getImage(tipo);
    final image = await CompressImagePlugin.getImage(imagecapture);
    if (!imagecapture.isNullOrBlank) {
      if (cambiar)
        this._updateImage(image, index);
      else
        this._addImage(image);
      Get.back();
      update();
    }
    if (imagecapture.isNullOrBlank) {
      Get.back();
      Get.snackbar('No seleciono ninguna Imagen', '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void selectEmpresa(Empresa empresa) {
    if(empresa.estado){
    this.empresa = empresa;
    Get.back();
    update();
    }
    else {
      Get.back();
      Get.snackbar('La Empresa no esta autorizada', 
      'por favor espera mientras la administracion activa esta funcion');
    }
  }

  void addPublicacion() async {
    if (this.formKey.currentState.validate() &&
        imagenes.length > 0 &&
        empresa.id > 0) {
      this._openDialog();
      final response =
          await repositorio.addPublicacion(this._getPublicacion(), imagenes);
      if (response is ResponsePublicacion) this._addPublicacionList(response.id);
      if (response is ErrorResponse) print(response.getError);
    } else
      Get.snackbar('Faltan Datos', '');
  }

  void _addImage(File image) {
    imagenes.add(ImageFile(file: image, nombre: '${uid.v4()}.jpg'));
  }

  Publicacion _getPublicacion([int id]) {
    return Publicacion(
        id: id ?? null,
        texto: publicacionController.text,
        empresa: empresa,
        fecha: DateTime.now().toString(),
        numeroComentarios: 0,
        likes: 0,
        usuariosLike: [],
        imagenes: imagenes.map<String>((imagen) => imagen.nombre).toList(),
        megusta : false 
        );
  }

  void _updateImage(File image, int index) {
    this.imagenes[index] = this.imagenes[index].copyWith(file: image);
  }
  void _addPublicacionList(int id) {
    Get.find<PublicacionesController>().addPublicacion(this._getPublicacion(id));
    Get.back();
  }

  void _openDialog(){
    Get.dialog(
      AlertDialogLoading(titulo: 'Publicando...'),
      barrierDismissible: false
    ).whenComplete(() => Get.back());
  }
}
