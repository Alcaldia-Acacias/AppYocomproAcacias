import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class LoginFormPage extends StatelessWidget {
  const LoginFormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar( 
                   title   : Text('Iniciar Sesion'),
                   elevation: 0,

           ),
           body : GestureDetector(
                  onTap : ()=>FocusScope.of(context).unfocus(),
                  child : SingleChildScrollView(
                          child : GetBuilder<LoginController>(
                                  builder: (state){
                                    return Padding(
                                           padding: EdgeInsets.all(40.0),
                                           child: Form(
                                                  key  : state.formKey,
                                                  child: Column(
                                                         children: <Widget>[
                                                            Image.asset(
                                                           'assets/imagenes/logo.png',
                                                            height : 300,
                                                            width  : 300,
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Usuario",
                                                            controller        : state.usuarioController,
                                                            foco              : state.usuarioFoco,
                                                            requerido         : true,
                                                            isEmail           : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.passwordFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder : "Contraseña",
                                                            controller  : state.passwordController,
                                                            foco        : state.passwordFoco,
                                                            obscure     : true,
                                                            lastInput   : true,
                                                            requerido   : true,
                                                            onEditingComplete: ()=> _submit(state.formKey),
                                                            ),
                                                            MaterialButton(
                                                            textColor: Colors.white,
                                                            padding: EdgeInsets.all(20),
                                                            child: Text('Ingresar'),
                                                            color: Get.theme.primaryColor,
                                                            minWidth: double.maxFinite,
                                                            onPressed:() => _submit(state.formKey)
                                                            )

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

  _submit(GlobalKey<FormState> formKey) {
    if(formKey.currentState.validate())
     print('hola');
  }
}