import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponseEmpresa extends ResponseModel {
  final int id;
  final bool delete;
  final bool update;
  ResponseEmpresa({this.id,this.delete,this.update});
}
