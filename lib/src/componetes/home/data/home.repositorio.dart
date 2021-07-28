import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/home/models/notificacion.model.dart';
import 'package:comproacacias/src/componetes/home/models/response.model.dart';
import 'package:comproacacias/src/componetes/home/models/youtubeVideo.model.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_api/youtube_api.dart';

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

  Future<ResponseModel> registroActividad(int idUsuario) async {
    try {
      await _dio.post('/ingresos/add', data: {"id_usuario": idUsuario});
      return HomeResponse(addIngreso: true);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> leerNotificacion(int idNotificacion) async {
    try {
      final response = await _dio.put('/notificaciones/leida',
          data: {"id_notificacion": idNotificacion});
      return ResponseHome(notificacionLeida: response.data['leida']);
    } catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> getVideosYoutbe() async {
    List<YT_API> result = [];
    final String tokenYoutube = 'AIzaSyAmvIdl1EiTbeVgC5ulmnIij47jES4kL7E';
    YoutubeAPI ytApi = YoutubeAPI(tokenYoutube);
    try {
      result = await ytApi.channel('UCAPP8tro1pewJCHQ2zCkcuA');
      final videos = result
          .map((video) => YouTubeVideo(
              url: video.url,
              urlImagen: video.thumbnail['high']['url'],
              fecha: video.publishedAt))
          .toList();
      return HomeResponse(videos: videos);
    } catch (error) {
      print(error);
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> getTop10Empresas() async {
    try {
      final response = await _dio.get('/empresas/top');
      final empresas = response.data
          .map<Empresa>((empresa) => Empresa.toJson(empresa))
          .toList();
      return ResponseEmpresa(empresas: empresas);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> registrarTokenPush(token, idUsuario) async {
    FormData data = FormData.fromMap({"id_usuario": idUsuario, "token": token});
    try {
      final response = await _dio.put('/usuarios/add/token', data: data);
      return ResponseHome(registrarToken: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> getTokenAnonimo() async {
    try {
      final response = await _dio.get('/usuarios/anonimo/token');
      return ResponseHome(tokenAnonimo: response.data);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }

  Future<ResponseModel> getNotificaciones(int idUsuario) async {
    try {
      final response = await _dio.get('/notificaciones/$idUsuario');
      final notificaciones = response.data
          .map<Notificacion>(
              (notificacion) => Notificacion.toJson(notificacion))
          .toList();
      return ResponseHome(notificaciones: notificaciones);
    } on DioError catch (error) {
      return ErrorResponse(error);
    }
  }
}
