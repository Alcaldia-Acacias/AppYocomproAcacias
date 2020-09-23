import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  const AppBarCustom({Key key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
           leading : Image.asset('asstes/imagenes/logo.png'),
           title   : Text(title),
           backgroundColor: Colors.white,
          brightness      : Brightness.light,
    );
  }
}



