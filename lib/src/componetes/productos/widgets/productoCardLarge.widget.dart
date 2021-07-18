import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductoCardLarge extends StatelessWidget {

  final Producto producto;

  ProductoCardLarge({Key key,this.producto}) : super(key: key);
  String urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return Container(
           clipBehavior: Clip.antiAlias,
           decoration : BoxDecoration(
                        border: Border.all(
                                color: Colors.grey[400]  
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
           ),
           child      : Stack(
                        children: [
                          Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _empresa(),
                            _imagen()
                          ],
                         ),
                         _precio(),
                         if(producto.oferta)
                         _oferta()
                        ],
           )
    );
  }

Widget _empresa() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             CircleAvatar(
             backgroundImage:  producto.empresa.urlLogo.isNullOrBlank
                               ? AssetImage('assets/imagenes/no_image.jpeg')
                               : NetworkImage('$urlImagenes/logo/${producto.empresa.urlLogo}'),   
             ),
             SizedBox(width: 10),
             Flexible(
             child: Text('${producto.empresa.nombre}',
                    overflow : TextOverflow.ellipsis,
                    style    : TextStyle(fontSize: 12),    
                    maxLines : 2,
             ),
             )
           ],
    ),
  );
}

Widget _imagen() {
  return Expanded(
      child: CachedNetworkImage(
             imageUrl    : '$urlImagenes/galeria/${producto.imagenes[0]}',
             fit         : BoxFit.cover,
             placeholder : (context, url) =>  Image.asset('assets/imagenes/load_image.gif'),
             errorWidget : (context, url, error) => Icon(Icons.error),
    ),
  );
}

Widget _precio() {
  return Positioned(
         bottom : -7,
         right  : 2,
         child  : RawChip(
                  backgroundColor: Colors.white,
                  label: Text('\u0024 ${producto.precio}',style: TextStyle(color: Get.theme.primaryColor))
                  ),
         );
}

Widget _oferta() {
  return Positioned(
         top    : 48,
         left   : 3,
         child  : RawChip(
                  backgroundColor: Colors.white,
                  label          : Text('Oferta'),
                  avatar         : Icon(Icons.star,color: Colors.yellow),
         )
         );
}
}