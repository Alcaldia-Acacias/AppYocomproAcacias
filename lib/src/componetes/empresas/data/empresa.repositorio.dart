import 'package:comproacacias/src/componetes/empresas/models/producto.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class EmpresaRepositorio {
  final _dio = Get.find<Dio>();

  Future<List<Producto>> getProductosByEmpresa(int idpublicaciones) async {
    final response =
        await this._dio.get('/empresas/productos/$idpublicaciones');

    return response.data
        .map<Producto>((producto) => Producto.toJson(producto))
        .toList();
  }
}
