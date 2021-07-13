
import 'package:comproacacias/src/componetes/productos/controllers/tienda.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key key}) : super(key: key);
final imagenEmpresa = 'https://gestionpyme.com/wp-content/uploads/2015/09/shutterstock_227788621.jpg';
final imagen = 'https://cdn.computerhoy.com/sites/navi.axelspringer.es/public/styles/2400/public/media/image/2020/08/hamburguesa-2028707.jpg?itok=YeexorXR';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   elevation : 0,
                   title     : Text('Pedidos'),
           ),
           body: GetBuilder<TiendaController>(
                builder: (state){
                   return ListView.separated(
                          padding     : EdgeInsets.all(20),
                          itemCount   : 3,
                          separatorBuilder: (_,i)=>SizedBox(height: 30),
                          itemBuilder : (_,i){
                            return _cardPedido();
                          }
                          );
                }
                ),
    );
  }

  Widget _cardPedido() {
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
                          _empresa(),
                          _divider(),
                          _pedidos(),
                          _divider(),
                          _bottonPedir()
                        ],
           ),
    );
  }

  Widget _empresa() {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Row(
             children: [
               CircleAvatar(
               backgroundImage: NetworkImage(imagenEmpresa),  
               radius: 30,
               ),
               SizedBox(width: 30),
               Text('Nombre Empresa'),
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

Widget  _pedidos() {
  return Expanded(
         child : ListView.separated(
                 itemCount: 10,
                 separatorBuilder: (_,i)=>SizedBox(height:10),
                 itemBuilder: (_,i){
                   return ListTile(
                          leading : CircleAvatar(
                                    backgroundImage: NetworkImage(imagen),
                                    radius: 40,
                          ),
                          title: Text('Nombre Producto'),
                          trailing: IconButton(
                                    icon      : Icon(Icons.delete),
                                    color     : Colors.red,
                                    onPressed : (){},
                          ),
                   );
                 }
                 ) ,
  );
}

Widget _bottonPedir() {
  return GestureDetector(
         child: Container(
                height : 60,
                color  : Get.theme.primaryColor,
                child  : Center(child: Text('Hacer Pedido',style:TextStyle(color: Colors.white))),
         ),
  );
}
}