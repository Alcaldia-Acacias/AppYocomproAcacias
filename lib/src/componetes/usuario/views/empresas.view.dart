import 'package:comproacacias/src/componetes/usuario/controllers/changePassword.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListEmpresasPage extends StatelessWidget {
  const ListEmpresasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text('Empresas'),
                   elevation: 0,
           ),
           body: GetBuilder<ChangePasswordController>(
                 builder: (state){
                   return Container();
                 },
           ),
           floatingActionButton: FloatingActionButton(
                                 child           : Icon(Icons.add,color: Colors.white),
                                 backgroundColor : Get.theme.primaryColor,
                                 onPressed: (){}
                                 ),
    );
  }
}