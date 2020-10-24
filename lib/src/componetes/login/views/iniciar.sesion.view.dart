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
                                                  key  : state.formKeyLogin,
                                                  child: Column(
                                                         children: <Widget>[
                                                            Image.asset(
                                                           'assets/imagenes/logo.png',
                                                            height : Get.width * 0.5,
                                                            width  : 270,
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Usuario",
                                                            controller        : state.usuarioLoginController,
                                                            foco              : state.usuarioFocoLogin,
                                                            leftIcon          : Icons.person,
                                                            requerido         : true,
                                                            isEmail           : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.passwordFocoLogin)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Contraseña",
                                                            controller        : state.passwordLoginController,
                                                            foco              : state.passwordFocoLogin,
                                                            leftIcon          : Icons.lock_outline,
                                                            obscure           : true,
                                                            lastInput         : true,
                                                            requerido         : true,
                                                            onEditingComplete : ()=> _submit(),
                                                            ),
                                                            _olvidoPassword(),
                                                            _buttonSubmit(state.loading)

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
  _buttonSubmit(bool loading) {
    return   MaterialButton(
             textColor : Colors.white,
             padding   : EdgeInsets.all(15),
             child     : loading ? Center(child:CircularProgressIndicator()) : Text('Ingresar'),
             color     : loading ?Colors.white : Get.theme.accentColor,
             minWidth  : double.maxFinite,
             onPressed :() => _submit()
    );
  }
   _submit() {
       Get.find<LoginController>().submitFormLogin();
  }

  _olvidoPassword() {
    return GestureDetector(
           child: Container(
                  height    : 30,
                  alignment : Alignment.topRight,
                  child     :Text('Olvido su contraseña ?',style:TextStyle(color: Colors.blue))
                  ),
           onTap: ()=>print('olvide')
    );
  }

}