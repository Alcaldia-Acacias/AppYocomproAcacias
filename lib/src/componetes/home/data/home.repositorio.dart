import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeRepocitorio {
  final _dio = Get.find<Dio>();
  final _box = GetStorage();

  Future<Usuario> getUsuario() async {
    if (_box.hasData('id')) {
      final response = await _dio.get('/usuarios/${_box.read('id')}');
      return Usuario.toJson(response.data);
    }
    return Usuario();
  }

  Future<ResponseModel> updateImagen(String path, int idUsuario) async {
    FormData data = FormData.fromMap({
      "id_usuario": idUsuario,
      "file": await MultipartFile.fromFile(path, filename: "imagen.jpg")
    });
    try {
      final response = await _dio.put('/usuarios/update/image', data: data);
      return HomeResponse(update: response.data['update']);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
  
}
