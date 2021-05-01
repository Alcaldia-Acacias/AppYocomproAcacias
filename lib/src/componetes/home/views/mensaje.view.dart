import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  final String mensaje;
  final String fecha;
  const MensajePage({Key key,this.mensaje,this.fecha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.grey.shade200,
           appBar: AppBar(
                   elevation : 0,
                   title     : Text('Mensaje'),
           ),
           body : SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child  : Card(
                           elevation : 0,
                           shape     : RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20)
                           ),
                           child     : Padding(
                                       padding: EdgeInsets.all(8.0),
                                       child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                               _titulo(),
                                               SizedBox(height: 10),
                                               Padding(
                                               padding : EdgeInsets.only(left: 8,bottom: 10),
                                               child   : Text(mensaje,style: TextStyle(fontSize: 16)),
                                               )
                                              ],
                                       ),
                           ),
                  ),
           ),
    );
  }

 Widget _titulo() {
    return Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             ClipRRect(
             child: Image.asset(
                    'assets/imagenes/logo.png',
                    width  : 80,
                    height : 80,
                    ),
             ),
             Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
               padding : const EdgeInsets.only(top: 8),
               child   : Text(
                         'Yo Compro Acacías',
                          style: TextStyle(
                                 fontWeight : FontWeight.bold,
                                 fontSize   : 20
                          )
               ),
               ),
               Text('Te excribio un mensaje'),
               SizedBox(height: 4),
               Text(fecha,style: TextStyle(color: Colors.grey.shade400))
             ],
             )
           ],
    );
  }
}