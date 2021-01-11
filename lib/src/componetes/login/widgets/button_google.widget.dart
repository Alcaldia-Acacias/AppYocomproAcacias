import 'package:flutter/material.dart';

class ButtonGoggle extends StatelessWidget {
  final String texto;
  final Function onPress;
  const ButtonGoggle({Key key, this.texto, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
           child: ListTile(
                  leading        : Image.asset('assets/imagenes/google_icon.jpg',width: 40,height: 40),
                  title          : Text(
                                    texto,
                                    style: TextStyle(
                                           color: Colors.grey[600],
                                           fontWeight: FontWeight.bold
                                    ),
                                   ),
                  onTap          : onPress,
           ),
           shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
           ),
           );
  }
}
