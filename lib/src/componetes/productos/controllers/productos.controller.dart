import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/categoriaProducto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/response.producto.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ProductosController extends GetxController {
  
  final ProductosRepositorio repositorio;
  final int idEmpresa;



  ProductosController(
      {this.repositorio,
      this.idEmpresa,
      });

  Producto productoSelecionado;

  List<Producto> productos = [];
  List<Producto> allProductos = [];
  List<Producto> allWithOfertaProductos = [];
  List<Producto> productosByEmpresa = [];
  List<CategoriaProducto> categorias = [];

  int _pagina = 0;
  int _paginaOferta = 0;
  int _paginaFilter = 0;
  
  bool loading  = false;
  

  ScrollController controller = ScrollController(initialScrollOffset: 0);
  ScrollController controllerOferta = ScrollController(initialScrollOffset: 0);

  @override
  void onInit() {

    final idUsuario = GetStorage().read('id');
    this._getProductosByUsuario(idUsuario);
     if(categorias.length == 0){
      this._getcategorias();
    }
    this.controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent)
         this.getAllProductos();
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

  void getAllProductos({bool oferta = false}) async {
    final response = await repositorio.getAllProductos(_pagina,oferta: oferta);
    if(response is ResponseProducto){
      if(oferta){
        this.allWithOfertaProductos.addAll(response.productos);
        _paginaOferta++;
        }
      if(!oferta){
         this.allProductos.addAll(response.productos);
        _pagina ++;
      }
      if(_pagina > 1 || _paginaOferta > 1)
      this._animationFinalController();
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
   this.allProductos = await this._getProductosByCategoria(categorias[indexCategoria].id);
   update(['productos']);
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
    update(['producto']);
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
 void _animationFinalController() {
    controller.animateTo(controller.position.pixels + 100,
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
      this.getAllProductos();
      return this.allProductos;
    }
    return this.allProductos;
  }
  
  
}


