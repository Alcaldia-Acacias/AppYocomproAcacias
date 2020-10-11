import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InputForm extends StatelessWidget {

  final TextEditingController controller;
  final String placeholder;
  final IconData leftIcon,rightIcon;
  final FocusNode foco;
  final bool lastInput,requerido,obscure,isEmail,readOnly,isButtonIcon;
  final Function onEditingComplete,onButtonIcon;
 



  InputForm({
  Key key, 
  this.placeholder, 
  this.leftIcon, 
  this.rightIcon, 
  this.foco, 
  this.controller,
  this.lastInput = false,
  this.obscure   = false,
  this.requerido = false,
  this.isEmail   = false,
  this.readOnly  = false,
  this.isButtonIcon  = false,
  this.onEditingComplete,
  this.onButtonIcon
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
             readOnly          : readOnly,
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
                                 suffixIcon     : rightIcon == null
                                                  ?
                                                  null
                                                  :
                                                  isButtonIcon
                                                  ?
                                                  IconButton(
                                                  icon: Icon(rightIcon), 
                                                  onPressed: onButtonIcon
                                                  )
                                                  :
                                                  Icon(rightIcon),
                                 prefixIcon      :leftIcon == null
                                                  ?
                                                  null
                                                  :
                                                  isButtonIcon
                                                  ?
                                                  IconButton(
                                                  icon: Icon(leftIcon), 
                                                  onPressed: onButtonIcon
                                                  )
                                                  :
                                                  Icon(leftIcon),
                                 contentPadding : EdgeInsets.all(10),
                                 hintText       : placeholder,
                                 border         : OutlineInputBorder()
             ),
             validator         : (texto){
                                 if(texto.isEmpty && requerido) 
                                   return "es requerido";
                                 if((!GetUtils.isEmail(texto) && !GetUtils.hasMatch(texto,r'^[3]{1}[0-8]{2}\d{7}')) && isEmail) 
                                   return "no es un correo valido";
                                 
                                 return null;
                                    
             },
      ),
    );
  }
}
