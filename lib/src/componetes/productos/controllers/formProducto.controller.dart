import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
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
import 'package:uuid/uuid.dart';

class FormProductoController extends GetxController {

  final bool updateProducto;
  final ProductosRepositorio repositorio;
  final Producto productoUpdate;
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

  FormProductoController({this.updateProducto, this.repositorio,this.productoUpdate});

  @override
  void onInit() async {
    this.empresas = Get.find<HomeController>().usuario.empresas;
    this.categorias = Get.find<ProductosController>().categorias;
   
    if(updateProducto){
      nombreController.text = productoUpdate.nombre;
      descripcionController.text = productoUpdate.descripcion;
      precioController.text = productoUpdate.precio.toString();
      oferta = productoUpdate.oferta;
      descripcionOfertaController.text = productoUpdate.descripcionOferta;
      this.empresaSelecionada = productoUpdate.empresa;
      this. categoriaSelecionada = productoUpdate.categoria;
      this.imagenesUpdate = productoUpdate.imagenes.map<ImageFile>((imagen) => ImageFile(nombre: imagen,isaFile: false)).toList();
    }
    super.onInit();
  }

  void selectOferta(bool value) {
    this.oferta = value;
    if(updateProducto)descripcionOfertaController.text = '';
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
      if(response is ResponseProducto) {
        Get.find<ProductosController>().addToListProducto(response.producto);
        Get.back();
      }
      if(response is ErrorResponse){
        Get.snackbar('Error', 'Ocurrio un error');
      }
    }
    else print('Error en los datos');
 }

  void updateProductos(int id) async {
    if (this._validate()) {
      final producto = this._getProducto(id,true);
      final response = await this
          .repositorio
          .updateProducto(producto, empresaSelecionada.id, imagenesUpdate);
      if(response is ResponseProducto) {
        Get.find<ProductosController>().updateToListProducto(producto,id);
        Get.back();
      }
      if(response is ErrorResponse){
        Get.snackbar('Error', 'Ocurrio un error');
      }
    }
    else print('Error en los datos');
 }
    
 Producto _getProducto([int id,bool update = false]) {
   return Producto(
       id                : id ?? 0,
       nombre            : nombreController.text,
       descripcion       : descripcionController.text,
       descripcionOferta : descripcionOfertaController.text,
       precio            : int.parse(precioController.text),
       imagenes          :  update 
                            ? imagenesUpdate.map<String>((imagen) => imagen.nombre).toList()
                            : imagenes.map<String>((imagen) => imagen.nombre).toList(),
       oferta            : this.oferta,
       categoria         : categoriaSelecionada,
       empresa           : empresaSelecionada
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
     await CachedNetworkImage.evictFromCache(
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
        
 bool _validate() {
   if(!this.formKey.currentState.validate()){
     Get.snackbar('Faltan Datos','Llena los datos requeridos');
     return false;
   }
   if(empresaSelecionada.isNullOrBlank && categoriaSelecionada.isNullOrBlank){
     Get.snackbar('Faltan Datos','Escoge una Empresa o Categoria');
     return false;
   }
   if(!updateProducto && imagenes.length < 1){
     Get.snackbar('Faltan Datos','Escoge al menos una imagen');
     return false;
   }
   return true;
 }

   
}

enum ProductoState { notImage, notAuthEmpresa, errorForm, noAction }
