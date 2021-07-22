import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
import 'package:comproacacias/src/componetes/productos/views/formproduct.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ListProductos extends StatelessWidget {
   ListProductos({Key key}) : super(key: key);
  final urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title     : Text('Tus Productos'),
                   elevation : 0,
           ),
           body  : GetBuilder<ProductosController>(
                   id: 'productos',
                   builder: (state){
                     if(state.loading)
                      return Center(child: CircularProgressIndicator());
                     if(state.productos.length == 0)
                      return Center(child: Text('No Hay Productos'));
                     return _listProductos(state);
                   },
           ),
           floatingActionButton: FloatingActionButton.extended(
                                 label           : Text('Crear',style: TextStyle(color: Colors.white)),
                                 icon            : Icon(Icons.add,color: Colors.white),
                                 backgroundColor : Get.theme.primaryColor,
                                 onPressed       : ()=>Get.to(FormProducto()),
                                 ),
    );
  }

  Widget _listProductos(ProductosController state) {
    return ListView.builder(
           padding     : EdgeInsets.all(8),
           itemCount   : state.productos.length,
           itemBuilder : (_,i){
             return _producto(state,i);
           }
    );
  }

  Widget _producto(ProductosController state, int i) {
    return Slidable(
           secondaryActions: <Widget>[
                               IconSlideAction(
                               caption : 'Editar',
                               color   : Get.theme.primaryColor,
                               icon    : Icons.edit,
                               onTap:  () => Get.to(FormProducto(update: true,producto: state.productos[i]))
                               ),
                               IconSlideAction(
                               caption : 'Eliminar',
                               color   : Colors.red,
                               icon    : Icons.delete,
                               onTap   :  () => _dialogoDeleteProducto(state,i)
                               ),
                               ],
             actionPane: SlidableDrawerActionPane(),
             child: ListTile(
                    isThreeLine : true,
                    title       : Text(state.productos[i].nombre),
                    subtitle    : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Precio: ${state.productos[i].precio}'),
                                    Text('Empresa: ${state.productos[i].empresa.nombre}')
                                  ],
                    ),
                    leading : ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: FadeInImage(
                                     height: 60,
                                     width : 60,
                                     fit: BoxFit.cover,
                                     placeholder: AssetImage('assets/imagenes/load_image.gif'),
                                     image: CachedNetworkImageProvider('$urlImagenes/galeria/${state.productos[i].imagenes[0]}'),
                              ),
                    )
             ),
    );
  }

  _dialogoDeleteProducto(ProductosController state, int i) {
    Get.defaultDialog(
    title : '¿ Desea Eliminar el producto ?',
    content: Container(),
    radius: 0,
    actions: [
       RaisedButton.icon(
        color     : Get.theme.primaryColor,
        icon      : Icon(Icons.delete), 
        label     : Text('Eliminar'),
        textColor : Colors.white,
        onPressed : ()=>state.deleteProducto(state.productos[i].id), 
        ),
        RaisedButton(
        child     : Text('cancelar'),
        color     : Colors.white,
        onPressed : ()=>Get.back(),
        )
    ] 
    );
  }
}