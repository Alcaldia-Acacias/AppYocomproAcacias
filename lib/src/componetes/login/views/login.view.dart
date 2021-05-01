
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:comproacacias/src/componetes/login/data/login.repositorio.dart';
import 'package:comproacacias/src/componetes/login/views/iniciar.sesion.view.dart';
import 'package:comproacacias/src/componetes/login/views/registro.view.dart';
import 'package:comproacacias/src/componetes/login/widgets/button_apple.dart';
import 'package:comproacacias/src/componetes/login/widgets/button_google.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(
           init: LoginController(repositorio: LoginRepositorio()),
           builder: (state){
              return Scaffold(
                     body:  Stack(
                             children: <Widget>[
                                   _cortina(),
                                   _logo(),
                                   _button('Iniciar Sesión'),
                                   _button('Registrate'),
                                 
                             ],
                             ),
              );
           }
           );
}
Widget  _cortina() {
  return  SlideInDown(
          //manualTrigger: true,
          //controller   : (controller)=> Get.find<HomeController>().controller = controller,
          delay        : Duration(milliseconds: 100),
          duration     : Duration(milliseconds: 300),
          child        : Image.asset('assets/imagenes/cortina.png')
          );
}

Widget _logo() {
  return  Container(
          margin    : EdgeInsets.only(top:40),
          alignment : Alignment(0.0,-0.8),
          child     : Image.asset(
                     'assets/imagenes/logo.png',
                      width  : 250,
                      height : 250,
          ),
  );
}

 Widget _button(String titulo) {
   return Align(
          alignment : titulo == 'Iniciar Sesión'
                      ?
                      Alignment(0.0,0.45)
                      :
                      Alignment(0.0,0.7),
          child     : SizedBox(
                      width: Get.width * 0.7,
                      child: RaisedButton(
                        textColor : Colors.white,
                        padding   : EdgeInsets.all(18),
                        color     : titulo == 'Iniciar Sesión'
                                    ?
                                    Get.theme.accentColor
                                    :
                                    Get.theme.primaryColor,
                        child     : Text(titulo,style: TextStyle(fontSize: 20)),
                        shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        onPressed :(){
                          titulo == 'Iniciar Sesión' 
                          ? Get.to(LoginFormPage())
                          : dialogOptionRegistro();
                          //: Get.to(RegistroFormPage());
                        },
        
     ),
          ),
   );
 }
 void dialogOptionRegistro(){
   Get.defaultDialog(
   backgroundColor: Colors.grey[200],
   radius: 10,
   title: 'Regístrate',
   content: Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(   
            children: [
                SizedBox(
                width: Get.width * 0.7,
                child: RaisedButton(
                       textColor : Colors.white,
                       padding   : EdgeInsets.all(18),
                       color     : Get.theme.primaryColor,
                       child     : Text('Ingresa tus Datos',style: TextStyle(fontSize: 20)),
                       shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                       onPressed :()=>Get.to(RegistroFormPage()),
                )
                ),
                SizedBox(height: 20),
                ButtonSocialSing(
                logo    : 'assets/imagenes/google_icon.jpg',
                texto   : 'Regístrate con Google',
                onPress : ()=>Get.find<LoginController>().singInGoogleUsuario(),
                ),
                SizedBox(height: 20),
                ButtonSocialSing(
                logo    : 'assets/imagenes/facebook_icon.png',
                texto   : 'Regístrate con Facebook',
                onPress : ()=>Get.find<LoginController>().singInFacebookUsuario()
                ),
                SizedBox(height: 20),
                if(Platform.isIOS)
                ButtonAppleSing(
                texto: 'Registrarse con Apple', 
                onTap: ()=>Get.find<LoginController>().singInAppleUsuario()
                )
                /* ButtonSocialSing(
                logo    : 'assets/imagenes/apple.png',
                texto   : 'Regístrate con Apple',
                onPress : ()=>Get.find<LoginController>().singInAppleUsuario()
                ) */
              ],
     ),
   )
   );
 }
}