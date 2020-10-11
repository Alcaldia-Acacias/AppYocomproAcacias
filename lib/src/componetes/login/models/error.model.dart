import 'package:comproacacias/src/componetes/login/models/login.model.dart';

class ErrorLogin  extends LoginModel{
  final String error;
  ErrorLogin(this.error);

  factory ErrorLogin.toJson(Map<String,dynamic> json)
    => ErrorLogin(json['error']);
}
