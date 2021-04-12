import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponseProducto extends ResponseModel {
  final bool delete;
  final bool update;
  final int  idProducto;
  ResponseProducto(
      {this.delete, this.update, this.idProducto});
}
