import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuUsarioExt extends StatelessWidget {
  const MenuUsarioExt({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (state) {
      if (state.usuario != null)
        return Scaffold(
          appBar: AppBar(
                  leading   : _imagenAvatar(state),
                  elevation : 0,
                  title     : Text(state.usuario.nombre),
          ),
          body  :_menu(state) ,
        );
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }




  Widget _imagenAvatar(HomeController state) {
    if (state.usuario.imagen.isEmpty)
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircleAvatar(
          backgroundColor: Get.theme.primaryColor,
          child: Text(state.usuario.nombre[0],
              style: TextStyle(color: Colors.white)),
        ),
      );
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
          '${state.urlImagenes}/usuarios/${state.usuario.imagen}'),
    );
  }

  _menu(HomeController state) {
    return ListView(
           padding: EdgeInsets.only(top: 30),
           children: [
             ListTile(
             leading: Icon(Icons.photo_camera_outlined),
             title: Text('Cambiar Foto'), 
             onTap: (){}, 
             ),
             ListTile(
             leading: Icon(Icons.lock_outline),
             title: Text('Cambiar contraseña'), 
             onTap: (){}, 
             ),
             ListTile(
             leading: Icon(Icons.refresh),
             title: Text('Actualizar Datos'), 
             onTap: (){}, 
             ),
             ListTile(
             leading: Icon(Icons.business_outlined),
             title: Text('Administrar Empresas'), 
             onTap: (){}, 
             ),
             ListTile(
             leading: Icon(Icons.login),
             title: Text('Opciones de inicio de sesion'), 
             onTap: (){}, 
             ),
             ListTile(
             leading: Icon(Icons.info_outline),
             title: Text('Acerca de esta aplicacion'), 
             onTap: (){}, 
             ),
             ListTile(
             leading: Icon(Icons.help_outline),
             title: Text('Ayuda'), 
             onTap: (){}, 
             ),
           ]
           );
  }
}
