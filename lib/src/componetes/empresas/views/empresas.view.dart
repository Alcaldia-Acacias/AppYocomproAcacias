import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/formEmpresa.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListEmpresasPage extends StatelessWidget {
  final List<Empresa> empresas;
  ListEmpresasPage({Key key, this.empresas}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmpresasController>(
           init: EmpresasController(repositorio: EmpresaRepositorio(),empresas:empresas),
           builder:(state) {
           return  Scaffold(
            appBar: AppBar(
                     title: Text('Empresas'),
                     elevation: 0,
             ),
             body: _listEmpresas(state.empresas),
             
             floatingActionButton: FloatingActionButton(
                                   child           : Icon(Icons.add,color: Colors.white),
                                   backgroundColor : Get.theme.primaryColor,
                                   onPressed: ()=> Get.to(FormEmpresaPage(),transition: Transition.downToUp)
                                   ),
           );
      }
    );
  }

Widget _listEmpresas(List<Empresa> empresas) {
  return ListView.builder(
         itemCount:empresas.length,
         itemBuilder: (context,i){
            return Slidable(
                    secondaryActions: <Widget>[
                                                IconSlideAction(
                                                caption : 'Editar',
                                                color   : Get.theme.primaryColor,
                                                icon    : Icons.edit,
                                                onTap:  (){}
                                                ),
                                                IconSlideAction(
                                                caption : 'Eliminar',
                                                color   : Colors.red,
                                                icon    : Icons.delete,
                                                onTap:  (){}
                                                ),
                                                ],
                   actionPane: SlidableDrawerActionPane(),
                   child: ListTile(
                          leading: CircleAvatar(
                                   backgroundImage: empresas[i].urlLogo == ''
                                                    ? CachedNetworkImageProvider(empresas[i].urlLogo)
                                                    : AssetImage('assets/imagenes/logo_no_img.png')
                           ),
                           title: Text(empresas[i].nombre),
                           onTap:  (){}
                ),
            );
         },
  );

}
}