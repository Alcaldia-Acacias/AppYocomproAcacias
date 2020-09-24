import 'package:flutter/material.dart';

class RegistroFormPage extends StatelessWidget {
  const RegistroFormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   actions: <Widget>[
                     Image.asset('assets/imagenes/logo.png'),
                   ], 
                   title   : Text('Registrece'),
                   elevation: 0,

           ),
    );
  }
}