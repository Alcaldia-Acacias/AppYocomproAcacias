import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/views/listCategorias.view.dart';
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
                                 onTap  : () {
                                   Get.find<CategoriasController>().getEmpresasByCategoriaInitial("Comida");
                                   Get.to(ListEmpresasByCategoria(imageAppbar:"assets/imagenes/restaurante.png"));
                                 }
                                 ),
                                 CategoriaCard(
                                 titulo : "Hospedaje",
                                 imagen : "assets/imagenes/hospedage.png",
                                onTap  : () {
                                   Get.find<CategoriasController>().getEmpresasByCategoriaInitial("Hospedaje");
                                   Get.to(ListEmpresasByCategoria(imageAppbar:"assets/imagenes/hospedage.png"));
                                 }
                                 )
                                ]
                               ),
                               TableRow(
                               children: [
                                 CategoriaCard(
                                 titulo: "Compras",
                                 imagen: "assets/imagenes/compras.png",
                                 onTap  : () {
                                   Get.find<CategoriasController>().getEmpresasByCategoriaInitial("Compras");
                                   Get.to(ListEmpresasByCategoria(imageAppbar:"assets/imagenes/compras.png"));
                                 }
                                 ),
                                 CategoriaCard(
                                 titulo : "Turismo",
                                 imagen : "assets/imagenes/turismo.png",
                                  onTap  : () {
                                   Get.find<CategoriasController>().getEmpresasByCategoriaInitial("Turismo");
                                   Get.to(ListEmpresasByCategoria(imageAppbar:"assets/imagenes/turismo.png"));
                                 }
                                 ),
                                ]
                               ),
                               TableRow(
                               children: [
                                 CategoriaCard(
                                 titulo: "Entretenimiento",
                                 imagen: "assets/imagenes/entrenimiento.png",
                                onTap  : () {
                                   Get.find<CategoriasController>().getEmpresasByCategoriaInitial("Entretenimiento");
                                   Get.to(ListEmpresasByCategoria(imageAppbar:"assets/imagenes/entrenimiento.png"));
                                 }
                                 ),
                                 CategoriaCard(
                                 titulo: "Otras",
                                 imagen: "assets/imagenes/opciones.png",
                                 onTap: ()=>Get.to(ListCategoriasPage()),
                                 ),
                                ]
                               ),
                              ],
                     ),
                   ),
            );
          
          
  }
}