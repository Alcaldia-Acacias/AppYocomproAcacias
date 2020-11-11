import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class HomeResponse extends ResponseModel {
  final bool update;
  final List<Empresa> empresas;
  HomeResponse({this.update,this.empresas});
}