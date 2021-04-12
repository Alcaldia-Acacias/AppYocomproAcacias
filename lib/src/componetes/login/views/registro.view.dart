
import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegistroFormPage extends StatelessWidget {
  const RegistroFormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar( 
                   title   : Text('Crear Cuenta'),
                   elevation: 0,

           ),
           body : GestureDetector(
                  onTap : ()=>FocusScope.of(context).unfocus(),
                  child : SingleChildScrollView(
                          padding: EdgeInsets.all(40),
                          child : GetBuilder<LoginController>(
                                  builder: (state){
                                    return Form(
                                           key  : state.formKeySingin,
                                           child: Column(
                                                  children: <Widget>[
                                                     Image.asset(
                                                    'assets/imagenes/logo.png',
                                                     height : Get.width * 0.5,
                                                     width  : 270,
                                                     ),
                                                     InputForm(
                                                     placeholder       : "Usuario",
                                                     controller        : state.usuarioSinginController,
                                                     foco              : state.usuarioFocoSingin,
                                                     leftIcon          : Icons.person,
                                                     requerido         : true,
                                                     isEmail           : true,
                                                     onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.nombreFocoSingin)
                                                     ),
                                                     InputForm(
                                                     placeholder       : "Nombre Completo",
                                                     controller        : state.nombreSinginController,
                                                     foco              : state.nombreFocoSingin,
                                                     leftIcon          : Icons.person_add,
                                                     requerido         : true,
                                                     onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.cedulaFocoSingin)
                                                     ),
                                                     InputForm(
                                                     placeholder       : "Cedula",
                                                     controller        : state.cedulaSinginController,
                                                     leftIcon          : Icons.credit_card,
                                                     foco              : state.cedulaFocoSingin,
                                                     requerido         : true,
                                                     onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.passwordFocoSingin)
                                                     ),
                                                     InputForm(
                                                     placeholder       : "Contraseña",
                                                     controller        : state.passwordSinginController,
                                                     foco              : state.passwordFocoSingin,
                                                     obscure           : true,
                                                     leftIcon          : Icons.lock_outline,
                                                     requerido         : true,
                                                     onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.confirmPasswordFocoSingin)
                                                     ),
                                                     InputForm(
                                                     placeholder       : "Confirmar contraseña",
                                                     controller        : state.confirmPasswordSinginController,
                                                     foco              : state.confirmPasswordFocoSingin,
                                                     leftIcon          : Icons.lock,
                                                     obscure           : true,
                                                     lastInput         : true,
                                                     requerido         : true,
                                                     onEditingComplete : ()=> _submit(),
                                                     ),
                                                     _buttonSubmit()

                                                  ],
                                      ) 
                                      );

                                  }
                                  )     
                  ),
           ),
    );
  }
 Widget _buttonSubmit() {
    return   MaterialButton(
             textColor : Colors.white,
             padding   : EdgeInsets.all(15),
             child     : Text('Crear Cuenta'),
             color     : Get.theme.primaryColor,
             minWidth  : double.maxFinite,
             onPressed :() => _submit()
    );
  }
   _submit() {
       Get.find<LoginController>().submitFormSingIn();
  }
}