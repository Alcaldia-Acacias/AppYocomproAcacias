import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductoCardSmall extends StatelessWidget {
  
  final Producto producto;
  
  ProductoCardSmall({Key key,this.producto}) : super(key: key);
  final urlImagen = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      fit: StackFit.loose,
      children: [
        SizedBox(
        height: 150,
        width: 150,
        child: ClipRRect( 
                   borderRadius : BorderRadius.circular(20),
                   child        : CachedNetworkImage(
                                  imageUrl    : '$urlImagen/galeria/${producto.imagenes[0]}',
                                  fit         : BoxFit.cover,
                                  placeholder : (context, url) =>  Image.asset('assets/imagenes/load_image.gif'),
                                  errorWidget : (context, url, error) => Icon(Icons.error),
                   ),
          ),
        ),
        Align(
        alignment: Alignment(0,1.24),
        child: RawChip(
               backgroundColor: Get.theme.primaryColor,
               label: Text('\u0024 ${producto.precio}',style:TextStyle(color: Colors.white)),
               ), 
        )
      ],
      );
      
  }
}