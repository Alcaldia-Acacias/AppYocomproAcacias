import 'dart:io';

import 'package:comproacacias/src/componetes/response/models/response.model.dart';
import 'package:dio/dio.dart';


class ErrorResponse  extends ResponseModel{
  
  final DioError error;
  ErrorResponse(this.error);

  String get getError {
   if(error.error is SocketException)
      return this.error.error.osError.message;
   return error.response.data['error'];
  }

  factory ErrorResponse.toJson(Map<String,dynamic> json)
    => ErrorResponse(json['error']);
}
