import 'dart:io';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Dependecias {
  static init() {
    String urlApi;
    final box = GetStorage();
    final token = box.read('token');
    if(GetPlatform.isAndroid)
       urlApi = 'https://api.yocomproacacias.com';
    else urlApi = 'http://localhost:8000';

    Get.lazyPut(() => Dio(BaseOptions(
        baseUrl: '$urlApi',
        contentType: Headers.jsonContentType,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'})));
    Get.put(ImageCapture());
  }
}
