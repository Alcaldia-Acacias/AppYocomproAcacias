import 'dart:io';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Dependecias {
  static init(String url) {
    final box = GetStorage();
    final token = box.read('token');
    Get.lazyPut(() => Dio(BaseOptions(
        baseUrl: '$url',
        contentType: Headers.jsonContentType,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'})));
    Get.put(ImageCapture());
  }
}
