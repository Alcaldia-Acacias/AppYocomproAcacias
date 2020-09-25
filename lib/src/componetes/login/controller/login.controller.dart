import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';


class LoginController extends GetxController {


GlobalKey<FormState> formKeyLogin             = GlobalKey<FormState>();
TextEditingController usuarioLoginController  = TextEditingController();
TextEditingController passwordLoginController = TextEditingController();

FocusNode passwordFocoLogin = FocusNode();
FocusNode usuarioFocoLogin  = FocusNode();

GlobalKey<FormState>  formKeySingin                   = GlobalKey<FormState>();
TextEditingController usuarioSinginController         = TextEditingController();
TextEditingController nombreSinginController          = TextEditingController();
TextEditingController fechaSinginController           = TextEditingController();
TextEditingController passwordSinginController        = TextEditingController();
TextEditingController confirmPasswordSinginController = TextEditingController();


FocusNode usuarioFocoSingin         = FocusNode();
FocusNode nombreFocoSingin          = FocusNode();
FocusNode passwordFocoSingin        = FocusNode();
FocusNode confirmPasswordFocoSingin = FocusNode();

DateTime fechaNacimiento = DateTime.now();



void submitFormLogin(){
  print(usuarioLoginController.text);
}
void submitFormSingIn(){
  print(confirmPasswordSinginController.text);
  print(passwordSinginController.text);
  if(formKeySingin.currentState.validate() && this.comparePassword())
  print('listo');
  if(!this.comparePassword())
  Get.snackbar("Error", "no coinciden las contraseñas");
}

bool comparePassword(){
  if(passwordSinginController.text == confirmPasswordSinginController.text)
   return true;
  return false;
}

String formatFecha(DateTime fecha){
 if(!fecha.isNull)
 return DateFormat("dd MMMM 'del' yyyy")
                          .format(fecha);
 return '';

}

}