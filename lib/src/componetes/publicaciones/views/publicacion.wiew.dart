import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicacion.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/like.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/cometario.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/widgets/imagenes.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicacionPage extends StatelessWidget {

  final int idPublicacion;
  final int pagina;
  PublicacionPage({Key key, this.idPublicacion,this.pagina}) : super(key: key);
  final String urlImagenLogo = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
           appBar : AppBar(
                   elevation : 0,
                   title     : Text('Publicacion'),
           ),
           body   : GetBuilder<PublicacionController>(
                    id: 'publicacion',
                    init: PublicacionController(idPublicacion: idPublicacion,repocitorio: PublicacionesRepositorio(),pagina: pagina),
                    builder: (state){
                      if(state.publicacion == null)
                         return Center(child: CircularProgressIndicator());
                      return SingleChildScrollView(child: _publicacion(state.publicacion,state.pagina));
                    }
           
           ),
    );
  }

  Widget _publicacion(Publicacion publicacion,int pagina) {
    return Column(
           children: [
           _publicacionCard(publicacion),
           _likesYComentarios(pagina),
            AnimatedSwitcher(
            switchInCurve : Curves.easeInOut,
            duration      : Duration(milliseconds: 300),
            child         : IndexedStack(
                            key     : ValueKey<int>(pagina),
                            index   : pagina,
                            children: [
                                     _comentarios(publicacion.comentarios),
                                     _likes(publicacion.usuariosLike)
                            ],  
            ),
            )
           ]
    );
  }

Widget _header(Publicacion publicacion) {
  return   GestureDetector(
           child: ListTile(
                  contentPadding : EdgeInsets.all(4),
                  leading        : publicacion.empresa.urlLogo == '' 
                                   ? CircleAvatar(backgroundImage: AssetImage('assets/imagenes/logo_no_img.png'))
                                   : CircleAvatar(
                                   radius: 24,
                                   backgroundImage: CachedNetworkImageProvider('$urlImagenLogo/logo/${publicacion.empresa.urlLogo}'),    
                  ),
                  title          : Text(
                                   publicacion.empresa.nombre,
                                   style:TextStyle(fontWeight:FontWeight.bold)
                                  ),
                  subtitle       : Text(publicacion.formatFecha()),
           ),
           onTap: ()=> Get.to(
             PerfilEmpresaPage(
                      empresa: publicacion.empresa,
           ),
           )
  );
}
Widget _imagenprincipal(String imagen) {
    return SizedBox(
           height : 300,
           width  : Get.height,
           child  : CachedNetworkImage(
                    imageUrl    : '$urlImagenLogo/galeria/$imagen',
                    placeholder : (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget : (context, url, error) => Icon(Icons.error),
                    fit         : BoxFit.cover,
           ),
    );
}

Widget _imagenes(List<String> imagenes) {
  return SizedBox(
    child: Row(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
            ...imagenes.skip(1).map((imagen) => 
                 Expanded(
                   child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: FittedBox(
                                 fit: imagenes.length == 2 ? BoxFit.contain : BoxFit.fill,
                                 alignment: Alignment.topLeft,
                                 child  : Container(
                                     decoration: BoxDecoration(
                                                 border: Border.all(
                                                    width: 10,
                                                    color: Colors.white
                                                 )
                                     ),
                                     child: CachedNetworkImage(
                                            imageUrl    : '$urlImagenLogo/galeria/$imagen',
                                            placeholder : (context, url) =>  Image.asset('assets/imagenes/load_image.gif'),
                                            errorWidget : (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                     ),
                   ),
                 )
            
            )
           ],
    ),
  );
}
Widget _contenido(String texto) {
  return  Container(
          alignment : Alignment.topLeft,
          padding   : EdgeInsets.all(8),
          child     : Text(texto),
          );

}

  _publicacionCard(Publicacion publicacion) {
    return   Card(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
             elevation: 0,
             margin : EdgeInsets.all(4),
             child  : Column(
                      children: <Widget>[
                               _header(publicacion),
                               _contenido(publicacion.texto),
                               if(publicacion.imagenes.length > 0)
                               GestureDetector(
                               child:Hero(tag:publicacion.id,child: _imagenprincipal(publicacion.imagenes[0])),
                               onTap: (){
                                  Get.to(
                                  ImagenesWidgetPage(
                                  imagenes : publicacion.imagenes,
                                  id       :publicacion.id
                                  ),
                                  transition: Transition.noTransition
                                  );
                               },
                               ),
                               if(publicacion.imagenes.length > 1)
                               _imagenes(publicacion.imagenes),
                      ],
             ),
             );
  }

Widget  _likesYComentarios(int pagina) {
          return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     RawChip(
                     label           : Text('Comentarios'),
                     backgroundColor : pagina == 0 ? Get.theme.primaryColor : Colors.grey[200],
                     labelStyle      : TextStyle(color: pagina == 0 ? Colors.white : Colors.black54),
                     onPressed       : ()=> Get.find<PublicacionController>().changePagina(0),
                     ),
                     RawChip(
                     label           : Text('Me gustan'),
                     backgroundColor : pagina == 1 ? Get.theme.primaryColor : Colors.grey[200],
                     labelStyle      : TextStyle(color: pagina == 1 ? Colors.white : Colors.black54),
                     onPressed       : ()=> Get.find<PublicacionController>().changePagina(1),
                     ),
                  
                   ],  
          );
                  
  }

  _likes(List<LikePublicacion> usuariosLike) {
      return Column(
             children: usuariosLike.map<Widget>((usuarios){
               return  ListTile(
                              leading  : usuarios.usuario.imagen== ''
                                         ? 
                                         CircleAvatar(
                                           backgroundImage: AssetImage('assets/imagenes/logo_no_img.png')
                                         )
                                         :
                                         CircleAvatar(
                                         backgroundImage: CachedNetworkImageProvider(
                                           '$urlImagenLogo/usuarios/${usuarios.usuario.imagen}'
                                         ),
                                         ),
                              title    : Text(usuarios.usuario.nombre),
                              subtitle : Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: <Widget>[
                                            Text('Le gusto la Publicacion'),
                                            SizedBox(height: 4),
                                            //Text(usuarios[0].formatFecha(),style: TextStyle(fontWeight: FontWeight.bold),)
                                         ],
                              )
                              );
             }).toList(),
      );  
      
  }

  _comentarios(List<Comentario> comentarios) {
     return Column(
            children: comentarios.map<Widget>((comentarios){
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                       contentPadding: EdgeInsets.all(5),
                       leading  : comentarios.usuario.imagen == ''
                                  ?
                                  CircleAvatar(
                                  maxRadius: 40,
                                  backgroundImage: AssetImage('assets/imagenes/logo_no_img.png')
                                  )
                                  :
                                  CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    '$urlImagenLogo/usuarios/${comentarios.usuario.imagen}'
                                  ),
                                  ),
                       title    : Text(comentarios.usuario.nombre),
                       subtitle : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                     Text(comentarios.comentario),
                                     SizedBox(height: 4),
                                     Text(comentarios.formatFecha(),style: TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                       )
                       ),
              );
            }).toList(),
     );
  }
}