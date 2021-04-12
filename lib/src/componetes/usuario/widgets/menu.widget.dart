import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItemUsuario extends StatelessWidget {

  final String titulo;
  final IconData icon;
  final Function onTap;

  MenuItemUsuario({Key key, this.titulo, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
            child: Card(
                   elevation: 6,
                   child: Padding(
                          padding : EdgeInsets.all(8.0),
                          child   : GridTile(
                                    child: Icon(
                                           icon,
                                           size  : Get.height * 0.065,
                                           color : Colors.grey
                                    ),
                                    footer: Text(titulo,
                                            textAlign: TextAlign.center,
                                            
                                    )
                     ),
                   ),
                   shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                   ),
        
            ),
            onTap: onTap,
    );
  }
}