import 'package:flutter/material.dart';

class CalificacionWidget extends StatelessWidget {
  const CalificacionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
           borderRadius: BorderRadius.circular(20),
           child: Container(
                  color: Colors.transparent,
                  height: 40,
                  width: 200,
                  child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           Icon(Icons.star,color: Colors.yellow,size: 30),
                           Icon(Icons.star_border,color: Colors.white,size: 30),
                           Icon(Icons.star_border,color: Colors.white,size: 30),
                           Icon(Icons.star_border,color: Colors.white,size: 30),
                           Icon(Icons.star_border,color: Colors.white,size: 30),
                         
                          
                         ],
                  ),
           ),
    );
    
    
  }
}