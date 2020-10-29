import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogImagePicker {
  static openDialog(
      {String titulo,
      Function onTapArchivo,
      Function onTapCamera}) {
    Get.defaultDialog(
        title: titulo,
        content: Container(
          height: 150,
          width: 300,
          color: Colors.white,
          child: ListView(children: [
            ListTile(
                leading: Icon(Icons.folder),
                title: Text('Seleciona desde Archivo'),
                onTap: onTapArchivo
            ),
            ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Toma la foto'),
                onTap: onTapCamera
          )]),
        ));
  }
}