import 'package:animate_do/animate_do.dart';
import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:comproacacias/src/componetes/login/views/iniciar.sesion.view.dart';
import 'package:comproacacias/src/componetes/login/views/registro.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(
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
                          : Get.to(RegistroFormPage());
                        },
        
     ),
          ),
   );
 }
}