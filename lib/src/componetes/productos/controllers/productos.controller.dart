import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/response.producto.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:get/get.dart';


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

  List<Producto> productos = [];

  @override
  void onInit() {
    final idUsuario = Get.find<HomeController>().usuario.id;
    this._getProductosByUsuario(idUsuario);
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
  void _getProductosByUsuario(int idUsuario) async {
    final response = await repositorio.getProductoByUsuario(idUsuario);
    if(response is ResponseProducto){
       this.productos = response.productos;
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

  
}


