import 'package:flutter/material.dart';

class CalificacionWidget extends StatelessWidget {
   final int extrellas;
   final bool principal;
   CalificacionWidget({Key key,this.extrellas=0,this.principal = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
           borderRadius: BorderRadius.circular(20),
           child: Container(
                  color: Colors.transparent,
                  height: 40,
                  width: 200,
                  child: Row(
                         mainAxisAlignment: principal
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.start,
                         children: <Widget>[
                           Icon(Icons.star,
                                color: extrellas >= 1
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: 30),
                           Icon(Icons.star,
                                color: extrellas >= 2
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: 30),
                           Icon(Icons.star,
                                color: extrellas >= 3
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: 30),
                           Icon(Icons.star,
                                color: extrellas >= 4
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: 30),
                           Icon(Icons.star,
                                color: extrellas >= 5
                                       ?  Colors.yellow
                                       :  Colors.white,
                                       size: 30),
                          
                         ],
                  ),
           ),
    );
    
    
  }
}