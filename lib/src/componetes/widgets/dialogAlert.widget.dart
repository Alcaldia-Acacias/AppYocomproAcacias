import 'package:flutter/material.dart';

class AlertDialogLoading extends StatelessWidget {
  final String titulo;
  const AlertDialogLoading({Key key, this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor : Colors.transparent,
      
      content         : SizedBox(
      height          : 40, child: Center(child: CircularProgressIndicator())),
      title           : Text(titulo, textAlign: TextAlign.center),
      titleTextStyle  : TextStyle(color: Colors.white, fontSize: 25),
      elevation       : 0,
    );
  }
}

