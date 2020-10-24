import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/models/categoria.model.dart';
import 'package:comproacacias/src/componetes/empresas/controller/formulario.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

class FormEmpresaPage extends StatelessWidget {
   
  final bool update;
  final Empresa empresa;
  FormEmpresaPage({Key key, this.update = false, this.empresa}) : super(key: key);
  final List<Categoria> categorias = Get.find<CategoriasController>().categorias;
  final String urlImagenes = Get.find<HomeController>().urlImegenes;
  @override
  Widget build(BuildContext context) {
  return GetBuilder<FormEmpresaController>(
                   id: 'formulario_empresa',
                   init: FormEmpresaController(repositorio:EmpresaRepositorio(),actualizar: update,empresa: empresa),
                   builder: (state)
                   => GestureDetector(
                      child: Scaffold(
                             appBar: AppBar(
                                     title: Text(state.titulo),
                                     elevation: 0,
                             ),
                             body  :   Form(
                               key: state.formKey,
                               autovalidateMode: AutovalidateMode.onUserInteraction,
                               child: IndexedStack(
                                      index:state.currentPage,
                                      children: [
                                       _selectLogo(state),
                                       _datosBasicos(state,context),
                                       _datosContacto(state,context),
                                       _datosCategoria(state),
                                       _datosLocalizacion(state,context),
                                       ],
                                 )
                                   ),
                              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                              floatingActionButton: _buttonAction(state)
                     
                     ),
                    onTap: ()=>FocusScope.of(context).unfocus()
                   )
    );
  }

 Widget _datosBasicos(FormEmpresaController state,context) {
   return SingleChildScrollView (
          padding:EdgeInsets.all(40),                                        
          child: Column(
                 children: [
                   InputForm(
                   placeholder       : "Nombre de la Empresa",
                   controller        : state.nombreController,
                   foco              : state.nombreFoco,
                   leftIcon          : Icons.business,
                   requerido         : true, 
                   onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.nitFoco)
                   ),
                   InputForm(
                   placeholder       : "Nit",
                   controller        : state.nitController,
                   foco              : state.nitFoco,
                   leftIcon          : Icons.card_membership,
                   requerido         : true,
                   onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.descripcionFoco)
                   ),
                   InputForm(
                   placeholder       : "Descripcion",
                   controller        : state.descripcionController,
                   foco              : state.descripcionFoco,
                   leftIcon          : Icons.text_fields,
                   requerido         : true,
                   textarea          : true,
                   onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.direccionFoco)
                   ),
                   InputForm(
                   placeholder       : "Dirreción",
                   controller        : state.direccionController,
                   foco              : state.direccionFoco,
                   leftIcon          : Icons.map,
                   requerido         : true,
                   onEditingComplete : ()=>state.changePage(1)
                   ),
                 ]
          )
   );

 }

  Widget _datosContacto(FormEmpresaController state,context) {
    return SingleChildScrollView (
          padding:EdgeInsets.all(40),                                        
          child: Column(
                 children: [
                    InputForm(
                    placeholder       : "Telefono",
                    controller        : state.telefonoController,
                    foco              : state.telefonoFoco,
                    leftIcon          : Icons.phone,
                    requerido         : true, 
                    onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.whatsappFoco)
                    ),
                    InputForm(
                    placeholder       : "Whatsap",
                    controller        : state.whatsappController,
                    foco              : state.whatsappFoco,
                    leftIcon          : Icons.phone_android,
                    requerido         : true,
                    isEmail           : true,
                    onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.emailFoco)
                    ),
                    InputForm(
                    placeholder       : "Correo",
                    controller        : state.emailController,
                    foco              : state.emailFoco,
                    leftIcon          : Icons.email,
                    requerido         : true,
                    isEmail           : true,
                    onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.webFoco)
                    ),
                    InputForm(
                    placeholder       : "Sitio Web",
                    controller        : state.webController,
                    foco              : state.webFoco,
                    leftIcon          : Icons.web,
                    onEditingComplete : ()=>state.changePage(2)
                    )
                 ]
          )
   );
  }

 Widget _datosLocalizacion(FormEmpresaController state,context) {
     return SingleChildScrollView (
          padding:EdgeInsets.all(40),                                        
          child: Column(
                 children: [
                 InputForm(
                 placeholder       : "Latitud",
                 controller        : state.latitudController,
                 foco              : state.latitudFoco,
                 leftIcon          : Icons.gps_fixed,
                 onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.longitudFoco)
                 ),
                 InputForm(
                 placeholder       : "Longitud",
                 controller        : state.longitudController,
                 foco              : state.longitudFoco,
                 leftIcon          : Icons.gps_fixed,
                 onEditingComplete : (){}
                 ),
                 OutlineButton(
                 child: Text('Obtener Localizacion'),
                 shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                 ),
                 padding: EdgeInsets.all(16),
                 borderSide: BorderSide(
                             color: Get.theme.primaryColor,
                 ),
                 onPressed: ()=>state.getLocation(),
                 
                 )
                 ]
          )
   );
  }

 Widget  _buttonAction(FormEmpresaController state) {
    return Padding(
           padding:EdgeInsets.symmetric( horizontal: 20),
           child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  state.currentPage == 0
                  ?
                  Container()
                  :
                  FloatingActionButton(
                  heroTag         : 'anterior',
                  child           : Icon(Icons.arrow_back_ios,color:Colors.white),
                  backgroundColor : Get.theme.primaryColor,                            
                  onPressed       : ()=>state.changePage((state.currentPage -1)),
                  ),
                  SizedBox(height:20),
                  FloatingActionButton(
                  heroTag: 'siguiente',
                  child           : Icon(
                                   state.currentPage != 4
                                   ? Icons.arrow_forward_ios
                                   : Icons.check,
                                   color:Colors.white
                                   ),
                  backgroundColor: Get.theme.primaryColor,                            
                  onPressed      :  state.image?.path == null && !state.actualizar
                                        ? null
                                        : () => state.currentPage != 4
                                                ? state.changePage((state.currentPage +1))
                                                : state.actualizar ? state.updateEmpresaSubmit() : state.addEmpresaSubmit()
                  )
                 
                  ]
           ),
    );
  }

 Widget _selectLogo(FormEmpresaController state) {
    return Container(
           height:Get.height * 0.7,
           width: Get.width,
           child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      _circleImage(state),
                      SizedBox(height: 20),
                      RaisedButton.icon(
                      icon      : Icon(Icons.photo_camera,color: Colors.white), 
                      label     : Text('${state.actualizar ? 'Actulizar' : 'Selecionar'} Logo'),
                      color     : Get.theme.primaryColor,
                      textColor : Colors.white,
                      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onPressed : ()=>_buttomSheep(state), 
                )
             ]        
      ),
    );

 }

  _buttomSheep(FormEmpresaController state) {
     Get.defaultDialog(
      title  : 'Escoje tu Logo',
      content:Container(
              height : 150,
              width: 300,
              color  : Colors.white,
              child  : ListView(
                       children: [
                        ListTile(
                        leading: Icon(Icons.folder),
                        title: Text('Seleciona desde Archivo'),
                        onTap: ()=>state.getImage('archivo')
                        ),
                        ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text('Toma la foto'),
                        onTap: ()=>state.getImage('camara')
                        )
                       ]
                       ),
              )
     );
  }

Widget _datosCategoria(FormEmpresaController state) {
  return ListView.builder(
         padding: EdgeInsets.only(bottom: 100),
         itemCount: categorias.length,
         itemBuilder: (_,i){
            return ListTile(
                   leading:  CircleAvatar(
                             backgroundColor: state.idCategoria == categorias[i].id
                                              ?
                                              Colors.red
                                              :
                                              Colors.grey[400],
                             child          : Text('$i',style: TextStyle(color:Colors.white)),
                   ),
                   title: Text(categorias[i].nombre),
                   onTap: ()=>state.getCategoria(categorias[i]),
            );
         }
         );
}

Widget  _circleImage(FormEmpresaController state) {

if(state.image?.path == null && !state.actualizar) 
   return  CircleAvatar(
                      backgroundColor : Colors.grey[300],
                      radius          : 100,
                      child           : Icon(
                                        Icons.photo_camera,
                                        color : Colors.grey[400],
                                        size  : 100
                      )
                      );
if(state.image?.path != null)
  return ClipRRect(
         borderRadius: BorderRadius.circular(100),
         child:  FadeInImage(
                 height : 200,
                 width  : 200,
                 fit    : BoxFit.cover,
                 placeholder: AssetImage('assets/imagenes/load_image.png'), 
                 image: AssetImage(state.image.path)
                 ),
);
if(state.actualizar)
  return SizedBox(
         child: ClipRRect(
           borderRadius: BorderRadius.circular(300),
           child:  FadeInImage(
                   height : 200,
                   width  : 200,
                   fit    : BoxFit.cover,
                   placeholder: AssetImage('assets/imagenes/load_image.png'), 
                   image: NetworkImage('$urlImagenes/logo/${state.empresa.urlLogo}')
                   ),
),
  );

return Container();

}
}