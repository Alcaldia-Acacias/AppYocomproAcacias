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
                      children: List.generate(5, (page)=>
                       IconButton(
                       icon: state.startValue[page] 
                             ?
                             Icon(Icons.star,color:Colors.yellow)
                             :
                             Icon(Icons.star_border),
                       onPressed: (){
                         state.calificarEmpresa(page);
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