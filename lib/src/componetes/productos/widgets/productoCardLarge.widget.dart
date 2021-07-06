import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductoCardLarge extends StatelessWidget {

  final String imagen;
  final bool oferta;
  const ProductoCardLarge({Key key,this.imagen,this.oferta}) : super(key: key);
  final imagenEmpresa = 'https://gestionpyme.com/wp-content/uploads/2015/09/shutterstock_227788621.jpg';
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
                         if(oferta)
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
             backgroundImage: NetworkImage(imagenEmpresa),   
             ),
             SizedBox(width: 10),
             Flexible(
             child: Text('Nombre Empresa largo es my largo extremada mente largo',
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
             imageUrl    : imagen,
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
                  label: Text('\u0024 5000',style: TextStyle(color: Get.theme.primaryColor))
                  ),
         );
}

Widget _oferta() {
  return Positioned(
         top: 45,
         left: 0,
         child: Icon(
                Icons.star_rate,
                color:Colors.yellow,
                size: 40,
                )
         );
}
}