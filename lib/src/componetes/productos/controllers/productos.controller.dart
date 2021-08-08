import 'dart:io';

import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/categoriaProducto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/pedido.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/response.producto.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';


class ProductosController extends GetxController {
  
  final ProductosRepositorio repositorio;

  ProductosController({this.repositorio});

  Producto productoSelecionado;

  List<Producto> productos = [];
  List<Producto> allProductos = [];
  List<Producto> allWithOfertaProductos = [];
  List<Producto> productosByEmpresa = [];
  List<CategoriaProducto> categorias = [];
  List<Pedido> pedidos = [];

  int _pagina = 0;
  int _paginaOferta = 0;
  int _paginaFilter = 0;
  int cantidadProducto = 1;
  int indexStackPedidos = 0;
  
  bool loading  = false;
  
  Usuario usuario;
  CategoriaProducto categoriaSelecionada;
  ScrollController controller = ScrollController(initialScrollOffset: 0);
  ScrollController controllerOferta = ScrollController(initialScrollOffset: 0);

  TextEditingController controllerObservacion = TextEditingController();

  @override
  void onInit() {

    final idUsuario = GetStorage().read('id');
    this._getProductosByUsuario(idUsuario);
     if(categorias.length == 0){
      this._getcategorias();
    }
    this.controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent){
          if(this.categoriaSelecionada.nombre == 'Todos'){
            _paginaFilter = 0;
            _pagina = 0;
            this.getAllProductos();
          }
          else {
            _paginaFilter++;
            final productos = await this._getProductosByCategoria(categoriaSelecionada.id);
            this.allProductos.addAll(productos);
            update(['productos']);
          }    
      }
    });
    this.controllerOferta.addListener(() {
      if (controllerOferta.position.pixels == controllerOferta.position.maxScrollExtent)
         this.getAllProductos(oferta :true);
    });
    this.getAllProductos();
    this.getAllProductos(oferta : true);
    super.onInit();
  }

 void deleteProducto(int idProducto) async {
    final response = await repositorio.deleteProducto(idProducto);
    if(response is ResponseProducto){
       if(response.delete)
       this._deleteProductoList(idProducto);
    }
    if(response is ErrorResponse){
      Get.snackbar('Error', '');
    }
  }
  void addToListProducto(Producto producto) async{
   this.productos.insert(0,producto);
   update(['productos']);
 }

  void updateToListProducto(Producto producto,int id) async{
   final index = this.productos.indexWhere((producto) => producto.id == id);
   this.productos[index] = this.productos[index].copyWith(
     empresa           : producto.empresa,
     categoria         : producto.categoria,
     imagenes          : producto.imagenes,
     nombre            : producto.nombre,
     oferta            : producto.oferta,
     descripcion       : producto.descripcion,
     descripcionOferta : producto.descripcionOferta,
     precio            : producto.precio
   );
   update(['productos']);
 }

  Future<void> getAllProductos({bool oferta = false}) async {
    final response = await repositorio.getAllProductos(_pagina,oferta: oferta);
    if(response is ResponseProducto){
      if(oferta){
        this.allWithOfertaProductos.addAll(response.productos);
        _paginaOferta++;
        }
      if(!oferta && this._pagina > 0){
         this.allProductos.addAll(response.productos);
        _pagina ++;
      }
      if(!oferta && this._pagina  == 0){
         this.allProductos = response.productos;
        _pagina ++;
      }
      if(_pagina > 1 || _paginaOferta > 1)
      update(['productos']);
    }

   if(response is ErrorResponse){
    Get.snackbar('Error', 'ocurrio un error');
   }
  
  }
  
  void filterProductosSelect({int indexCategoria,int idCategoria}) async{
   final indexSelecionada = categorias.indexWhere((categoria) => categoria.selecionada);
   categorias[indexSelecionada] = categorias[indexSelecionada].copyWith(selecionada: false);
   categorias[indexCategoria] = categorias[indexCategoria].copyWith(selecionada: true);
   this.categoriaSelecionada = categorias[indexCategoria];
   this.allProductos = await this._getProductosByCategoria(this.categoriaSelecionada.id);
   update(['productos']);
   this._animationResetController();
  }
  
   Future<void> getProductosByEmpresa(int idEmpresa) async {
    this.loading = true;
    update(['productos_empresa']);
    final response = await repositorio.getProductoByEmpresa(idEmpresa);
    if(response is ResponseProducto){
      this.productosByEmpresa = response.productos;
      this.loading = false;
      update(['productos_empresa']);
    }
    if(response is ErrorResponse){
      print(response.getError);
    }
  }

  void selectProducto(Producto producto) {
    this.productoSelecionado = producto;
    this.cantidadProducto = 1;
    update(['producto','cantidad']);
  }

  void cambiarCantidad({bool aumentar}){
    if(aumentar){
      this.cantidadProducto ++;
      update(['cantidad']);
    }
    if(!aumentar && this.cantidadProducto > 0){
      this.cantidadProducto --;
      update(['cantidad']);
    }
  }
 // pedido controller  
  void addPedido(Producto producto){
    Pedido pedido;
    final newProducto = producto.copyWith(cantidad: this.cantidadProducto);

    if(this._existPedido(newProducto.empresa.id)){
      if(this._existProductoInPedido(newProducto.empresa.id,newProducto.id)){
       Get.snackbar('Producto no agregado','el producto ya existe en el pedido');
     }
      if(!this._existProductoInPedido(newProducto.empresa.id,newProducto.id)){
         final index = this.pedidos
                       .indexWhere((pedido) => pedido.empresa.id == newProducto.empresa.id);
         this.pedidos[index].productos.add(newProducto);
     }
   }
   if(!this._existPedido(producto.empresa.id)){
     pedido = Pedido(
              id:  Uuid().v4(),
              empresa : producto.empresa,
              usuario : Get.find<HomeController>().usuario,
              observacion: '',
              productos: []
     );
     pedido.productos.add(newProducto);
     this.pedidos.add(pedido);
     Get.snackbar('Producto agregado','');
   }
   update(['carrito']);
  }
  //pedidos controller
  void sendPedido(Pedido pedido) async {

   final newPedido = pedido.copyWith(observacion: controllerObservacion.text);
   final response = await repositorio.addPedido(newPedido);
   if(response is ResponseProducto){
     controllerObservacion.text = '';
     final texto = this._getTexto(newPedido);
     this.goToWhatsapp(pedido.empresa.telefono, texto);
     final index = this._indexPedidos(pedido.empresa.id);
     this.pedidos.removeAt(index);
     update(['pedidos','carrito']);
   }
   if(response is ErrorResponse){
     print(response.getError);
   }
  }
 
  //pedido controller
  String _getTexto(Pedido pedido){
     var texto = 'Hola Buenos Dias ${pedido.empresa.nombre} soy ${pedido.usuario.nombre} mi pedido es';
        pedido.productos.forEach((producto) {
           texto = '$texto  ${producto.cantidad} de ${producto.nombre},';
       });
     texto = '$texto y con las siguientes observaciones: ${pedido.observacion}';
     return texto;
  }

  //pedidos controller 
  void deleteProductoOf(int index,int idEmpresa){
    final indexPedido = this._indexPedidos(idEmpresa);
    if(this.pedidos[indexPedido].productos.length == 1)
      this.pedidos.removeAt(indexPedido);
    else
      this.pedidos[indexPedido].productos.removeAt(index);
    update(['pedidos','carrito']);
  }
// pedidos controller
   void selectTipoPedido(int index){
      this.indexStackPedidos = index;
      update(['pedidos']);
   }
  void _getProductosByUsuario(int idUsuario) async {
    this.loading = true;
    update(['productos']);
    final response = await repositorio.getProductoByUsuario(idUsuario);
    if(response is ResponseProducto){
       this.productos = response.productos;
       this.loading = false;
       update(['productos']);
    }
    if(response is ErrorResponse)print('Error');
  }

  void _deleteProductoList(int idProducto) {
    final index = this.productos.indexWhere((producto) => producto.id == idProducto);
    this.productos.removeAt(index);
    update(['productos']);
    Get.back();
  }

 void _getcategorias() async {
   final response = await repositorio.getCategorias();
   if(response is ResponseProducto){
     this.categorias = response.categorias;
     this.categorias.insert(0, CategoriaProducto(
       id : -1,
       nombre: 'Todos',
       selecionada: true
     ));
     update(['productos']);
   }
   if(response is ErrorResponse) print(response.getError);
 }

 // animacion scroll final
 /* void _animationFinalController() {
    controller.animateTo(controller.position.pixels + 100,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
    controllerOferta.animateTo(controllerOferta.position.pixels + 100,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  } */

 void _animationResetController() {
    controller.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
    controllerOferta.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  Future<List<Producto>> _getProductosByCategoria(int id) async {
    final response = await repositorio.getAllProductosByCategoria(_paginaFilter, id);
    if(response is ResponseProducto && id != -1){
      return response.productos;
    }
    if(response is ErrorResponse){
      return this.allProductos;
    }
    if(id == -1 ){
      this._pagina = 0;
      this._paginaFilter =0;
      await this.getAllProductos();
      return this.allProductos;
    }
    return this.allProductos;
  }
 // pedido controller  
  bool _existPedido(int idEmpresa) {
   final index = this._indexPedidos(idEmpresa);
   if(index == -1)
    return false;
   else return true;
  }
 // pedido controller  
  bool _existProductoInPedido(int idEmpresa,int idProducto) {
   final index = this._indexPedidos(idEmpresa);
   final indexProducto = this.pedidos[index].productos
                      .indexWhere((producto) => producto.id == idProducto);
   if(indexProducto != -1)
     return true;
   else return false;
  }
  int _indexPedidos(int idEmpresa){
    return this.pedidos
          .indexWhere((pedido) => pedido.empresa.id == idEmpresa);
  }
  // pedidos controller
  void goToWhatsapp(
    String telefono,
    String texto
  ) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+57$telefono/?text=$texto";
      } else {
        return "whatsapp://send?phone=+57$telefono&text=$texto";
      }
    }
    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

}


