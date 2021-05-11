import 'dart:ui';

import 'package:comproacacias/src/componetes/empresas/views/calificaciones.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/models/notificacion.model.dart';
import 'package:comproacacias/src/componetes/home/views/mensaje.view.dart';
import 'package:comproacacias/src/componetes/publicaciones/views/publicacion.wiew.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotificationPage extends StatelessWidget {

   final String urlImagenes = Get.find<HomeController>().urlImagenes;
   NotificationPage({Key key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title     : Text('Notificaciones'),
                   elevation : 0,
           ),
           body  : _notificaciones(),
    );
  }

 Widget _notificaciones() {
  return GetBuilder<HomeController>(
         builder: (state){
           return ListView.builder(
             itemCount   : state.notifications.length,
             itemBuilder : (_,int i) {
                           final notificaciones = state.notifications;
                           return Ink(
                                  color : notificaciones[i].leida ? Colors.transparent : Colors.grey[200],
                                  child : ListTile(
                                          leading  : _imagenUsuario(notificaciones[i].usuario.imagen),
                                          title    : _getTitulo(notificaciones[i]),
                                          subtitle : Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if(notificaciones[i].tipo == NotificacionTipo.MEGUSTA)
                                                         Text('${notificaciones[i].usuario.nombre}'),
                                                      if(
                                                         notificaciones[i].tipo == NotificacionTipo.COMENTARIO || 
                                                         notificaciones[i].tipo == NotificacionTipo.MENSAJE
                                                        )
                                                         Text('${notificaciones[i].mensaje}',overflow: TextOverflow.ellipsis),
                                                      if(notificaciones[i].tipo == NotificacionTipo.CALIFICACION)
                                                         Text('${notificaciones[i].mensaje}'),
                                                      Text('${notificaciones[i].formatFecha()}'),
                                                    ],
                                          ),
                                          onTap: (){
                                            state.leerNotificaciones(notificaciones[i].id);
                                            if(notificaciones[i].tipo == NotificacionTipo.COMENTARIO)
                                               Get.to(PublicacionPage(idPublicacion: notificaciones[i].idPublicacion,pagina: 0));
                                            if(notificaciones[i].tipo == NotificacionTipo.MEGUSTA)
                                               Get.to(PublicacionPage(idPublicacion: notificaciones[i].idPublicacion,pagina: 1));
                                            if(notificaciones[i].tipo == NotificacionTipo.CALIFICACION)
                                               Get.to(CalificacionesLisTPage(idEmpresa: notificaciones[i].idEmpresa));
                                            if(notificaciones[i].tipo == NotificacionTipo.MENSAJE)
                                               Get.to(MensajePage(mensaje: notificaciones[i].mensaje,fecha: notificaciones[i].formatFecha()));
                                          },
                                  ),
                           );
                    
            },
           );
         }
  );
 }



 Widget _imagenUsuario(String imagen) {
   return ClipRRect(
    borderRadius: BorderRadius.circular(300),
    child:  FadeInImage(
            height : 50,
            width  : 50,
            fit    : BoxFit.cover,
            placeholder: AssetImage('assets/imagenes/load_image.gif'), 
            image: imagen == null || imagen == ''
                   ? AssetImage('assets/imagenes/logo_no_img.png')
                   : NetworkImage('$urlImagenes/usuarios/$imagen')
            ),
   );
 }

 Widget _getTitulo(Notificacion notificacion) {
   if(notificacion.tipo == NotificacionTipo.MEGUSTA)
      return Text(
            'Recibiste un me gusta de',
             style: TextStyle(fontWeight: FontWeight.bold)
      );
   if(notificacion.tipo == NotificacionTipo.COMENTARIO)
      return Text(
            '${notificacion.usuario.nombre} comento',
             style: TextStyle(fontWeight: FontWeight.bold)
      );
   if(notificacion.tipo == NotificacionTipo.CALIFICACION)
      return Text(
            '${notificacion.usuario.nombre} califico',
             style: TextStyle(fontWeight: FontWeight.bold)
      );
   if(notificacion.tipo == NotificacionTipo.MENSAJE)
      return Text(
            'Yo Compro Acaciás te envio un mensaje',
             style: TextStyle(fontWeight: FontWeight.bold)
      );
    return Container();
 }
}

