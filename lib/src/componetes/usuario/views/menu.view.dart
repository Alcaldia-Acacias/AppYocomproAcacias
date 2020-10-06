import 'package:comproacacias/src/componetes/usuario/widgets/menu.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuUsuarioPage extends StatelessWidget {
  const MenuUsuarioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Column(
                 children: [
                     _header(),
                     Expanded(
                     child: _menu()
                     )
                 ],
           ),
    );
  }

Widget _menu() {
  return GridView.count(
          padding: EdgeInsets.all(10),
          crossAxisCount: 3,
          children: [
             MenuItemUsuario(
             icon   : Icons.lock_outline,
             titulo : 'Cambiar Contraseña', 
             onTap  : (){
    
             }, 
             ),
             MenuItemUsuario(
             icon: Icons.business,
             titulo: 'Empresas',  
             ),
             MenuItemUsuario(
             icon: Icons.refresh,
             titulo: 'Actulizar Datos',  
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
             titulo: 'Cerrar Sesion'
             ),
            
          ],
          );
}

Widget  _header() {
  return  Container(
          alignment : AlignmentDirectional.center,
          height    : 300,
          width     : Get.width,
          child     : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                                 SizedBox(height: 10),
                                 Text('Alan Fabian Herrera',
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
                                     backgroundImage : AssetImage('assets/imagenes/logo_no_img.png'),
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
