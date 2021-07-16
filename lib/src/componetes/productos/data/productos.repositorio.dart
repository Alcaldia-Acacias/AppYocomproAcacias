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

  /* Future<ResponseModel> addProducto(Producto producto, int idEmpresa,
      {String path}) async {
    try {
      FormData data = FormData.fromMap({
        ...producto.toMap(idEmpresa),
        "file": path == null
            ? null
            : await MultipartFile.fromFile(path, filename: "${producto.imagen}")
      });
      final response = await this._dio.post('/productos/add', data: data);
      print(response.data);
      return ResponseProducto(idProducto: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  } */

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
      print(response.data);
      return ResponseProducto(idProducto: response.data);
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

  /* Future<ResponseModel> updateProducto(Producto producto, int idEmpresa,
      {String path}) async {
    try {
      FormData data = FormData.fromMap({
        "id": producto.id,
        ...producto.toMap(idEmpresa),
        "file": path.isNull
            ? null
            : await MultipartFile.fromFile(path, filename: "${producto.imagen}")
      });
      final response = await this._dio.put('/productos/update', data: data);
      return ResponseProducto(update: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  } */
}
