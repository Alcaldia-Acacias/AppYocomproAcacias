import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class UsuarioResponse extends ResponseModel {
 final bool update;
 final bool reporte;
 UsuarioResponse({this.update,this.reporte});
 factory UsuarioResponse.toJson(Map<String, dynamic> json) 
  =>UsuarioResponse(
    update :json['update'],
    reporte: json['reporte']
  );
}