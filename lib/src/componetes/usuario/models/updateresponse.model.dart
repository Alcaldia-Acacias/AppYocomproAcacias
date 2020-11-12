import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class UsuarioResponse extends ResponseModel {
 final bool update;
 UsuarioResponse({this.update});
 factory UsuarioResponse.toJson(Map<String, dynamic> json) 
  =>UsuarioResponse(
    update :json['update']
  );
}