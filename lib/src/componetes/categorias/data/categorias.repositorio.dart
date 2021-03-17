import 'package:comproacacias/src/componetes/categorias/models/categoria.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CategoriaRepositorio {
  Dio _dio = Get.find<Dio>();

  Future<List<Empresa>> getEmpresasByCategoria(String categoria,int page) async {
    final response = await _dio.get('/empresas/categoria/$categoria',queryParameters: {'page': page});
    return response.data
        ?.map<Empresa>((empresa) => Empresa.toJson(empresa))
        ?.toList();
  }
  Future<List<Categoria>> getCategorias() async {
     final response = await _dio.get('/categorias');
     return response.data?.map<Categoria>((categoria)=>Categoria.toJson(categoria))?.toList();
 
  }



}