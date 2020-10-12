import 'package:comproacacias/src/componetes/usuario/models/update.model.dart';

class ErrorResponseUpdate extends UpdateModel {
 final String error;
  ErrorResponseUpdate(this.error);

  factory ErrorResponseUpdate.toJson(Map<String,dynamic> json)
    => ErrorResponseUpdate(json['error']);
}