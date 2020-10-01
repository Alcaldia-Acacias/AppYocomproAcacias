import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/data/categorias.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListEmpresasByCategoria extends StatelessWidget {
  
  final String categoria;
  final String imageAppbar;

   ListEmpresasByCategoria({Key key,this.categoria,this.imageAppbar}) : super(key: key);
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
                                                           appBarSliver(categoria,imageAppbar),
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
                                 return _cardEmpresa(state.empresas[i]);
                              },
                              childCount: state.empresas.length + 1, 
                    )
           ),
   );
  }
  Widget  appBarSliver(String categoria,String image) {
  return  SliverAppBar(
          title           : Text(categoria,style:TextStyle(color: Colors.black)),
          floating        : true,
          brightness      : Brightness.light,
          backgroundColor : Colors.white,
          actions: <Widget>[
            Padding(
              padding : EdgeInsets.all(4),
              child   : Image.asset(image,fit: BoxFit.contain),
            )
          ],
          //pinned: true,
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


 