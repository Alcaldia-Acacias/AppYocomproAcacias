import 'dart:io';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:comproacacias/src/plugins/notificationPush.dart';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Dependecias {
  static init(String url) async {
    final box = GetStorage();
    final token = box.read('token');
    Get.lazyPut(() => dio.Dio(dio.BaseOptions(
        baseUrl: '$url',
        contentType: dio.Headers.jsonContentType,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'})));
    Get.put(PushNotification());
    Get.put(ImageCapture());
  }
}
