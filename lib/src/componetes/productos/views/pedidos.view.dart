
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
import 'package:comproacacias/src/componetes/productos/models/pedido.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PedidosPage extends StatelessWidget {
   
  PedidosPage({Key key}) : super(key: key);
  final urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   elevation : 0,
                   title     : Text('Pedidos'),
           ),
           body: GetBuilder<ProductosController>(
                 id: 'pedidos',
                 builder: (state){
                   return ListView.separated(
                          padding     : EdgeInsets.all(30),
                          itemCount   : state.pedidos.length,
                          separatorBuilder: (_,i)=>SizedBox(height: 30),
                          itemBuilder : (_,i){
                            return _cardPedido(state.pedidos[i]);
                          }
                          );
                }
                ),
    );
  }

  Widget _cardPedido(Pedido pedido) {
    return Container(
           clipBehavior : Clip.antiAlias,
           height       : 400,
           width        : 200,
           decoration   : BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey[400])
           ),
           child      : Column(
                        children:<Widget>[
                          _empresa(pedido.productos[0].empresa),
                          _divider(),
                          _pedidos(pedido.productos),
                          _divider(),
                          _bottonPedir(pedido)
                        ],
           ),
    );
  }

  Widget _empresa(Empresa empresa) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Row(
             children: [
               CircleAvatar(
               backgroundImage: CachedNetworkImageProvider('$urlImagenes/logo/${empresa.urlLogo}'),  
               radius: 30,
               ),
               SizedBox(width: 30),
               Text('${empresa.nombre}'),
             ],
      ),
    );
  }

 Widget _divider() {
   return  Divider(
           height    : 2,
           color     : Colors.grey[400],
           thickness : 1
           );
 }

Widget  _pedidos(List<Producto> productos) {
  return Expanded(
         child : ListView.separated(
                 itemCount: productos.length,
                 separatorBuilder: (_,i)=>SizedBox(height:10),
                 itemBuilder: (_,i){
                   return ListTile(
                          isThreeLine: true,
                          leading : CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider('$urlImagenes/galeria/${productos[i].imagenes[0]}'),
                                    radius: 40,
                          ),
                          title: Text('${productos[i].nombre}'),
                          subtitle: Text('Cantidad: ${productos[i].cantidad}           Precio: \u0024 ${productos[i].precio}'),
                          trailing: IconButton(
                                    icon      : Icon(Icons.delete),
                                    color     : Colors.red,
                                    onPressed : ()=>Get.find<ProductosController>().deleteProductoOf(i,productos[i].empresa.id),
                          ),
                   );
                 }
                 ) ,
  );
}

Widget _bottonPedir(Pedido pedido) {
  return GestureDetector(
         child: Container(
                height : 60,
                color  : Get.theme.primaryColor,
                child  : Center(child: Text('Hacer Pedido',style:TextStyle(color: Colors.white))),
         ),
         onTap: ()=>_dialogoObservacion(pedido)
  );
}

  _dialogoObservacion(Pedido pedido) {
    Get.defaultDialog(
    title   : 'Escribe una Observacion',
    content : InputForm(
              controller: Get.find<ProductosController>().controllerObservacion,
              textarea: true,
              placeholder: 'Observacion',

    ),
    actions: [
      RaisedButton(
      color    : Get.theme.primaryColor,
      child    : Text('Pedir'),
      textColor: Colors.white,
      onPressed: () {
        Get.find<ProductosController>().sendPedido(pedido);
        Get.back();
      }
      )
    ]
    ).whenComplete(() => Get.snackbar('Pedido Realizado',''));
  }

  /* 
  
class PedidosPage extends StatelessWidget {
   
  PedidosPage({Key key}) : super(key: key);
  final urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosController>(
           id: 'pedidos',
           builder: (state){
             return DefaultTabController(
               length: 2,
                            child: Scaffold(
               appBar: AppBar(
                       elevation : 0,
                       title     : Text('Pedidos'),
                       bottom: TabBar(
                               tabs: [
                                _itemOpcion('Pendientes',false),
                                _itemOpcion('Realizados',true),
                               ],
                       ),
               ),
               body: TabBarView(
                     children: [
                       _listaPedidosPendientes(state),
                       _listaPedidosPendientes(state)
                     ],
               )
            ),
             );
           }, 
    );
  }

  Widget _cardPedido(Pedido pedido) {
    return Container(
           clipBehavior : Clip.antiAlias,
           height       : 400,
           width        : 200,
           decoration   : BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey[400])
           ),
           child      : Column(
                        children:<Widget>[
                          _empresa(pedido.productos[0].empresa),
                          _divider(),
                          _pedidos(pedido.productos),
                          _divider(),
                          _bottonPedir(pedido)
                        ],
           ),
    );
  }

  Widget _empresa(Empresa empresa) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Row(
             children: [
               CircleAvatar(
               backgroundImage: CachedNetworkImageProvider('$urlImagenes/logo/${empresa.urlLogo}'),  
               radius: 30,
               ),
               SizedBox(width: 30),
               Text('${empresa.nombre}'),
             ],
      ),
    );
  }

 Widget _divider() {
   return  Divider(
           height    : 2,
           color     : Colors.grey[400],
           thickness : 1
           );
 }

Widget  _pedidos(List<Producto> productos) {
  return Expanded(
         child : ListView.separated(
                 itemCount: productos.length,
                 separatorBuilder: (_,i)=>SizedBox(height:10),
                 itemBuilder: (_,i){
                   return ListTile(
                          isThreeLine: true,
                          leading : CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider('$urlImagenes/galeria/${productos[i].imagenes[0]}'),
                                    radius: 40,
                          ),
                          title: Text('${productos[i].nombre}'),
                          subtitle: Text('Cantidad: ${productos[i].cantidad}           Precio: \u0024 ${productos[i].precio}'),
                          trailing: IconButton(
                                    icon      : Icon(Icons.delete),
                                    color     : Colors.red,
                                    onPressed : ()=>Get.find<ProductosController>().deleteProductoOf(i,productos[i].empresa.id),
                          ),
                   );
                 }
                 ) ,
  );
}

Widget _bottonPedir(Pedido pedido) {
  return GestureDetector(
         child: Container(
                height : 60,
                color  : Get.theme.primaryColor,
                child  : Center(child: Text('Hacer Pedido',style:TextStyle(color: Colors.white))),
         ),
         onTap: ()=>_dialogoObservacion(pedido)
  );
}

  _dialogoObservacion(Pedido pedido) {
    Get.defaultDialog(
    title   : 'Escribe una Observacion',
    content : InputForm(
              controller: Get.find<ProductosController>().controllerObservacion,
              textarea: true,
              placeholder: 'Observacion',

    ),
    actions: [
      RaisedButton(
      color    : Get.theme.primaryColor,
      child    : Text('Pedir'),
      textColor: Colors.white,
      onPressed: () {
        Get.find<ProductosController>().sendPedido(pedido);
        Get.back();
      }
      )
    ]
    ).whenComplete(() => Get.snackbar('Pedido Realizado',''));
  }

  _listaPedidosPendientes(ProductosController state) {
    return ListView.separated(
           padding     : EdgeInsets.all(30),
           itemCount   : state.pedidos.length,
           separatorBuilder: (_,i)=>SizedBox(height: 30),
           itemBuilder : (_,i){
             return _cardPedido(state.pedidos[i]);
           }
       );
  }

  _itemOpcion(String titulo,bool realizado) {
    return Tab(
           icon: realizado
                 ? Icon(Icons.check,color: Get.theme.primaryColor)
                 : Icon(Icons.pending,color: Get.theme.primaryColor),
           child: Text(titulo,style: TextStyle(color: Colors.black)),
    );
  }
}
  
  
  
  */
}