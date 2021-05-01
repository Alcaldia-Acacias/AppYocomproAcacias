import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/empresas/views/search.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/models/loginEnum.model.dart';
import 'package:comproacacias/src/componetes/home/views/notificaciones.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
class InicioPage extends StatelessWidget {
  InicioPage({Key key}) : super(key: key);
  final String urlImagenLogo = Get.find<HomeController>().urlImagenes;
  final anonimo = Get.find<HomeController>().anonimo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           onTap:  ()=> FocusScope.of(context).unfocus(),
          child: Scaffold(
             backgroundColor: Colors.grey[100],
             appBar: AppBar(
                     leading : Image.asset('assets/imagenes/logo.png'),
                     title   : Text('Yo Compro Acacias',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w400)),
                     elevation: 0,
                     actions: [
                       if(anonimo == EnumLogin.usuario)
                       _butonIconNotification(),
                       SizedBox(width: 15),
                     ],
             ),
             body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                           crossAxisAlignment : CrossAxisAlignment.start,
                           children: [
                               _search(),
                               _titulo('Nuestros videos'),
                               _videos(),
                               _titulo('Top 10'),
                               _top()
                           ],
             ),
               ),
             
      ),
    );
   
  }

  _videos() {
    return Container(
           color: Colors.white,
           padding: EdgeInsets.all(15),
           height: Get.height * 0.25,
           child: GetBuilder<HomeController>(
                  id: 'videos',
                  builder: (state) {
                    if(state.videos.length == 0)
                       return Center(child: CircularProgressIndicator());
                    return ListView.separated(
                      separatorBuilder : (_,index) => SizedBox(width: 10),
                      scrollDirection  : Axis.horizontal,
                      itemCount        : state.videos.length,
                      itemBuilder      : (_,int index) {
                                         return GestureDetector(
                                                child: ClipRRect(
                                                       borderRadius: BorderRadius.circular(20),
                                                       child: CachedNetworkImage(
                                                              fit         : BoxFit.cover,
                                                              width       : 200,
                                                              height      : 200,
                                                              imageUrl    : '${state.videos[index].urlImagen}',
                                                              placeholder : (context, url) =>  Image.asset('assets/imagenes/load_image.gif'),
                                                              errorWidget : (context, url, error) => Icon(Icons.error),
                                                  ),
                                                ),
                                                onTap: ()=> state.videos[index].goToVideo(),
                                         );
                      }
                    );
                  }
    )
  );
  }

  _top() {
    return Expanded(
           child: GetBuilder<HomeController>(
                  id: 'top',
                  builder: (state) {
                    return ListView.builder(
                      itemCount: state.topEmpresas.length,
                      itemBuilder: (_, int index) {
                      return _cardEmpresa(state.topEmpresas[index]);
                     },
                    );
                  }
                  )
    );
  }

  _butonIconNotification() {
   return  GetBuilder<HomeController>(
           builder: (state){
           if(state.notificacionesNoLeidas > 0)
           return Badge(
                  badgeContent : Text('${state.notificacionesNoLeidas}',
                                      style: TextStyle(color: Colors.white,fontSize: 13)),
                  position     : BadgePosition(top: 3,start: 28),
                  badgeColor   : Colors.red,
                  child        : IconButton(
                                 icon      : Icon(Icons.notifications_outlined),
                                 color     : Colors.grey,
                                 iconSize  : 30,
                                 onPressed : ()=>Get.to(NotificationPage())
                  ),
           );
           return IconButton(
                  icon      : Icon(Icons.notifications_outlined),
                  color     : Colors.grey,
                  iconSize  : 30,
                  onPressed : ()=>Get.to(NotificationPage())
           );
           }
           );
  }

  _titulo(String titulo) {
    return Padding(
           padding:  EdgeInsets.all(8.0),
           child: Text(titulo,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
   );
  }

  _search() {
    return GetBuilder<HomeController>(
           builder: (state) => Padding(
                               padding :  EdgeInsets.all(10),
                               child   : TextField(
                                         controller : state.searchControllerHome,
                                         style      : TextStyle(fontSize: 18),
                                         decoration : InputDecoration(
                                                      contentPadding : EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                                      hintText       : "Buscar Comercios",
                                                      filled         :  true,
                                                      fillColor      : Colors.white,
                                                      hintStyle      : TextStyle(fontSize: 15),
                                                      focusedBorder  : OutlineInputBorder(
                                                                       borderSide   : BorderSide(color: Colors.white),
                                                                       borderRadius : BorderRadius.circular(20)
                                                      ),    
                                                      enabledBorder  : OutlineInputBorder(
                                                                       borderSide   : BorderSide(color: Colors.grey[500]),
                                                                       borderRadius : BorderRadius.circular(20)
                                                      ), 
                                                      suffixIcon     : IconButton(
                                                                       icon      : Icon(Icons.search),
                                                                       color     : Get.theme.primaryColor,
                                                                       iconSize  : 30,
                                                                       onPressed : () {
                                                                         Get.to(SearchPage(initSearch: state.searchControllerHome.text));
                                                                         state.resetInput();
                                                                       }
                                                      )
                                         ),
                                         onEditingComplete: (){
                                            Get.to(SearchPage(initSearch: state.searchControllerHome.text));
                                            state.resetInput();
                                         },
                               
                               ),
           ),
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