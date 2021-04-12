import 'package:flutter/material.dart';

class CategoriaCard extends StatelessWidget {
  
  final String titulo;
  final String imagen;
  final Function onTap;
  const CategoriaCard({Key key,this.titulo,this.imagen,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: Card(
                  elevation : 8,
                  shape     : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                  ),
                  margin    : EdgeInsets.all(8),
                  child     : Padding(
                              padding : EdgeInsets.all(15.0),
                              child   : Column(
                                        children: <Widget>[
                                                  Text(titulo,
                                                  style:TextStyle(
                                                        fontWeight : FontWeight.bold,
                                                        fontSize   : 13
                                                  )
                                                  ),
                                                  SizedBox(height: 10),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Image.asset(imagen,
                                                    height : 60,
                                                    width  : 60,
                                                    ),
                                                  )
                                        ],
                              ),
                  ),
           ),
           onTap: onTap,
    );
  }
}