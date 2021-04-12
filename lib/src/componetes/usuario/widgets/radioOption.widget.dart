import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RadioOptionHelp extends StatelessWidget {

  final int valueradio;
  final int value;
  final Function onChange;
  final String titulo;

  RadioOptionHelp({Key key,this.valueradio,this.value,this.onChange,this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
           children: [
             Radio(
             value      : value, 
             groupValue : valueradio, 
             onChanged  : onChange,
             activeColor: Get.theme.primaryColor
             ),
             Text(titulo)
           ],
    );
  }
}