import 'package:comproacacias/src/componetes/productos/views/formproduct.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListProductos extends StatelessWidget {
  const ListProductos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title     : Text('Tus Productos'),
                   elevation : 0,
           ),
           body  : Center(child: Text('No hay productos')),
           floatingActionButton: FloatingActionButton.extended(
                                 label           : Text('Crear',style: TextStyle(color: Colors.white)),
                                 icon            : Icon(Icons.add,color: Colors.white),
                                 backgroundColor : Get.theme.primaryColor,
                                 onPressed       : ()=>Get.to(FormProducto()),
                                 ),
    );
  }
}