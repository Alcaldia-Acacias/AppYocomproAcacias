import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Dependecias {
 
  static init() {

  final box = GetStorage();
  final token = box.read('token');

  Get.lazyPut(()=>Dio(
                  BaseOptions(
                      baseUrl: 'http://10.0.2.2:8000',
                      contentType: Headers.jsonContentType,
                      headers:{HttpHeaders.authorizationHeader: 'Bearer $token'}
                  )
  ));


  }
}
