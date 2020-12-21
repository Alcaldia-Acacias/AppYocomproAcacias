import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendEmailPage extends StatelessWidget {
  const SendEmailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text('Restablecer contraseña'),
                   elevation: 0,
           ),
           body: SingleChildScrollView(
                 padding: EdgeInsets.all(20),
                 child: GetBuilder<LoginController>(
                   builder: (state){
                    return Form(
                           key: state.formKeyRecovery,
                           child: Column(
                                  children: [
                                   if(!state.loading && !state.codigo)
                                   InputForm(
                                   controller  : state.emailRecoveryController,
                                   placeholder : 'Correo asociado a la cuenta',
                                   textHelp    : 'Envia el codigo de recuperacion al correo',
                                   isEmail     : true,
                                   requerido   : true
                                   ),
                                   if(state.loading && !state.codigo)
                                   Center(child: CircularProgressIndicator()),
                                   if(state.codigo)
                                   InputForm(
                                   controller  : state.codigoRecoveryController,
                                   placeholder : 'Ingrese el codigo',
                                   isEmail     : true,
                                   requerido   : true,
                                   textHelp    : 'Escribe el codigo que recibiste a tu correo,puede tardar un poco',
                                   ),
                                   if(state.codigo)
                                   RaisedButton(
                                   child    : Text('Verificar'),
                                   color    : Get.theme.primaryColor,
                                   textColor: Colors.white,
                                   onPressed: ()=>state.verficarCodigo()
                                   ),
                                   if(state.codigo)
                                   RaisedButton(
                                   child    : Text('Escribir otro correo'),
                                   color    : Get.theme.primaryColor,
                                   textColor: Colors.white,
                                   onPressed: ()=>state.resetSendEmail()
                                   )
                                   
                                   

                                  ]
                      ),
                    );
                   }
             ),
           ),
           floatingActionButton: FloatingActionButton.extended(
                                 label    : Text('Enviar',style:TextStyle(color: Colors.white)),
                                 icon     : Icon(Icons.send,color: Colors.white),
                                 backgroundColor: Get.theme.primaryColor,
                                 onPressed: ()=>Get.find<LoginController>().sendEmail()
           ),
    );
          
  }
}