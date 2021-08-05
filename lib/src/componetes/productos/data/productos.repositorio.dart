import 'package:comproacacias/src/componetes/productos/models/categoriaProducto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/response.producto.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/imageFile.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductosRepositorio {
  final _dio = Get.find<Dio>();


  Future<ResponseModel> addProducto(
      Producto producto, int idEmpresa, List<ImageFile> imagenes) async {
    try {
      FormData data = FormData.fromMap({...producto.toMap(idEmpresa)});
      imagenes.forEach((imagen) async {
        data.files.add(MapEntry(
          imagen.nombre,
          MultipartFile.fromFileSync(imagen.file.path, filename: imagen.nombre),
        ));
      });
      final response = await this._dio.post('/productos/add', data: data);
      return ResponseProducto(producto: Producto.toJson(response.data));
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
  Future<ResponseModel> getAllProductos(int page,{bool oferta}) async {
    try {
      //await Future.delayed(Duration(seconds: 20));
      final response = await this._dio.get('/productos',queryParameters: {'page': page,'oferta' : oferta});
      final productos = response.data.map<Producto>((producto)=>Producto.toJson(producto)).toList();
      return ResponseProducto(productos: productos);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
  Future<ResponseModel> getAllProductosByCategoria(int page,int idCategoria) async {
    try {
      final response = await this._dio.get('/productos/categoria/$idCategoria',queryParameters: {'page': page,});
      final productos = response.data.map<Producto>((producto)=>Producto.toJson(producto)).toList();
      return ResponseProducto(productos: productos);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> updateProducto(
      Producto producto, int idEmpresa, List<ImageFile> imagenes) async {
    try {
      FormData data = FormData.fromMap({...producto.toMap(idEmpresa,producto.id)});
      imagenes.forEach((imagen) async {
        if(imagen.isaFile)
        data.files.add(MapEntry(
          imagen.nombre,
          MultipartFile.fromFileSync(imagen.file.path, filename: imagen.nombre),
        ));
      });
      final response = await this._dio.put('/productos/update', data: data);
      return ResponseProducto(update: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> deleteProducto(int idProducto) async {
    try {
      final response = await this._dio.delete('/productos/delete/$idProducto');
      return ResponseProducto(delete: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> getCategorias() async {
    try {
      final response = await this._dio.get('/categorias_producto');
      final categorias = response.data
          .map<CategoriaProducto>(
              (categoria) => CategoriaProducto.toJson(categoria))
          .toList();
      return ResponseProducto(categorias: categorias);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> getProductoByUsuario(int idUsuario) async {
    try {
      final response = await this._dio.get('/productos/usuarios/$idUsuario');
      final productos = response.data
          .map<Producto>((producto) => Producto.toJson(producto))
          .toList();
      return ResponseProducto(productos: productos);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  } 
  Future<ResponseModel> getProductoByEmpresa(int idEmpresa) async {
    try {
      final response = await this._dio.get('/productos/empresa/$idEmpresa');
      final productos = response.data
          .map<Producto>((producto) => Producto.toJson(producto))
          .toList();
      return ResponseProducto(productos: productos);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  } 
}
