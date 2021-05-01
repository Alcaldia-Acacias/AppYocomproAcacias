import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/calificacion.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:get/get.dart';

class CalificacionesController extends GetxController {
  

final EmpresaRepositorio repositorio;
final int idEmpresa;
List<Calificacion> calificaciones = [];
Empresa empresa;

CalificacionesController({this.repositorio,this.idEmpresa});


@override
  void onInit() async {
    await _getEmpresaByid();
    await _getCalficaciones();
    super.onInit();
  }

  Future<void> _getCalficaciones() async {
    final response = await repositorio.getCalificacionesByEmpresa(idEmpresa);
    this.calificaciones = response;
    update(['list_calificaciones']);
  }

  Future<void> _getEmpresaByid() async {
    final response = await repositorio.getEmpresaByid(idEmpresa);
    if(response is ResponseEmpresa){
      this.empresa = response.empresa;
    }
    if(response is ErrorResponse)print(response.getError);
    update(['list_calificaciones']);
  }


}