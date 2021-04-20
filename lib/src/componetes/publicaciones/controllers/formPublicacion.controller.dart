import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/imageFile.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/reponse.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FormPublicacionesController extends GetxController {
  final PublicacionesRepositorio repositorio;
  final bool updatePublicacion;
  final Publicacion publicacion;
  FormPublicacionesController(
      {this.repositorio, this.updatePublicacion, this.publicacion});

  TextEditingController publicacionController = TextEditingController();
  List<ImageFile> imagenes = [];
  List<ImageFile> imagenesUpdate = [];
  ImageCapture imageCapture = ImageCapture();
  List<Empresa> empresas;
  Empresa empresa;
  PublicacionState status = PublicacionState.noAction;

  final formKey = GlobalKey<FormState>();
  final uid = Uuid();

  @override
  void onInit() {
    if(updatePublicacion){
       publicacionController.text = publicacion.texto;
       imagenesUpdate = publicacion.imagenes.map<ImageFile>((imagen) => ImageFile(nombre: imagen,isaFile : false)).toList();
       empresa = publicacion.empresa;
    }
    this.empresas = Get.find<HomeController>().usuario.empresas;
    super.onInit();
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
      status = PublicacionState.notImage;
      Get.back();
    }
    Get.back();
    update(['formulario_publicaciones']);
  }

  void selectEmpresa(Empresa empresa) {
    Get.back();
    if (empresa.estado) {
      this.empresa = empresa;
      update(['formulario_publicaciones']);
    } else {
      status = PublicacionState.notAuthEmpresa;
      update(['formulario_publicaciones']);
    }
  }

  void addPublicacion() async {
    final response =
        await repositorio.addPublicacion(this._getPublicacion(), imagenes);
    if (response is ResponsePublicacion) this._addPublicacionList(response.id);
    if (response is ErrorResponse) print(response.getError);
  }
  void updatePublicaciones(int index) async {
    final response =
        await repositorio.updatePublicacion(this._getUpdatePublicacion(), imagenesUpdate);
    if (response is ResponsePublicacion) this._updatePublicacionList(index);
    if (response is ErrorResponse) print(response.getError);
  }

  void _addImage(File image) {
    if(!updatePublicacion)
    imagenes.add(ImageFile(file: image, nombre: '${uid.v4()}.jpg'));
    if(updatePublicacion)
    imagenesUpdate.add(ImageFile(file: image, nombre: '${uid.v4()}.jpg',isaFile: true));
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
        comentarios: [],
        imagenes: imagenes.map<String>((imagen) => imagen.nombre).toList(),
        megusta: false,
        editar: true);
  }
  Publicacion _getUpdatePublicacion() {
    return Publicacion(
        id: publicacion.id,
        texto: publicacionController.text,
        empresa: empresa,
        imagenes: imagenesUpdate.map<String>((imagen) => imagen.nombre).toList(),
    );
  }

  void _updateImage(File image, int index) async {
    if(!updatePublicacion)
    this.imagenes[index] = this.imagenes[index].copyWith(file: image);
    if(updatePublicacion){
      this.imagenesUpdate[index] = this.imagenesUpdate[index].copyWith(file: image,isaFile: true);
     await DefaultCacheManager().removeFile('${Get.find<HomeController>().urlImagenes}/galeria/${ this.imagenesUpdate[index].nombre}');
    }

  }

  void _addPublicacionList(int id) {
    Get.find<PublicacionesController>()
        .addPublicacion(this._getPublicacion(id));
    Get.back();
  }

  void _updatePublicacionList(int index) {
    Get.find<PublicacionesController>()
        .updatePublicacion(this._getUpdatePublicacion(),index);
    Get.back();
  }
}

enum PublicacionState { notImage, notAuthEmpresa, errorForm, noAction }
