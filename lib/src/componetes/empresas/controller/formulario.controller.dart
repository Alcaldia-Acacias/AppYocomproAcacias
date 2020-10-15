import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FormEmpresaController extends GetxController {
  
final EmpresaRepositorio repositorio;

FormEmpresaController({this.repositorio});


TextEditingController nombreController      = TextEditingController();
TextEditingController descripcionController = TextEditingController();
TextEditingController direccionController   = TextEditingController();
TextEditingController telefonoController    = TextEditingController();
TextEditingController whatsappController    = TextEditingController();
TextEditingController emailController       = TextEditingController();
TextEditingController webController         = TextEditingController();
TextEditingController latitudController     = TextEditingController();
TextEditingController longitudController    = TextEditingController();
TextEditingController nitController         = TextEditingController();

FocusNode nombreFoco      = FocusNode();
FocusNode descripcionFoco = FocusNode();
FocusNode direccionFoco   = FocusNode();
FocusNode telefonoFoco    = FocusNode();
FocusNode whatsappFoco    = FocusNode();
FocusNode emailFoco       = FocusNode();
FocusNode webFoco         = FocusNode();
FocusNode latitudFoco     = FocusNode();
FocusNode longitudFoco    = FocusNode();
FocusNode nitFoco         = FocusNode();

GlobalKey<FormState> formKey= GlobalKey<FormState>();

}
