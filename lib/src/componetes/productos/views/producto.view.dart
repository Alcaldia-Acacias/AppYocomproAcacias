import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/widgets/productoCardSmall.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class ProductoPage extends StatelessWidget {
  
  final Producto producto;
  ProductoPage({Key key,this.producto}) : super(key: key);
  final urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
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
                       _imagenes(),
                       _descripcion(),
                       _botonPedir(),
                       SizedBox(height: 8),
                       Text('Mas Productos',
                          textAlign: TextAlign.left,
                          style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                   ),
                       _masProductos()
                     ],
             ),
                        ),
           )
    );
  }

Widget _imagenes() {
  return Expanded(
         flex: 3,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Swiper(
                  itemCount: producto.imagenes.length,
                  pagination: SwiperPagination(),
                  itemWidth: 300,
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

Widget _descripcion() {
  return Expanded(
         flex: 1,
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
                 )
                ],
         )
         );
}

Widget _botonPedir() {
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
                                      )
                                    ],
                          ),
                   ),
         )
         );
}

  _masProductos() {
    return Expanded(
           flex: 2,
           child: ListView.separated(
                   padding: EdgeInsets.symmetric(horizontal: 2,vertical: 10),
                   scrollDirection  : Axis.horizontal,
                   separatorBuilder : (_,i) => SizedBox(width: 10),
                   itemCount        : 0,
                   itemBuilder      : (_,i){
                         return GestureDetector(
                                child : ProductoCardSmall(),
                                onTap : () =>Get.to(ProductoPage(producto: Producto())),
                                );
                   }
          )
           );
  }
}