import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/controller/search.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
   SearchPage({Key key}) : super(key: key);
   final String urlImagenLogo = Get.find<HomeController>().urlImegenes;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchEmpresasController>(
           init: SearchEmpresasController(EmpresaRepositorio()),
           id: 'search',
           builder: (state){
           return Scaffold(
                   backgroundColor: Colors.grey[200],
                   appBar: AppBar(
                           title: TextField(
                                  controller : state.searchController,
                                  style      : TextStyle(fontSize: 18),
                                  autofocus  : true,
                                  decoration : InputDecoration(
                                               hintText: "Buscar",
                                               hintStyle: TextStyle(fontSize: 15),
                                               border: InputBorder.none
                                               ),
                                  onChanged  : (value) => state.searchEmpresa()
                           ),
                           elevation: 0,
                   ),
                   body: ListView.builder(
                         itemCount  : state.empresas.length,
                         itemBuilder: (context,i){
                           return _cardEmpresa(state.empresas[i]);
                         }
                         )
           );
           }
           );
  }
  Widget _cardEmpresa(Empresa empresa) {
   return GestureDetector(
          child: Card(
                 child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: ListTile(
                               title    : Text(empresa.nombre,
                                          style: TextStyle(
                                                 fontWeight: FontWeight.bold
                                          )),
                               subtitle : Text(empresa.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                          ),
                               leading  : empresa.urlLogo == ''
                                          ? 
                                          CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage('assets/imagenes/logo_no_img.png'),
                                          )
                                          :
                                          CircleAvatar(
                                          radius: 30,
                                          backgroundImage: CachedNetworkImageProvider('$urlImagenLogo/logo/${empresa.urlLogo}'),
                                          )
                        ),
                 ),
                 shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                 ),
          ),
        onTap: (){
          Get.to(PerfilEmpresaPage(empresa: empresa));
        },
   );
  }
}