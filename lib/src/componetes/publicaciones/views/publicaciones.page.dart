

import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/widgets/publicacion.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicacionesPage extends StatelessWidget {
  const PublicacionesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<PublicacionesController>(
           id: 'publicaciones',
           builder: (state)
                    => Scaffold(
                       body: SafeArea(
                             child: RefreshIndicator(
                                    onRefresh: ()  async  => state.getNewPublicaciones(),
                                    child    : CustomScrollView(
                                                 controller: state.controller,
                                                 slivers: <Widget>[
                                                           appBarSliver(),
                                                           listPublicaciones(state)
                                                 ],
                                    ),
                         ),
                       ),
                       backgroundColor: Colors.grey[300],
                       floatingActionButton: FloatingActionButton.extended(
                                             heroTag: 'publicar',
                                             label : Text('Publicar',
                                                     style: TextStyle(color: Colors.white),
                                             ),
                                             icon  : Icon(Icons.edit,color:Colors.white),
                                             backgroundColor: Get.theme.primaryColor,
                                             onPressed: (){}, 
                                             )
                    )
 );
    
  
}

 Widget listPublicaciones(PublicacionesController state) {
   return  SliverPadding(
           padding: EdgeInsets.all(4),
           sliver : SliverList(
                    delegate: SliverChildBuilderDelegate(
                              (context,i){
                                 if(i == state.publicaciones.length ){
                                      return Center(
                                             child: Container(
                                                    padding : EdgeInsets.all(10),
                                                    child   : CircularProgressIndicator(),
                                                    )
                                        );
                                 }
                                 return PublicacionCard(
                                        publicacion: state.publicaciones[i],
                                        index: i
                                 );
                              },
                              childCount: state.publicaciones.length + 1, 
                    )
           ),
   );
  }

  Widget loading(bool loading) {
    return loading
           ? Container(
             alignment: Alignment.center,
             height : 50,
             width  : 400,
             child: CircularProgressIndicator(),
           )
           : Container();

  }

Widget  appBarSliver() {
  return  SliverAppBar(
          leading         : Image.asset('assets/imagenes/logo.png'),
          title           : Text('Publicaciones',style:TextStyle(color: Colors.black)),
          floating        : true,
          brightness      : Brightness.light,
          backgroundColor : Colors.white
          //pinned: true,
          );
}
}