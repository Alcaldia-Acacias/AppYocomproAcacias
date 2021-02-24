import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
class InicioPage extends StatelessWidget {
  const InicioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.grey[100],
           appBar: AppBar(
                   title: TextField(
                          //controller : state.searchController,
                          style      : TextStyle(fontSize: 18),
                          autofocus  : true,
                          decoration : InputDecoration(
                                       hintText   : "Buscar",
                                       hintStyle  : TextStyle(fontSize: 15),
                                       border     : InputBorder.none,
                                       suffixIcon : Icon(Icons.search)
                          ),
                          //onChanged  : (value) => state.searchEmpresa()
                   ),
                   elevation: 0,
                   actions: [
                     _butonIconNotification(),
                     SizedBox(width: 15),
                   ],
           ),
           body: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
                   crossAxisAlignment : CrossAxisAlignment.start,
                   children: [
                       _titulo('Nuestros videos'),
                       _videos(),
                       _titulo('Top 10'),
                       _top()
                   ],
               ),
           ),
           
    );
   
  }

  _videos() {
    return Container(
           color: Colors.white,
           padding: EdgeInsets.all(15),
           height: Get.height * 0.25,
           child: ListView(
                 scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                        width: 300,
                        color: Colors.red,
                    ),
                    SizedBox(width: 30),
                    Container(
                        width: 300,
                        color: Colors.blue,
                    ),
                    Container(
                        width: 300,
                        color: Colors.green,
                    ),
                  ], 
           ), 
    );
  }

  _top() {
    return Expanded(
           child: Center(
                  child: Text('empresas'),
           )
           );
  }

  _butonIconNotification() {
    return Badge(
           badgeContent : Text('4',style: TextStyle(color: Colors.white,fontSize: 13)),
           position     : BadgePosition(top: 3,start: 28),
           badgeColor   : Colors.red,
           child        : IconButton(
                          icon      : Icon(Icons.notifications_outlined),
                          color     : Colors.grey,
                          iconSize  : 30,
                          onPressed : (){}
           ),
    );
  }

  _titulo(String titulo) {
    return Padding(
           padding:  EdgeInsets.all(8.0),
           child: Text(titulo,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
   );
  }
}