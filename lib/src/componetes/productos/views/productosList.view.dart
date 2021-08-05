import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
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
                    _butonIconNotification()
                   ],
           ),
           body  : GetBuilder<ProductosController>(
                   init    : ProductosController(repositorio: ProductosRepositorio()),
                   id      : 'productos',
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

 Widget _categorias(ProductosController state) {
   return Container(
          height : 60,
          child  : ListView.separated(
                   scrollDirection  : Axis.horizontal,
                   separatorBuilder : (_,i) => SizedBox(width: 10),
                   itemCount        : state.categorias.length,
                   itemBuilder      : (_,i){
                         return RawChip(
                                backgroundColor : Colors.white,
                                label           : Text(state.categorias[i].nombre),
                                shape           : RoundedRectangleBorder(
                                                  borderRadius : BorderRadius.circular(20),
                                                  side         : BorderSide(color: Get.theme.primaryColor)
                                ),
                                selected        : state.categorias[i].selecionada,
                                selectedColor   : Get.theme.primaryColor,
                                labelStyle      : state.categorias[i].selecionada
                                                  ? TextStyle(color: Colors.white)
                                                  : null,
                                checkmarkColor  : Colors.white,
                                onPressed       : () => state.filterProductosSelect(
                                                        indexCategoria: i,
                                                        idCategoria: state.categorias[i].id
                                ),
                                   
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

Widget _ofertas(ProductosController state) {
   if(state.allWithOfertaProductos.length == 0)
      return Center(
             child : Padding(
                     padding: EdgeInsets.all(20),
                     child  : Text('No hay Ofertas')
             ),
      );
   if(state.allWithOfertaProductos.length > 0)
    return Container(
           margin: EdgeInsets.only(top:5),
           height : 110,
           child  : ListView.separated(
                    controller       : state.controllerOferta,
                    scrollDirection  : Axis.horizontal,
                    separatorBuilder : (_,i) => SizedBox(width: 10),
                    itemCount        : state.allWithOfertaProductos.length + 1,
                    itemBuilder      : (_,i){
                          if(i == state.allWithOfertaProductos.length && state.allWithOfertaProductos.length !=0){
                            return Center(
                                   child : Padding(
                                           padding: EdgeInsets.all(20),
                                           child  : CircularProgressIndicator(),
                                   ),
                            );
                          }
                          return GestureDetector(
                                 child : ProductoCardSmall(producto: state.allWithOfertaProductos[i]),
                                 onTap : () {
                                   Get.to(ProductoPage());
                                   state.getProductosByEmpresa(state.allWithOfertaProductos[i].empresa.id);
                                   state.selectProducto(state.allWithOfertaProductos[i]);
                                 }
                                 );
                    }
           )
    );
    return Center(
           child : Padding(
                   padding: EdgeInsets.all(20),
                   child  : CircularProgressIndicator(),
           ),
    );
  }

  Widget _productos(ProductosController state) {
    return Expanded(
           child: StaggeredGridView.countBuilder(
                  controller     : state.controller,
                  crossAxisCount : 4,
                  itemCount      : state.allProductos.length + 1,
                  itemBuilder    : (_, int i) {
                     if(i == state.allProductos.length){
                        return Center(
                               child: Container(
                                      padding : EdgeInsets.all(10),
                                      child   : CircularProgressIndicator(),
                                      )
                        );
                     }
                     return GestureDetector(
                            child: ProductoCardLarge(
                                   producto:  state.allProductos[i],
                            ),
                           onTap : () {
                                  Get.to(ProductoPage());
                                  state.getProductosByEmpresa(state.allProductos[i].empresa.id);
                                  state.selectProducto(state.allProductos[i]);
                                }
                     );
                            
                  },
                  staggeredTileBuilder: (int i) => StaggeredTile.count(2, i.isEven ? 3 : 4),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
           ),
    );
  }
  _butonIconNotification() {
   return  GetBuilder<ProductosController>(
           id: 'carrito',
           builder: (state){
           if(state.pedidos.length > 0)
           return Badge(
                  badgeContent : Text('${state.pedidos.length}',
                                      style: TextStyle(color: Colors.white,fontSize: 13)),
                  position     : BadgePosition(top: 3,start: 28),
                  badgeColor   : Colors.red,
                  child        : IconButton(
                                 icon      : Icon(Icons.shopping_cart_outlined),
                                 color     : Get.theme.primaryColor,
                                 iconSize  : 30,
                                 onPressed : ()=>Get.to(PedidosPage())
                  ),
           );
           return IconButton(
                  icon      : Icon(Icons.shopping_cart_outlined),
                  color     : Colors.grey,
                  iconSize  : 30,
                  onPressed : ()=>Get.to(PedidosPage())
           );
           }
           );
  }
}