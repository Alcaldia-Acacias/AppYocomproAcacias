import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogImagePicker {
  static openDialog(
      {String titulo,
      Function onTapArchivo,
      Function onTapCamera,
      Function complete}) {
    Get.defaultDialog(
        title: titulo,
        content: Container(
          height: 150,
          width: 300,
          color: Colors.white,
          child: ListView(children: [
            ListTile(
                leading: Icon(Icons.folder),
                title: Text('Selecciona desde galeria'),
                onTap: onTapArchivo),
            ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Toma la foto'),
                onTap: onTapCamera)
          ]),
        )).whenComplete(complete);
  }
}
