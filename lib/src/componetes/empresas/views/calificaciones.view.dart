import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/controller/calificaciones.controller..dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/calificacion.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/calificacion.widget.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalificacionesLisTPage extends StatelessWidget {
  final int idEmpresa;
  CalificacionesLisTPage({Key key, this.idEmpresa}) : super(key: key);
  final  urlImagenLogo = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   elevation : 0,
                   title     : Text('Calificaciones'),
           ),
           body  : GetBuilder<CalificacionesController>(
                   id      : 'list_calificaciones',
                   init    : CalificacionesController(idEmpresa: idEmpresa,repositorio: EmpresaRepositorio()),
                   builder : (state){
                    if(state.calificaciones.length == null || state.calificaciones.length == 0)
                       return Center(child:CircularProgressIndicator());
                    return  Column(
                            children: [
                             Padding(
                             padding : EdgeInsets.all(8.0),
                             child   : Text('Empresa',style:TextStyle(fontWeight: FontWeight.bold)),
                             ),
                             _cardEmpresa(state.empresa),
                             Padding(
                             padding : EdgeInsets.all(8.0),
                             child   : Text('Calificaciones',style:TextStyle(fontWeight: FontWeight.bold)),
                             ),
                             Expanded(
                             child: _listCalificaciones(state.calificaciones)
                             )
                            ],
                    );
                   }
           ),
    );
  }

 Widget _cardEmpresa(Empresa empresa) {
   return GestureDetector(
          child: Card(
                 elevation: 0,
                 child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: ListTile(
                               title    : Text(empresa.nombre,
                                          style: TextStyle(
                                                 fontWeight: FontWeight.bold
                                          )),
                               subtitle : Text(empresa.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                          ),
                               leading  : empresa.urlLogo == ''
                                          ? 
                                          CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage('assets/imagenes/logo_no_img.png'),
                                          )
                                          :
                                          CircleAvatar(
                                          radius: 30,
                                          backgroundImage: CachedNetworkImageProvider('$urlImagenLogo/logo/${empresa.urlLogo}'),
                                          )
                        ),
                 ),
                 shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                 ),
          ),
        onTap: (){
          Get.to(PerfilEmpresaPage(empresa: empresa));
        },
   );
  }
  
  Widget _listCalificaciones(List<Calificacion> calificaciones) {
    return ListView.builder(
           itemCount  : calificaciones.length,
           itemBuilder: (_,i){
              return Card(
                     elevation: 0,
                     color    : Colors.white,
                     shape    : RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15)
                     ),
                     child    : Padding(
                                padding :  EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                                child   :  Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                            ListTile(
                                            title   : Text(calificaciones[i].usuario.nombre),
                                            leading : CircleAvatar(
                                                      radius          : 30,
                                                      backgroundImage : calificaciones[i].usuario.imagen == ''
                                                                        ? AssetImage('assets/imagenes/logo_no_img.png')
                                                                        : CachedNetworkImageProvider('$urlImagenLogo/usuarios/${calificaciones[i].usuario.imagen}'),
                                            ),
                                            ),
                                            Padding(
                                            padding : EdgeInsets.only(left: 25),
                                            child   : CalificacionWidget(
                                                      extrellas : calificaciones[i].extrellas,
                                                      centrado  : false,
                                                      size      : 20
                                            ),
                                            ),
                                            Padding(
                                            padding : const EdgeInsets.only(left: 30),
                                            child   : Text(calificaciones[i].comentario),
                                            )
                                          ],
                                ),
                     )
              );
           }
    );
  }
}