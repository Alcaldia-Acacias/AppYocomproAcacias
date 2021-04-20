import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponsePublicacion extends ResponseModel {

final int id;
final bool update;
final bool delete;

ResponsePublicacion({this.id,this.update,this.delete});

}