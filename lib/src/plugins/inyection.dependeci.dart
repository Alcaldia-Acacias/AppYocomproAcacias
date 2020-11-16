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
       urlApi = '165.22.239.235';
    else urlApi = 'localhost:8000';

    Get.lazyPut(() => Dio(BaseOptions(
        baseUrl: 'http://$urlApi',
        contentType: Headers.jsonContentType,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'})));
    Get.put(ImageCapture());
  }
}
