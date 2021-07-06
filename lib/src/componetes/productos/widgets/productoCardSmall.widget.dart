import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductoCardSmall extends StatelessWidget {
  
  final String imagen;
  
  const ProductoCardSmall({Key key,this.imagen}) : super(key: key);

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
                                  imageUrl    : imagen,
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
               label: Text('\u0024 5000',style:TextStyle(color: Colors.white)),
               ), 
        )
      ],
      );
      
  }
}