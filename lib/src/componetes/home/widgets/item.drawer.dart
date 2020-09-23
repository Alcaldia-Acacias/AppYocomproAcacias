import 'package:comproacacias/src/componetes/home/models/menu.model.dart';
import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {

  final MenuDrawer menu;
  final Function(int page) ontap;
  
  const ItemDrawer({this.menu,this.ontap,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (menu.activate == null || menu.activate == true)
      return ListTile(
             title   : Text(menu.titulo),
             leading : Icon(menu.icono, color: Colors.green[300]),
             onTap   : () {
                            ontap(menu.page);
                            Navigator.pop(context);
             },
      );
    else
      return Container();
  }
}