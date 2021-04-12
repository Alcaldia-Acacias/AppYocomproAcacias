import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CalificarWidget extends StatelessWidget {
  const CalificarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmpresasController>(
           builder: (state){
             return Container(
               child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (start)=>
                       IconButton(
                       icon: state.startValue[start] 
                             ?
                             Icon(Icons.star,color:Colors.yellow)
                             :
                             Icon(Icons.star_border),
                       onPressed: (){
                         state.calificarEmpresa(start);
                       },
                       iconSize: 33,
                       )
                      )
               ),
             );


           },

    );
  }
}