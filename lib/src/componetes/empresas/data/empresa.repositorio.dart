
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/producto.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';


class EmpresaRepositorio {
  final _dio = Get.find<Dio>();

  Future<List<Producto>> getProductosByEmpresa(int idpublicaciones) async {
    final response = await this._dio.get('/productos/empresa/$idpublicaciones');
    return response.data
        ?.map<Producto>((producto) => Producto.toJson(producto))
        ?.toList();
  }

  Future<ResponseModel> addEmpresa(
      Empresa empresa, int idUsuario, String path) async {
    FormData data = FormData.fromMap({
      ...empresa.toMap(idUsuario),
      "file": await MultipartFile.fromFile(path, filename: "imagen.jpg")
    });

    try {
      final response = await this._dio.post('/empresas/add/',
          data: data,
          options: Options(contentType: 'multipart/form-data'));
      print(response.data);
      return ResponseEmpresa(id: response.data['id']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
  Future<ResponseModel> deleteEmpresa(int id) async {
    try {
      final response = await this._dio.delete('/empresas/delete/$id');
      return ResponseEmpresa(delete: response.data['delete']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
  Future<ResponseModel> updateEmpresa(Empresa empresa,int idUsuario,{String path}) async {
    try {
      FormData data = FormData.fromMap({
      ...empresa.toMap(idUsuario),
      "file": path.isNull
              ? null
              : await MultipartFile.fromFile(path, filename: "imagen.jpg")
    });
      final response = await this._dio.put('/empresas/update',data: data);
      return ResponseEmpresa(update: response.data['update']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
}
