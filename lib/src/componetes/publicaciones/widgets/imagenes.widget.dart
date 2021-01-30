import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagenesWidgetPage extends StatelessWidget {

  final List<String> imagenes;
  final int id;
  ImagenesWidgetPage({Key key,this.imagenes,this.id}) : super(key: key);
  final String url = Get.find<HomeController>().urlImagenes;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   iconTheme: IconThemeData(color:Colors.white),
                   backgroundColor: Colors.black,
           ),
           backgroundColor: Colors.black45,
           body: InteractiveViewer(
                 child: Hero(
                     tag : id,
                     child: PageView.builder(
                            itemCount: imagenes.length,
                            itemBuilder: (context,i){
                               return CachedNetworkImage(
                               imageUrl:'$url/galeria/${imagenes[i]}',
                               fit: BoxFit.contain,
                               );
                            },
                 ),
               ),
           ),
           
    );
  }
}