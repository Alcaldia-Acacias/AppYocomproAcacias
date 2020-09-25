import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/views/listEmpresas.view.dart';
import 'package:comproacacias/src/componetes/categorias/widgets/categoriaCard.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
            return Scaffold(
                   appBar: AppBar(
                           leading   : Image.asset('assets/imagenes/logo.png'),
                           title     : Text('Categorias'),
                           elevation : 0,
                           ),
                   body  : Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20,vertical:40),
                     child: Table(
                             //border: TableBorder.all(),
                             children: [
                               TableRow(
                               children: [
                                 CategoriaCard(
                                 titulo : "Comidas",
                                 imagen : "assets/imagenes/restaurante.png",
                                 onTap  : () => Get.to(ListEmpresasByCategoria(categoria:"Comida"))
                                 ),
                                 CategoriaCard(
                                 titulo : "Hospedaje",
                                 imagen : "assets/imagenes/hospedage.png",
                                 onTap  : () => Get.to(ListEmpresasByCategoria(categoria:"Hospedaje"))
                                 ),
                                ]
                               ),
                               TableRow(
                               children: [
                                 CategoriaCard(
                                 titulo: "Compras",
                                 imagen: "assets/imagenes/compras.png",
                                 onTap : ()=>Get.to(ListEmpresasByCategoria(categoria:"Compras"))
                                 ),
                                 CategoriaCard(
                                 titulo : "Turismo",
                                 imagen : "assets/imagenes/turismo.png",
                                 onTap  : ()=>Get.to(ListEmpresasByCategoria(categoria:"Turismo"))
                                 ),
                                ]
                               ),
                               TableRow(
                               children: [
                                 CategoriaCard(
                                 titulo: "Entretenimiento",
                                 imagen: "assets/imagenes/entrenimiento.png",
                                 onTap : ()=>Get.to(ListEmpresasByCategoria(categoria:"Entretenimiento"))
                                 ),
                                 CategoriaCard(
                                 titulo: "Otras",
                                 imagen: "assets/imagenes/opciones.png",
                                 ),
                                ]
                               ),
                              ],
                     ),
                   ),
            );
          
          
  }
}