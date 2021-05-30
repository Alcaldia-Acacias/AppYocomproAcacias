import 'package:flutter/material.dart';

class ButtonAppleSing extends StatelessWidget {
  final String texto;
  final Function onTap;
  const ButtonAppleSing({Key key, @required this.texto,@required this.onTap}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: Card( 
                  color: Colors.black87,  
                  child: Padding(
                        padding :  EdgeInsets.all(10.0),
                        child   : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Image.asset('assets/imagenes/apple.png',width: 30,height: 30),
                                  SizedBox(width:10),
                                  Text(texto,style: TextStyle(color: Colors.white))              
                                  ],
                        ),
                  ),
           ),
           onTap: onTap,
    );
  }
}