import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (state) {
      return Scaffold(
             body: Center(
             child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                               Text('No hay conexion a internet'),
                               RaisedButton(
                                   child     : Text('Reintentar'),
                                   textColor : Colors.white,
                                   color     : Get.theme.primaryColor,
                                   onPressed : () => state.internetCheck()
                               )
            ],
          ),
        ),
      );
    });
  }
}
