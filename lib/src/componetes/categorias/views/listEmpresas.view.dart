import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/data/categorias.repositorio.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListEmpresasByCategoria extends StatelessWidget {
  
  final String categoria;
   ListEmpresasByCategoria({Key key,this.categoria}) : super(key: key);
  final String urlImagenLogo = Get.find<HomeController>().urlImegenes;
  @override
  Widget build(BuildContext context) {
     return GetBuilder(
            init: CategoriasController(repositorio: CategoriaRepositorio(),categoria: categoria),
            builder: (state){
                return Scaffold(
                       body: SafeArea(
                             child: RefreshIndicator(
                                    onRefresh: () async {},
                                    child    : CustomScrollView(
                                                 controller: state.controllerListEmpresas,
                                                 slivers: <Widget>[
                                                           appBarSliver(categoria),
                                                           listEmpresas(state)
                                                 ],
                                    ),
                         ),
                       ),
                       backgroundColor: Colors.grey[300],
                    );
            }
 );
  }
   Widget listEmpresas(CategoriasController state) {
   return  SliverPadding(
           padding: EdgeInsets.all(4),
           sliver : SliverList(
                    delegate: SliverChildBuilderDelegate(
                              (context,i){
                                 if(i == state.empresas.length ){
                                      return Center(
                                             child: Container(
                                                    padding : EdgeInsets.all(10),
                                                    child   : CircularProgressIndicator(),
                                                    )
                                        );
                                 }
                                 return Card(
                                   child: Padding(
                                     padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                     child: ListTile(
                                            title    : Text(state.empresas[i].nombre,
                                                       style: TextStyle(
                                                              fontWeight: FontWeight.bold
                                                       )),
                                            subtitle : Text(state.empresas[i].descripcion,
                                                       overflow: TextOverflow.ellipsis,
                                                       ),
                                            leading  : state.empresas[i].urlLogo == ''
                                                       ? 
                                                       CircleAvatar(
                                                       radius: 30,
                                                       backgroundImage: AssetImage('assets/imagenes/logo_no_img.png'),
                                                       )
                                                       :
                                                       CircleAvatar(
                                                       radius: 30,
                                                       backgroundImage: CachedNetworkImageProvider('$urlImagenLogo/logo/${state.empresas[i].urlLogo}'),
                                                       )
                                     ),
                                   ),
                                   shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                   ),
                                   );
                              },
                              childCount: state.empresas.length + 1, 
                    )
           ),
   );
  }
  Widget  appBarSliver(String categoria) {
  return  SliverAppBar(
          title           : Text(categoria,style:TextStyle(color: Colors.black)),
          floating        : true,
          brightness      : Brightness.light,
          backgroundColor : Colors.white
          //pinned: true,
          );
}
}