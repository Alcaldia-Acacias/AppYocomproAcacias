import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponsePublicacion extends ResponseModel {

final int id;
final bool update;
final bool delete;
final Publicacion publicacion;
ResponsePublicacion({this.id,this.update,this.delete,this.publicacion});

}