import 'dart:io';

import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/categoriaProducto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/response.producto.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/imageFile.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:uuid/uuid.dart';

class FormProductoController extends GetxController {
  final bool updateProducto;
  final ProductosRepositorio repositorio;

  List<ImageFile> imagenes = [];
  List<ImageFile> imagenesUpdate = [];
  List<CategoriaProducto> categorias = [];
  ImageCapture imageCapture = ImageCapture();

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionOfertaController = TextEditingController();

  FocusNode nombreFoco = FocusNode();
  FocusNode descripcionFoco = FocusNode();
  FocusNode precioFoco = FocusNode();
  FocusNode descripcionOfertaFoco = FocusNode();

  ProductoState status = ProductoState.noAction;

  List<Empresa> empresas;
  Empresa empresaSelecionada;
  CategoriaProducto categoriaSelecionada;
  bool oferta = false;
  final formKey = GlobalKey<FormState>();
  final uid = Uuid();

  FormProductoController({this.updateProducto, this.repositorio});

  @override
  void onInit() {
    this.empresas = Get.find<HomeController>().usuario.empresas;
    if(categorias.length == 0){
      this._getcategorias();
    }
    super.onInit();
  }

  void selectOferta(bool value) {
    this.oferta = value;
    update(['formulario_producto']);
  }

  void selectCategoria(CategoriaProducto categoria) {
    this.categoriaSelecionada = categoria;
    update(['formulario_producto']);
  }

  void selectEmpresa(Empresa empresa) {
    this.empresaSelecionada = empresa;
    update(['formulario_producto']);
  }

  void addProducto() async {
    if (this._validate()) {
          final response = await this
              .repositorio
              .addProducto(this._getProducto(), empresaSelecionada.id, imagenes);
          print(response);
          if(response is ResponseProducto) print('${response.idProducto}');
          if(response is ErrorResponse)    print('${response.getError}');
    }
    else print('Error en los datos');
 }
    
 Producto _getProducto([int id]) {
   return Producto(
       id: id ?? 0,
       nombre: nombreController.text,
       descripcion: descripcionController.text,
       descripcionOferta: descripcionOfertaController.text,
       precio: int.parse(precioController.text),
       imagenes: imagenes.map<String>((imagen) => imagen.nombre).toList(),
       oferta: this.oferta,
       categoria: categoriaSelecionada
       );
       
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
   if (!updateProducto)
     this.imagenes[index] = this.imagenes[index].copyWith(file: image);
   if (updateProducto) {
     this.imagenesUpdate[index] =
         this.imagenesUpdate[index].copyWith(file: image, isaFile: true);
     await DefaultCacheManager().removeFile(
         '${Get.find<HomeController>().urlImagenes}/galeria/${this.imagenesUpdate[index].nombre}');
   }
 }
 void _addImage(File image) {
   if (!updateProducto)
     imagenes.add(ImageFile(file: image, nombre: '${uid.v4()}.jpg'));
   if (updateProducto)
     imagenesUpdate.add(
         ImageFile(file: image, nombre: '${uid.v4()}.jpg', isaFile: true));
 }
    
 void _getcategorias() async {
   final response = await repositorio.getCategorias();
   if(response is ResponseProducto){
     this.categorias = response.categorias;
     update();
   }
   if(response is ErrorResponse) print(response.getError);
 }
    
 bool _validate() {
   if(!this.formKey.currentState.validate()){
     Get.snackbar('Faltan Datos','Llena los datos requeridos');
     return false;
   }
   if(empresaSelecionada.isNullOrBlank && categoriaSelecionada.isNullOrBlank){
     Get.snackbar('Faltan Datos','Escoje una Empresa o Categoria');
     return false;
   }
   if(imagenes.length < 1){
     Get.snackbar('Faltan Datos','Escoje al menos una imagen');
     return false;
   }
   return true;
 }
   
}

enum ProductoState { notImage, notAuthEmpresa, errorForm, noAction }
