import 'package:flutter/material.dart';

class ButtonSocialSing extends StatelessWidget {

  final String   texto;
  final String   logo;
  final Function onPress;
  final double   fontSize;
  final bool centerText;
  const ButtonSocialSing({Key key, this.texto, this.onPress, this.logo, this.fontSize,this.centerText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
           child: ListTile(
                  leading  : Image.asset(logo,width: 40,height: 40),
                  title    : Text(texto,
                             textAlign: centerText ? TextAlign.center : null,
                             style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize ?? 14,
                             ),
                  ),
                  onTap    : onPress,
           ),
           shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
           ),
           );
  }
}
