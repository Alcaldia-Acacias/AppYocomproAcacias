import 'package:flutter/material.dart';

class CalificacionWidget extends StatelessWidget {
   final int extrellas;
   final bool centrado;
   final double size;
   CalificacionWidget({Key key,this.extrellas=0,this.centrado = true,@required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
           borderRadius: BorderRadius.circular(20),
           child: Container(
                  color: Colors.transparent,
                  height: 40,
                  width: 200,
                  child: Row(
                         mainAxisAlignment: centrado
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.start,
                         children: <Widget>[
                           Icon(Icons.star,
                                color: extrellas >= 1
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: size),
                           Icon(Icons.star,
                                color: extrellas >= 2
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: size),
                           Icon(Icons.star,
                                color: extrellas >= 3
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: size),
                           Icon(Icons.star,
                                color: extrellas >= 4
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: size),
                           Icon(Icons.star,
                                color: extrellas >= 5
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: size),
                          
                         ],
                  ),
           ),
    );
    
    
  }
}