import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/views/perfil.empresa.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/widgets/imagenes.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicacionCard extends StatelessWidget {

  
  final Publicacion publicacion;
  final int index;
  final bool onlyEmpresa;
  PublicacionCard({Key key,this.publicacion,this.index,this.onlyEmpresa = false}) : super(key: key);
  
  final String urlImagenLogo = Get.find<HomeController>().urlImegenes;
  
  @override
  Widget build(BuildContext context) {

    return Card(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
           elevation: 0,
           margin : EdgeInsets.all(4),
           child  : Column(
                     children: <Widget>[
                       _header(publicacion),
                       if(publicacion.imagenes.length > 0)
                       GestureDetector(
                       child:Hero(tag:publicacion.id,child: _imagenprincipal(publicacion.imagenes[0])),
                       onTap: (){
                           Get.to(
                             ImagenesWidgetPage(imagenes: publicacion.imagenes,id:publicacion.id),
                             transition: Transition.noTransition
                           );
                       },
                       ),
                       _contenido(publicacion.texto),
                       _footer(publicacion,index),
                     ],
           ),
    );
  }

Widget buttonText(String titulo,IconData icono)
  => RawChip(label: null);

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
                  trailing       : IconButton(
                                   icon: Icon(Icons.more_horiz), 
                                   onPressed: (){}
                                   )
           ),
           onTap: ()=> Get.to(
             PerfilEmpresaPage(
                      empresa: publicacion.empresa,
           ),
           )
  );
}

Widget _contenido(String texto) {
  return  Container(
          alignment : Alignment.topLeft,
          padding   : EdgeInsets.all(8),
          child     : Text(publicacion.texto),
          );

}

Widget _footer(Publicacion publicacion, int index) {
  return Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[ 
                    GestureDetector(
                    child: Padding(
                           padding : EdgeInsets.all(8.0),
                           child   : Icon(Icons.thumb_up,color:Colors.blue[200]),
                    ),
                    onTap: (){
                     Get.find<PublicacionesController>().getLikesByPublicacion(publicacion.id,onlyEmpresa);
                     Get.bottomSheet(_bottomSheetLikes(publicacion.id,index));
                    },
                    ),
                    Text('${publicacion.likes}'),
                    Padding(
                    padding : EdgeInsets.all(8.0),
                    child   : Icon(Icons.textsms,color:Colors.blue[200]),
                    ),
                    Text('${publicacion.numeroComentarios}'),
                     RawChip(
                    label: Text('Me gusta'),
                    onPressed:(){},
                    avatar:Icon(Icons.thumb_up,color:Colors.grey[400]),
                    backgroundColor: Colors.transparent
                    ),
                    RawChip(
                    label: Text('Comentar'),
                    onPressed:(){
                    Get.find<PublicacionesController>().getComentarios(publicacion.id,onlyEmpresa);
                    Get.bottomSheet(_bottomSheetComentarios(publicacion.id,index));
                    },
                    avatar:Icon(Icons.textsms,color:Colors.grey[400]),
                    backgroundColor: Colors.transparent
                    ),
                   ],
  );
}

  Widget _bottomSheetComentarios(int id, int index) {
 
    return Container(
           padding: EdgeInsets.all(3),
           height : Get.height * 0.5,
           child  : Column(
                    children: <Widget>[
                          Text(
                         'Comentarios',
                          style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                          ),
                          SizedBox(height: 20),
                         _listaComentario(id,index),
                         _textField()
                    ],
           ),
           color  : Colors.white, 
    );
  }

Widget _listaComentario(int id, int index) {
   return GetBuilder<PublicacionesController>(
          id: 'comentarios',
          builder: (state){
           final comentarios = state.publicaciones[index].comentarios;
           if(state.loading)
             return Expanded(child: Center(child: CircularProgressIndicator()));
           if(comentarios.length == 0)
              return Expanded(child: Center(child: Text('No hay comentarios')));
           return Expanded(
               child: ListView.builder(
                      itemCount: comentarios.length,
                      itemBuilder: (context,i){
                       return Column(
                              children: <Widget>[
                                   ListTile(
                                   leading  : comentarios[i].imagenUsuario == ''
                                              ?
                                              CircleAvatar(
                                              backgroundImage: AssetImage('assets/imagenes/logo_no_img.png')
                                              )
                                              :
                                              CircleAvatar(
                                              backgroundImage: CachedNetworkImageProvider(
                                                '$urlImagenLogo/usuarios/${comentarios[i].imagenUsuario}'
                                              ),
                                              ),
                                   title    : Text(comentarios[i].nombreUsuario),
                                   subtitle : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                 Text(comentarios[0].comentario),
                                                 SizedBox(height: 4),
                                                 Text(comentarios[0].formatFecha(),style: TextStyle(fontWeight: FontWeight.bold),)
                                              ],
                                   )
                                   ),
                                 
                                   SizedBox(height: 15),
                              ],
                       );
                      }
                      )
               );

          }
          );
}

Widget _textField() {
  return GetBuilder<PublicacionesController>(
         builder: (state) 
           => SafeArea(
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child : TextField(
                        controller      : state.comentarioController,
                        focusNode       : FocusNode(),
                        keyboardType    : TextInputType.multiline,
                        maxLines        : null,
                        decoration: InputDecoration(
                                    filled         : true,
                                    fillColor      : Colors.white,
                                    suffixIcon     : IconButton(
                                                     icon: Icon(Icons.send), 
                                                     onPressed: (){
                                                       print("object");
                                                     }
                                                     ),
                                    contentPadding : EdgeInsets.all(10),
                                    hintText       : "Escriba tu Comentario",
                                   
                                    enabledBorder  : OutlineInputBorder(
                                                     borderRadius : BorderRadius.circular(30),
                                                     borderSide   : BorderSide(color:Colors.grey)
                                    ),
                                    focusedBorder  : OutlineInputBorder(
                                                     borderRadius : BorderRadius.circular(30),
                                                     borderSide   : BorderSide(color: Color.fromRGBO(255,57,163, 1))
                                    )
                        ),
           ),
              )
           )
         );
  
}

Widget _imagenprincipal(String imagen) {
    return SizedBox(
           height: 300,
           width: Get.height,
           child: CachedNetworkImage(
           imageUrl: '$urlImagenLogo/galeria/$imagen',
           placeholder: (context, url) => Center(child: CircularProgressIndicator()),
           errorWidget: (context, url, error) => Icon(Icons.error),
           fit: BoxFit.cover,
    ),
    );
}

Widget _listaDelikes(int id, int index) {
   return GetBuilder<PublicacionesController>(
          id: 'likes',
          builder: (state){
           final usuarios = state.publicaciones[index].usuariosLike;
           if(state.loading)
             return Expanded(child: Center(child: CircularProgressIndicator()));
           if(usuarios.length == 0)
              return Expanded(child: Center(child: Text('No hay me gustan')));
           return Expanded(
               child: ListView.builder(
                      itemCount: usuarios.length,
                      itemBuilder: (context,i){
                       return Column(
                            
                              children: <Widget>[
                                   ListTile(
                                   leading  : usuarios[i].urlImagen == ''
                                              ? 
                                              CircleAvatar(
                                                backgroundImage: AssetImage('assets/imagenes/logo_no_img.png')
                                              )
                                              :
                                              CircleAvatar(
                                              backgroundImage: CachedNetworkImageProvider(
                                                '$urlImagenLogo/usuarios/${usuarios[i].urlImagen}'
                                              ),
                                              ),
                                   title    : Text(usuarios[i].nombre),
                                   subtitle : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                 Text('Le gusto la Publicacion'),
                                                 SizedBox(height: 4),
                                                 //Text(usuarios[0].formatFecha(),style: TextStyle(fontWeight: FontWeight.bold),)
                                              ],
                                   )
                                   ),
                                 
                                   SizedBox(height: 15),
                              ],
                       );
                      }
                      )
               );

          }
          );
    
  }

  Widget _bottomSheetLikes(int id, int index) {
   return Container(
           padding: EdgeInsets.all(3),
           height : Get.height * 0.5,
           child  : Column(
                    children: <Widget>[
                          Text(
                         'A estas personas les gusto',
                          style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                          ),
                          SizedBox(height: 20),
                         _listaDelikes(id,index),
                         //_textField()
                    ],
           ),
           color  : Colors.white, 
    );
  }


}