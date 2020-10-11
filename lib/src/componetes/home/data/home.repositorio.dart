import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeRepocitorio {

  final _dio = Get.find<Dio>();
  final _box = GetStorage();

  Future<Usuario> getUsuario() async {
    if(_box.hasData('id')){
    final response = await _dio.get('/usuarios/${_box.read('id')}');
    return Usuario.toJson(response.data);
    }
    return Usuario();
  }
}
