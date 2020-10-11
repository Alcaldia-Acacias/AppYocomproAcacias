import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ChangePasswordController extends GetxController {


TextEditingController currentPasswordController = TextEditingController();
TextEditingController newPasswordController     = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

FocusNode currentPasswordFoco = FocusNode();
FocusNode newPasswordFoco     = FocusNode();
FocusNode confirmPasswordFoco = FocusNode();
  
GlobalKey<FormState> formKey = GlobalKey();





}