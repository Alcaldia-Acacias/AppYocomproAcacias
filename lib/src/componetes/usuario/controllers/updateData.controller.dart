import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class UpdateDataController extends GetxController {

TextEditingController nombreController          = TextEditingController();
TextEditingController fechaController           = TextEditingController();
TextEditingController usuarioController         = TextEditingController();


FocusNode nombreFoco = FocusNode();
FocusNode fechaFoco     = FocusNode();
FocusNode usuarioFoco = FocusNode();
  
GlobalKey<FormState> formKey = GlobalKey();


String formatFecha(DateTime fecha){
 if(fecha != null)
 return DateFormat("dd MMMM 'del' yyyy")
                          .format(fecha);
 return '';

}
}