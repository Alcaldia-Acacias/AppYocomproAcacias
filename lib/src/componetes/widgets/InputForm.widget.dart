import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InputForm extends StatelessWidget {

  final TextEditingController controller;
  final String placeholder;
  final IconData icon;
  final FocusNode foco;
  final bool lastInput,requerido,obscure,isEmail;
  final Function onEditingComplete;

  InputForm({
  Key key, 
  this.placeholder, 
  this.icon, 
  this.foco, 
  this.controller,
  this.lastInput = false,
  this.obscure   = false,
  this.requerido = false,
  this.isEmail   = false,
  this.onEditingComplete
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
             focusNode         : foco,
             textInputAction   : lastInput
                                 ?
                                 TextInputAction.done
                                 :
                                 TextInputAction.next,
             obscureText       : obscure,
             controller        : controller,
             onEditingComplete : onEditingComplete,
             decoration        : InputDecoration(
                                 hintText : placeholder,
                                 border   : OutlineInputBorder()
             ),
             validator         : (texto){

                                 if(texto.isEmpty && requerido) return "es requerido";
                                 if(!GetUtils.isEmail(texto) && isEmail) return "no es un correo valido";
                                    
             },
      ),
    );
  }
}
