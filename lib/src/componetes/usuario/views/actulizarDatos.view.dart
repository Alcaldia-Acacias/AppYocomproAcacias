import 'package:comproacacias/src/componetes/usuario/controllers/updateData.controller.dart';
import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDataUsuario extends StatelessWidget {
  
  final Usuario usuario;
  UpdateDataUsuario({Key key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text('Actualizar Datos'),
                   elevation: 0,
           ),
           body: GestureDetector(
                  onTap : ()=>FocusScope.of(context).unfocus(),
                  child : SingleChildScrollView(  
                          child : GetBuilder<UpdateDataController>(
                                  init: UpdateDataController(usuario:usuario,repositorio: UsuarioRepocitorio()),
                                  builder: (state){
                                    return Padding(
                                           padding: EdgeInsets.all(40.0),
                                           child: Form(
                                                  key: state.formKey,
                                                  child: Column(
                                                         children: <Widget>[
                                                            Image.asset(
                                                            'assets/imagenes/actualizado.png',
                                                             height : 180,
                                                             width  : 180,
                                                            ),
                                                            SizedBox(height: 20),
                                                             InputForm(
                                                            placeholder       : "Usuario",
                                                            controller        : state.usuarioController,
                                                            foco              : state.usuarioFoco,
                                                            leftIcon          : Icons.person,
                                                            requerido         : true,
                                                            isEmail           : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.nombreFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Nombre Completo",
                                                            controller        : state.nombreController,
                                                            foco              : state.nombreFoco,
                                                            leftIcon          : Icons.person_add,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>state.updateData()
                                                            ),
                                                           _button(state)
                                                         ],
                                             ) 
                                             ),
                                    );

                                  }
                                  )     
                  ),
           ),
    );
  }
   _button(UpdateDataController state) {
    return   MaterialButton(
             textColor : Colors.white,
             padding   : EdgeInsets.all(15),
             child     : Text('Actualizar Datos'),
             color     : Get.theme.primaryColor,
             minWidth  : double.maxFinite,
             onPressed :()=>state.updateData()
    );
  }
}