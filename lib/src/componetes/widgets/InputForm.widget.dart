import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InputForm extends StatelessWidget {

  final TextEditingController controller;
  final String placeholder,textHelp,initialValue;
  final IconData leftIcon,rightIcon;
  final FocusNode foco;
  final bool lastInput,requerido,obscure,isEmail,readOnly,isButtonIcon,textarea,autofocus,textcenter,enabled;
  final Function onEditingComplete,onButtonIcon;
 


  InputForm({
  Key key, 
  this.placeholder,
  this.initialValue,
  this.textHelp,
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
  this.textarea = false,
  this.autofocus   = false,
  this.textcenter = false,
  this.enabled = true,
  this.onEditingComplete,
  this.onButtonIcon,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
             key               : ValueKey(placeholder),
             enabled           : enabled,
             initialValue      : initialValue,
             textAlign         : textcenter ? TextAlign.center : TextAlign.start,
             readOnly          : readOnly,
             focusNode         : foco,
             autofocus         : autofocus,
             textInputAction   : lastInput
                                 ?
                                 TextInputAction.done
                                 :
                                 TextInputAction.next,
             maxLines          : textarea ? null : 1,
             keyboardType      : textarea ? TextInputType.multiline : null,
             obscureText       : obscure,
             controller        : controller,
             onEditingComplete : onEditingComplete,
             decoration        : InputDecoration(
                                 suffixIcon       : rightIcon == null
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
                         
                                 hintText       : placeholder,
                                 helperText     : textHelp,
                                 helperMaxLines : 3,
                                 border         : OutlineInputBorder()
             ),
             validator         : (texto){
                                 if(texto.isEmpty && requerido) 
                                   return "es requerido";
                                 if((!GetUtils.isEmail(texto) && !GetUtils.hasMatch(texto,r'^[3]{1}[0-8]{2}\d{7}')) && isEmail)
                                   return "no es un correo o numero valido";
                                /*  if((!GetUtils.hasMatch(texto,r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$')) && obscure)
                                   return "no es una contraseña valida"; */
                                 return null;
                                    
             },
      ),
    );
  }
}
