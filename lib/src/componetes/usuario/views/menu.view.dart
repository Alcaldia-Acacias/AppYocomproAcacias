import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/componetes/usuario/views/actulizarDatos.view.dart';
import 'package:comproacacias/src/componetes/usuario/views/cambiarContrase%C3%B1a.view.dart';
import 'package:comproacacias/src/componetes/empresas/views/empresas.view.dart';
import 'package:comproacacias/src/componetes/usuario/widgets/menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuUsuarioPage extends StatelessWidget {
  const MenuUsuarioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
           builder:(state) 
             => Scaffold(
                body: Column(
                      children: [
                          if(state.usuario != null)
                          _header(state.usuario),
                          if(state.usuario != null)
                          Expanded(
                          child: _menu(state.usuario)
                          )
                      ],
             ),
      ),
    );
  }

Widget _menu(Usuario usuario) {
  return GridView.count(
          padding: EdgeInsets.all(10),
          crossAxisCount: 3,
          children: [
             MenuItemUsuario(
             icon   : Icons.lock_outline,
             titulo : 'Cambiar Contraseña', 
             onTap  : () => Get.to(CambiarPasswordPage(usuario:usuario)), 
             ),
             MenuItemUsuario(
             icon: Icons.business,
             titulo: 'Empresas',
             onTap: ()=>Get.to(ListEmpresasPage(empresas:usuario.empresas)),
             ),
             MenuItemUsuario(
             icon: Icons.refresh,
             titulo: 'Actulizar Datos', 
             onTap : ()=>Get.to(UpdateDataUsuario(usuario:usuario)), 
             ),
             MenuItemUsuario(
             icon: Icons.info,
             titulo: 'Acerca',  
             ),
             MenuItemUsuario(
             icon: Icons.help,
             titulo: 'Ayuda',  
             ),
             MenuItemUsuario(
             icon: Icons.power_settings_new,
             titulo: 'Cerrar Sesion',
             onTap: ()=>Get.find<HomeController>().logOut(),
             ),
            
          ],
          );
}

Widget  _header(Usuario usuario) {
  return  Container(
          alignment : AlignmentDirectional.center,
          height    : Get.height * 0.4,
          width     : Get.width,
          child     : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                                 SizedBox(height: 10),
                                 Text( usuario?.nombre,
                                       style: TextStyle(
                                              color    : Colors.white,
                                              fontSize : 25
                                       )
                                 ),
                                 Stack(
                                 overflow: Overflow.visible,
                                   children: [
                                     CircleAvatar(
                                     radius          : 70,
                                     backgroundImage : usuario.imagen != ''
                                                       ? CachedNetworkImageProvider('http://localhost:8000/imagenes/usuarios/${usuario.imagen}')
                                                       : AssetImage('assets/imagenes/logo_no_img.png'),
                                     ),
                                     Positioned(
                                     bottom : 0,
                                     right  : -10,
                                     child  : RawChip(
                                              label  : Text('Editar'),
                                              avatar : Icon(Icons.photo_camera),
                                     )
                                     )
                                   ],
                                 )
                      ],
          ),
          decoration: BoxDecoration(
                       gradient: LinearGradient(
                                 colors: [
                                 Get.theme.primaryColor,
                                 Get.theme.accentColor
                                 ]
                             )
                 ),
           );
}
}
