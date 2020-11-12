import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/formPublicacion.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:comproacacias/src/componetes/widgets/dialogImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FormPublicacionPage extends StatelessWidget {
  FormPublicacionPage({Key key}) : super(key: key);
  final String urlImagenLogo = Get.find<HomeController>().urlImegenes;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: GetBuilder<FormPublicacionesController>(
                  init: FormPublicacionesController(repositorio: PublicacionesRepositorio()),
                  builder: (state) 
                            => Scaffold(
                               appBar: AppBar(
                                       title     : Text('Agrega tu Publicacion'),
                                       elevation : 0,
                               ),
                               body  : SingleChildScrollView(
                                       padding : EdgeInsets.all(20),
                                       child   : Form(
                                                 key   : state.formKey,
                                                 child : Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                              InputForm(
                                                              placeholder : 'Escribe Tu publicacion',
                                                              controller  : state.publicacionController,
                                                              textarea    : true,
                                                              requerido   : true,  
                                                              ),
                                                              _escojerEmpresa(state),
                                                              SizedBox(height: 10),
                                                              Text('Imagenes (maximo 5)'),
                                                              SizedBox(height: 10),
                                                              _imagenes(state)
                                                         ]
                                                 )
                                       ),
                               ),
                               floatingActionButton: FloatingActionButton.extended(
                                                     heroTag         : 'publicar',
                                                     backgroundColor : Get.theme.primaryColor,
                                                     icon            : Icon(Icons.add,color: Colors.white),
                                                     label           : Text('Publicar',style:TextStyle(color: Colors.white)),
                                                     onPressed       : ()=>state.addPublicacion()
                                                     ),
                            )
                  ),
           onTap: ()=>FocusScope.of(context).unfocus(),
    );
  }

Widget _escojerEmpresa(FormPublicacionesController state) {
  return ListTile(
         leading : Icon(Icons.business),
         // ignore: can_be_null_after_null_aware
         title   : Text('${state.empresa?.nombre.isNull ? 'Selecione Una Empresa' : state.empresa.nombre}'),
         onTap   : ()=>_dialogEmpresas(state),
  );
}

  _dialogEmpresas(FormPublicacionesController state) {
    Get.bottomSheet(
    Container(
    height : Get.height * 0.5,
    color  : Colors.white,
    child  : _empresas(state),  
    )
    );
  }

Widget _empresas(FormPublicacionesController state) {
  return ListView.builder(
         itemCount  : state.empresas.length,
         itemBuilder: (_,i){
            return ListTile(
                   title    : Text(state.empresas[i].nombre),
                   subtitle : Text(state.empresas[i].nit),
                   leading  : CircleAvatar(
                              backgroundImage: state.empresas[i].urlLogo == ''
                                               ?
                                               AssetImage('assets/imagenes/no_logo_img.png')
                                               :
                                               NetworkImage('$urlImagenLogo/logo/${state.empresas[i].urlLogo}')
                   ),
                   onTap    : ()=>state.selectEmpresa(state.empresas[i])
            );
         }
  );
}

Widget _imagenes(FormPublicacionesController state) {
  return Wrap(
         spacing: 2,
         runSpacing: 2,
         children: [
             if(state.imagenes.length < 5)
               GestureDetector(
               child: Container(
                      height : 100,
                      width  : Get.width *0.29,
                      color  : Colors.grey[350],
                      child  : Center(child:Icon(Icons.add,color: Colors.white)),
               ),
               onTap: ()=>DialogImagePicker.openDialog(
                          titulo       : 'Selecione una Imagen',
                          onTapArchivo : ()=>state.getImage('archivo'),
                          onTapCamera  : ()=>state.getImage('camara')
               ),
               ),
              ...state.imagenes.asMap()
                               .entries
                               .map((imagen) => GestureDetector(
                                                child: FadeInImage(
                                                       height : 100,
                                                       width  : Get.width *0.29,
                                                       fit    : BoxFit.cover,
                                                       placeholder: AssetImage('assets/imagenes/load_image.png'), 
                                                       image: FileImage(imagen.value.file),
                                                ),
                                                onTap: ()=>DialogImagePicker.openDialog(
                                                           titulo       : 'Cambia la Imagen',
                                                           onTapArchivo : ()=>state.getImage('archivo',true,imagen.key),
                                                           onTapCamera  : ()=>state.getImage('camara',true,imagen.key)
                                                ),
                               ) 
              )
         ]
  );
}
}