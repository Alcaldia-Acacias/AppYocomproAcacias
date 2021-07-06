import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/widgets/productoCardSmall.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class ProductoPage extends StatelessWidget {
  final Producto producto;
  const ProductoPage({Key key,this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   elevation : 0,
                   title: Text('Nombre de Empresa'),
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
                  itemCount: 5,
                  pagination: SwiperPagination(),
                  itemWidth: 300,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (_,i){
                    return ClipRRect(
                           borderRadius : BorderRadius.circular(30),
                           child        : CachedNetworkImage(
                                          imageUrl    : 'https://cdn.computerhoy.com/sites/navi.axelspringer.es/public/styles/2400/public/media/image/2020/08/hamburguesa-2028707.jpg?itok=YeexorXR',
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
                 Text('Nombre Producto',
                      textAlign: TextAlign.left,
                      style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
                 ),
                 SizedBox(height: 10),
                 Flexible(
                 child: Text('hambuerguesa con queso y papas con gaseosa incluida muy deliciosa',
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
                                      Text('\u0024 5000',style: TextStyle(fontSize: 25)),
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
                   itemCount        : 10,
                   itemBuilder      : (_,i){
                         return GestureDetector(
                                child : ProductoCardSmall(imagen: 'https://cdn.computerhoy.com/sites/navi.axelspringer.es/public/styles/2400/public/media/image/2020/08/hamburguesa-2028707.jpg?itok=YeexorXR'),
                                onTap : () =>Get.to(ProductoPage(producto: Producto())),
                                );
                   }
          )
           );
  }
}