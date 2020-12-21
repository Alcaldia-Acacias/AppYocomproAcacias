import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/formEmpresa.view.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';
class ListEmpresasPage extends StatelessWidget {

  final List<Empresa> empresas;
  ListEmpresasPage({Key key, this.empresas}) : super(key: key);
  final String urlImagenes = Get.find<HomeController>().urlImegenes;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<EmpresasController>(
           id: 'empresas',
           init: EmpresasController(repositorio: EmpresaRepositorio(),empresas:empresas),
           builder:(state) {
           return  Scaffold(
            appBar: AppBar(
                     title: Text('Empresas'),
                     elevation: 0,
             ),
             body: _listEmpresas(state.empresas,state),
             
             floatingActionButton: FloatingActionButton(
                                   child           : Icon(Icons.add,color: Colors.white),
                                   backgroundColor : Get.theme.primaryColor,
                                   onPressed       : ()=> Get.to(FormEmpresaPage(),transition: Transition.downToUp)
                                   ),
           );
      }
    );
  }

Widget _listEmpresas(List<Empresa> empresas, EmpresasController state) {
  return ListView.builder(
         itemCount:empresas.length,
         itemBuilder: (context,i){
            return Slidable(
                    secondaryActions: <Widget>[
                                                IconSlideAction(
                                                caption : 'Editar',
                                                color   : Get.theme.primaryColor,
                                                icon    : Icons.edit,
                                                onTap:  () => Get.to(FormEmpresaPage(update: true,empresa:empresas[i]))
                                                ),
                                                IconSlideAction(
                                                caption : 'Eliminar',
                                                color   : Colors.red,
                                                icon    : Icons.delete,
                                                onTap:  ()=>_deleteEmpresaDialogo(i,empresas[i].id,state)
                                                ),
                                                ],
                   actionPane: SlidableDrawerActionPane(),
                   child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading       : ClipRRect(
                                          borderRadius: BorderRadius.circular(500),
                                          child       : FadeInImage(
                                                        width      : 60,
                                                        height     : 60,
                                                        fit        : BoxFit.cover,
                                                        placeholder: AssetImage('assets/imagenes/load_image.gif'), 
                                                        image      : empresas[i].urlLogo == ''
                                                                     ? AssetImage('assets/imagenes/logo_no_img.png')
                                                                     : NetworkImage('$urlImagenes/logo/${empresas[i].urlLogo}?${Uuid().v1()}')  
                                          ),
                          ),                 
                          title: Text(empresas[i].nombre),
                          onTap: ()=> Get.to(PerfilEmpresaPage(empresa: empresas[i],propia: true))
                ),
            );
         },
  );

}

void _deleteEmpresaDialogo(int i, int id, EmpresasController state) {
   Get.defaultDialog(
    title: 'Eliminar Empresa',
    content: Container(
             alignment: Alignment.center,
             height: 100,
             child: Text('Esta seguro de eliminarla ?')
             ),
    actions: [
        RaisedButton.icon(
        color     : Get.theme.primaryColor,
        icon      : Icon(Icons.delete), 
        label     : Text('Eliminar'),
        textColor : Colors.white,
        onPressed : ()=>state.deleteEmpresa(i, id), 
        ),
        RaisedButton(
        child     : Text('cancelar'),
        color     : Colors.white,
        onPressed : ()=>Get.back(),
        )
    ]
    );
}
}