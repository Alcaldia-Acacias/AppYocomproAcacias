import 'package:comproacacias/src/componetes/usuario/controllers/updateData.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDataUsuario extends StatelessWidget {
  const UpdateDataUsuario({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text('Actulizar Datos'),
           ),
           body: GestureDetector(
                  onTap : ()=>FocusScope.of(context).unfocus(),
                  child : SingleChildScrollView(
                          child : GetBuilder<UpdateDataController>(
                                  init: UpdateDataController(),
                                  builder: (state){
                                    return Padding(
                                           padding: EdgeInsets.all(40.0),
                                           child: Form(
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
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Fecha Nacimiento",
                                                            controller        : state.fechaController,
                                                            requerido         : true,
                                                            readOnly          : true,
                                                            isButtonIcon      : true,
                                                            rightIcon         : Icons.date_range,
                                                            onButtonIcon      : (){
                                                              showDatePicker(
                                                              locale: Locale('es'),
                                                              context: context, 
                                                              initialDate: DateTime.now(), 
                                                              firstDate: DateTime(1900), 
                                                              lastDate: DateTime(2050),
                                                              ).then((fecha){
                                                                state.fechaController.text = state.formatFecha(fecha);
                                                              });
                                                            },
                                                            ),
                                                           _button()
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
   _button() {
    return   MaterialButton(
             textColor : Colors.white,
             padding   : EdgeInsets.all(15),
             child     : Text('Actulizar Datos'),
             color     : Get.theme.primaryColor,
             minWidth  : double.maxFinite,
             onPressed :(){}
    );
  }
}