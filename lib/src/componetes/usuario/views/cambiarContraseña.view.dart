import 'package:comproacacias/src/componetes/usuario/controllers/changePassword.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CambiarPasswordPage extends StatelessWidget {
  const CambiarPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text('Cambiar Contraseña'),
           ),
           body: GestureDetector(
                  onTap : ()=>FocusScope.of(context).unfocus(),
                  child : SingleChildScrollView(
                          child : GetBuilder<ChangePasswordController>(
                                  init: ChangePasswordController(),
                                  builder: (state){
                                    return Padding(
                                           padding: EdgeInsets.all(40.0),
                                           child: Form(
                                                  child: Column(
                                                         children: <Widget>[
                                                            Image.asset(
                                                            'assets/imagenes/llave.png',
                                                             height : 180,
                                                             width  : 180,
                                                            ),
                                                            SizedBox(height: 20),
                                                            InputForm(
                                                            placeholder       : "Contraseña Actual",
                                                            controller        : state.currentPasswordController,
                                                            foco              : state.currentPasswordFoco,
                                                            leftIcon          : Icons.lock_open,
                                                            requerido         : true,
                                                            isEmail           : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.newPasswordFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Contraseña Nueva",
                                                            controller        : state.newPasswordController,
                                                            foco              : state.newPasswordFoco,
                                                            leftIcon          : Icons.lock_outline,
                                                            obscure           : true,
                                                            lastInput         : true,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.confirmPasswordFoco),
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Confirmar Contraseña",
                                                            controller        : state.confirmPasswordController,
                                                            foco              : state.confirmPasswordFoco,
                                                            leftIcon          : Icons.lock_outline,
                                                            obscure           : true,
                                                            lastInput         : true,
                                                            requerido         : true,
                                                            onEditingComplete : (){},
                                                            ),
                                                            _buttonCambiar()
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
   _buttonCambiar() {
    return   MaterialButton(
             textColor : Colors.white,
             padding   : EdgeInsets.all(15),
             child     : Text('Cambiar'),
             color     : Get.theme.primaryColor,
             minWidth  : double.maxFinite,
             onPressed :() {}
    );
  }
}