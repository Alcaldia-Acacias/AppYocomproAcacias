import 'package:comproacacias/src/componetes/publicaciones/models/empresa.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CategoriaRepositorio {
  Dio _dio = Get.find<Dio>();

  Future<List<Empresa>> getEmpresasByCategoria(String categoria,int page) async {
    final response = await _dio.get('/empresas/categorias/$categoria',queryParameters: {'page': page});
    return response.data
        .map<Empresa>((empresa) => Empresa.toJson(empresa))
        .toList();
  }
}