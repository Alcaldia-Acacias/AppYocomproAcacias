import 'package:comproacacias/src/componetes/productos/controllers/tienda.controller.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/views/pedidos.view.dart';
import 'package:comproacacias/src/componetes/productos/views/producto.view.dart';
import 'package:comproacacias/src/componetes/productos/widgets/productoCardLarge.widget.dart';
import 'package:comproacacias/src/componetes/productos/widgets/productoCardSmall.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ProductosList extends StatelessWidget {
  const ProductosList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   leading   : Image.asset('assets/imagenes/logo.png'),
                   elevation : 0,
                   title     : Text('Tienda'),
                   actions   : [
                      IconButton(
                      icon      : Icon(Icons.shopping_cart_outlined), 
                      color     : Get.theme.primaryColor,
                      onPressed : () => Get.to(PedidosPage())
                      )
                   ],
           ),
           body  : GetBuilder<TiendaController>(
                   init    : TiendaController(),
                   builder : (state){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _titulo('Categorias'),
                                _categorias(state),
                                _titulo('Ofertas'),
                                _ofertas(state),
                                _titulo('Productos'),
                                _productos(state)
                               ],
                              ),
                     );
                   }
                   )
    );
  }

 Widget _categorias(TiendaController state) {
   return Container(
          height : 60,
          child  : ListView.separated(
                   scrollDirection  : Axis.horizontal,
                   separatorBuilder : (_,i) => SizedBox(width: 10),
                   itemCount        : state.categorias.length,
                   itemBuilder      : (_,i){
                         return RawChip(
                                backgroundColor : Colors.white,
                                label           : Text(state.categorias[i]),
                                shape           : RoundedRectangleBorder(
                                                  borderRadius : BorderRadius.circular(20),
                                                  side         : BorderSide(color: Get.theme.primaryColor)
                                ),
                                onPressed: (){},
                                   
                         );
                   }
          )
   );
 }

  Widget _titulo(String titulo) {
    return Padding(
           padding : const EdgeInsets.symmetric(horizontal: 8),
           child   : Text(titulo,style:TextStyle(fontSize: 18)),
    );
  }

Widget _ofertas(TiendaController state) {
   return Container(
          margin: EdgeInsets.only(top:5),
          height : 110,
          child  : ListView.separated(
                   scrollDirection  : Axis.horizontal,
                   separatorBuilder : (_,i) => SizedBox(width: 10),
                   itemCount        : 10,
                   itemBuilder      : (_,i){
                         return GestureDetector(
                                child : ProductoCardSmall(imagen: state.imagenes[0]),
                                onTap : () =>Get.to(ProductoPage(producto: Producto())),
                                );
                   }
          )
   );
  }

  Widget _productos(TiendaController state) {
    return Expanded(
           child: StaggeredGridView.countBuilder(
                  crossAxisCount : 4,
                  itemCount      : 8,
                  itemBuilder    : (_, int i) {
                     return GestureDetector(
                            child: ProductoCardLarge(imagen: state.imagenes[0],oferta: true),
                            onTap: ()=>Get.to(ProductoPage(producto: Producto())),
                            );
                  },
                  staggeredTileBuilder: (int i) => StaggeredTile.count(2, i.isEven ? 3 : 4),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
),
    );
  }
}