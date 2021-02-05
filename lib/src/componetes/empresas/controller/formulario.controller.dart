import 'dart:io';

import 'package:comproacacias/src/componetes/categorias/models/categoria.model.dart';
import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/widgets/dialogAlert.widget.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class FormEmpresaController extends GetxController {
  final EmpresaRepositorio repositorio;
  final bool actualizar;
  final Empresa empresa;
  FormEmpresaController(
      {this.repositorio, this.actualizar = false, this.empresa});

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController latitudController = TextEditingController();
  TextEditingController longitudController = TextEditingController();
  TextEditingController nitController = TextEditingController();

  FocusNode nombreFoco = FocusNode();
  FocusNode descripcionFoco = FocusNode();
  FocusNode direccionFoco = FocusNode();
  FocusNode telefonoFoco = FocusNode();
  FocusNode whatsappFoco = FocusNode();
  FocusNode emailFoco = FocusNode();
  FocusNode webFoco = FocusNode();
  FocusNode latitudFoco = FocusNode();
  FocusNode longitudFoco = FocusNode();
  FocusNode nitFoco = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentPage = 0;
  String titulo = 'Escoje tu Logo';
  final box = GetStorage();
  final picker = ImagePicker();
  File image;
  PickedFile pickedFile;
  int idCategoria;
  String urlImagen = '';
  ImageCapture imageCapture = Get.find<ImageCapture>();

  @override
  void onInit() {
    if (this.actualizar) {
      nombreController.text = empresa.nombre;
      descripcionController.text = empresa.descripcion;
      direccionController.text = empresa.direccion;
      telefonoController.text = empresa.telefono;
      whatsappController.text = empresa.whatsapp;
      emailController.text = empresa.email;
      webController.text = empresa.web;
      latitudController.text = empresa.latitud;
      longitudController.text = empresa.longitud;
      nitController.text = empresa.nit;
      urlImagen = empresa.urlLogo;
      idCategoria = empresa.idCategoria;
    }
   
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changePage(int page) {
    if (page < 0) page = 0;
    if (page > 4) page = 4;
    switch (page) {
      case 0:
        this.titulo = 'Escoge tu Logo';
        break;
      case 1:
        this.titulo = 'Datos Básicos';
        break;
      case 2:
        this.titulo = 'Datos de Contacto';
        break;
      case 3:
        this.titulo = 'Categoria';
        break;
      case 4:
        this.titulo = 'Ubicación';
        break;
    }
    this.currentPage = page;
    update(['formulario_empresa']);
  }

  void addEmpresaSubmit() async {
    if (this._formValid() && image?.path != null && !this.idCategoria.isNull) {
      final idUsuario = box.read('id');
      this._openDialogo('Agregando Empresa');
      final response = await repositorio.addEmpresa(
          this._getEmpresa(), idUsuario, image?.path);
      if (response is ErrorResponse) this._errorMessaje(response.getError);
      if (response is ResponseEmpresa) this._addEmpresa(response);
    } else {
      Get.snackbar('Faltan Datos', 'Faltan campos requeridos');
    }
  }

  void updateEmpresaSubmit() async {

    if (this._formValid() && !this.idCategoria.isNull) {
      final idUsuario = box.read('id');
       this._openDialogo('Actulizando Empresa');
      final response = await repositorio.updateEmpresa(
          this._getEmpresa(id: empresa.id), idUsuario,
          path: image?.path);
      if (response is ErrorResponse) this._errorMessaje(response.getError);
      if (response is ResponseEmpresa) this._updateEmpresa(response);
    }
  }

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitudController.text = position.latitude.toString();
      longitudController.text = position.longitude.toString();
      update(['formulario_empresa']);
    } catch (e) {
      Get.snackbar('Permiso denegado', 'pulse aqui para habilitar',
          duration: Duration(seconds: 10), onTap: (snack) async {
        await Geolocator.openAppSettings();
      });
    }
  }

  void getImage(String tipo) async {
    final imagecapture = await imageCapture.getImage(tipo);
    if (!imagecapture.isNullOrBlank) {
       image =  await CompressImagePlugin.getImage(imagecapture);
      Get.back();
      update(['formulario_empresa']);
    }
    if (imagecapture.isNullOrBlank) {
      Get.back();
      Get.snackbar('No seleciono ninguna Imagen', '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool _formValid() => this.formKey.currentState.validate();

  Empresa _getEmpresa({int id}) => Empresa(
      id: id ?? null,
      idCategoria: this.idCategoria,
      nombre: nombreController.text,
      nit: nitController.text,
      descripcion: descripcionController.text,
      direccion: direccionController.text,
      email: emailController.text,
      telefono: telefonoController.text,
      web: webController.text,
      whatsapp: whatsappController.text,
      urlLogo: id != null ? '${id}_logo_empresa.jpg' : '',
      urlPortada: '',
      latitud: latitudController.text,
      longitud: longitudController.text,
      popular: 0,
      estado: false
      );

  void getCategoria(Categoria categoria) {
    this.idCategoria = categoria.id;
    Get.snackbar('Escogiste', '${categoria.nombre}');
    update(['formulario_empresa']);
  }

  void _errorMessaje(error) {
    if (error == 'Connection refused')
      Get.snackbar('No estas Conectdo', 'Conectate a Internet');
    if (error == 'EMPRESA_EXIST')
      Get.snackbar('La Empresa ya existe', 'verifique el nit de la empresa');
     Get.back();
  }

  void _addEmpresa(ResponseEmpresa response) {
    Get.find<EmpresasController>()
        .addEmpresa(this._getEmpresa(id: response.id));
    Get.back();
  }

  void _updateEmpresa(ResponseEmpresa response) async {
    if (response.update) {
      Get.find<EmpresasController>()
          .updateEmpresa(this._getEmpresa(id: empresa.id));
      Get.back();
    }
  }

  void _openDialogo(String texto){
    Get.dialog(
     AlertDialogLoading(titulo: texto)
    ).whenComplete(() => Get.back());
  }
}
