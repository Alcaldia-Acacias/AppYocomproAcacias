import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/reponse.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:get/get.dart';

class PublicacionController extends GetxController {

final int idPublicacion;
int pagina;
final PublicacionesRepositorio repocitorio;
PublicacionController({this.idPublicacion,this.repocitorio,this.pagina});

Publicacion publicacion;


  @override
  void onInit() async {
    await getPublicacionByid(idPublicacion);
    super.onInit();
  }


  void changePagina(pagina){
    this.pagina = pagina;
    update(['publicacion']);
  }

  Future getPublicacionByid(int idPublicacion) async {
     final response = await repocitorio.getPublicacionById(idPublicacion);
     if(response is ResponsePublicacion){
      this.publicacion = response.publicacion;
      update(['publicacion']);
     }
     if(response is ErrorResponse){
      print(response.getError);
     }
  }

}