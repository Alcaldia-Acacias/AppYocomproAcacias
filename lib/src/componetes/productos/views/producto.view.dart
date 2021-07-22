import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/widgets/productoCardSmall.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class ProductoPage extends StatelessWidget {
  
  
  ProductoPage({Key key}) : super(key: key);
  final urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosController>(
           id: 'producto',
           builder: (state){
           var producto = state.productoSelecionado;
           return Scaffold(
           appBar: AppBar(
                   elevation : 0,
                   title: Text('${producto.empresa.nombre}'),
           ),
           body  : SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       _imagenes(producto),
                       _descripcion(producto),
                       _botonPedir(producto),
                       SizedBox(height: 8),
                       Text('Mas Productos',
                          textAlign: TextAlign.left,
                          style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                   ),
                       _masProductos(producto)
                     ],
             ),
                        ),
           )
       );
    },
    );
  }

Widget _imagenes(Producto producto) {
  return Expanded(
         flex: 3,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Swiper(
                  itemCount: producto.imagenes.length,
                  pagination: SwiperPagination(),
                  itemWidth: 500,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (_,i){
                    return ClipRRect(
                           borderRadius : BorderRadius.circular(30),
                           child        : CachedNetworkImage(
                                          imageUrl    : '$urlImagenes/galeria/${producto.imagenes[i]}',
                                          fit         : BoxFit.cover,
                                          placeholder : (context, url) =>  Image.asset('assets/imagenes/load_image.gif'),
                                          errorWidget : (context, url, error) => Icon(Icons.error),
    ),
                    );
                  },
           ),
         )
         );
}

Widget _descripcion(Producto producto) {
  return Expanded(
         flex: producto.oferta ? 2 : 1,
         child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text('${producto.nombre}',
                      textAlign: TextAlign.left,
                      style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
                 ),
                 SizedBox(height: 10),
                 Flexible(
                 child: Text('${producto.descripcion}',
                       maxLines: 3,
                       overflow: TextOverflow.ellipsis,
                 ),
                 ),
                 if(producto.oferta)
                 RawChip(
                  backgroundColor: Colors.white,
                  label          : Text('Oferta'),
                  avatar         : Icon(Icons.star,color: Colors.yellow),
                 ),
                 if(producto.oferta)
                 Flexible(
                 child: Text('${producto.descripcionOferta}',
                       maxLines: 3,
                       overflow: TextOverflow.ellipsis,
                 ),
                 ),
                ],
         )
         );
}

Widget _botonPedir(Producto producto) {
  return Expanded(
         flex:  1,
         child: Card(
                   elevation: 5,
                   shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                   ),
                   child: Padding(
                          padding :  EdgeInsets.all(20.0),
                          child   : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('\u0024 ${producto.precio}',style: TextStyle(fontSize: 25)),
                                      RawChip(
                                      backgroundColor : Get.theme.primaryColor,
                                      label           : Text('Agregar'),
                                      avatar          : Icon(Icons.add,color: Colors.white),
                                      labelStyle      : TextStyle(color: Colors.white),
                                      onPressed       : ()=> _dialogoPedir(producto),
                                      )
                                    ],
                          ),
                   ),
         )
         );
}

  _masProductos(Producto producto) {
    return Expanded(
           flex: producto.oferta ? 1 : 2,
           child: GetBuilder<ProductosController>(
                  id     : 'productos_empresa',
                  builder:  (state){
                    if(state.loading){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(state.productosByEmpresa.length == 0){
                      return Center(child: Text('No hay Productos'));
                    }
                    return ListView.separated(
                           padding: EdgeInsets.symmetric(horizontal: 2,vertical: 10),
                           scrollDirection  : Axis.horizontal,
                           separatorBuilder : (_,i) => SizedBox(width: 10),
                           itemCount        : state.productosByEmpresa.length,
                           itemBuilder      : (_,i){
                                 return GestureDetector(
                                        child : ProductoCardSmall(producto: state.productosByEmpresa[i]),
                                        onTap : () => state.selectProducto(state.productosByEmpresa[i])
                                        );
                           }
                    );
                  },
           )
    );
  }

  _dialogoPedir(Producto producto) {
    Get.defaultDialog(
    title: 'Cantidad',
    content :  _cantidad(producto),
    actions :[
        RaisedButton(
        child    : Text('Agregar',style : TextStyle(color: Colors.white)),
        color    : Get.theme.primaryColor,
        onPressed: (){
          Get.back();
          Get.find<ProductosController>().addPedido(producto);
        }
        ),
        RaisedButton(
        child    : Text('Cancelar',style : TextStyle(color: Colors.white)),
        color    : Get.theme.accentColor,
        onPressed: ()=>Get.back()
        ),     
    ] 
    );
  }



  _cantidad(Producto producto) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 300,
      child: GetBuilder<ProductosController>(
             id: 'cantidad',
             builder: (state){
               return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       RaisedButton(
                       child    : Text('-',style : TextStyle(color: Colors.white,fontSize: 20)),
                       color    : Get.theme.accentColor,
                       onPressed: ()=> state.cambiarCantidad(aumentar: false)
                       ),
                       Text('${state.cantidadProducto}'),
                       RaisedButton(
                       child    : Text('+',style : TextStyle(color: Colors.white,fontSize: 20)),
                       color    : Get.theme.primaryColor,
                       onPressed: ()=> state.cambiarCantidad(aumentar: true)
                       )
                      ],
               );
             },
      )
    );
  }
}