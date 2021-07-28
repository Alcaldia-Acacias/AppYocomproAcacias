import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/views/listProductos.view.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/componetes/usuario/views/actulizarDatos.view.dart';
import 'package:comproacacias/src/componetes/usuario/views/cambiarContrase%C3%B1a.view.dart';
import 'package:comproacacias/src/componetes/empresas/views/empresas.view.dart';
import 'package:comproacacias/src/componetes/usuario/views/help.view.dart';
import 'package:comproacacias/src/componetes/usuario/widgets/menu.widget.dart';
import 'package:comproacacias/src/componetes/widgets/dialogImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuUsuarioPage extends StatelessWidget {
   MenuUsuarioPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
           builder:(state) 
             => Scaffold(
                body: Column(
                      children: [
                          if(state.usuario != null)
                          _header(state),
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
             titulo : 'Contraseña', 
             onTap  : () => Get.to(CambiarPasswordPage(usuario:usuario)), 
             ),
             MenuItemUsuario(
             icon: Icons.business,
             titulo: 'Empresas',
             onTap: ()=>Get.to(ListEmpresasPage(empresas:usuario.empresas)),
             ),
             MenuItemUsuario(
             icon: Icons.shopping_basket_outlined,
             titulo: 'Productos',
             onTap: ()=> Get.to(ListProductos())
             ),
             MenuItemUsuario(
             icon: Icons.refresh,
             titulo: 'Actualizar Datos', 
             onTap : ()=>Get.to(UpdateDataUsuario(usuario:usuario)), 
             ),
             /* MenuItemUsuario(
             icon: Icons.info,
             titulo: 'Acerca',  
             ), */
             MenuItemUsuario(
             icon: Icons.help,
             titulo: 'Ayuda', 
             onTap : ()=>Get.to(HelpPage(idUsuario: usuario.id)), 
             ),
             MenuItemUsuario(
             icon: Icons.power_settings_new,
             titulo: 'Cerrar Sesión',
             onTap: ()=>Get.find<HomeController>().logOut(),
             ),
            
          ],
          );
}

Widget  _header(HomeController state) {
  return  Container(
          alignment : AlignmentDirectional.center,
          height    : Get.height * 0.4,
          width     : Get.width,
          child     : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                                 SizedBox(height: 10),
                                 Text( state.usuario?.nombre,
                                       style: TextStyle(
                                              color    : Colors.white,
                                              fontSize : 25
                                       )
                                 ),
                                 Stack(
                                 overflow: Overflow.visible,
                                   children: [
                                     _imageUsuario(state),
                                     Positioned(
                                     bottom : 0,
                                     right  : -10,
                                     child  : RawChip(
                                              label  : Text('Editar'),
                                              avatar : Icon(Icons.photo_camera),
                                              onPressed: ()=>DialogImagePicker.openDialog(
                                                             titulo: 'Escoge tu Imagen',
                                                             onTapArchivo : () async {
                                                               final selectImage = await state.getImage('archivo');
                                                               this._selectFileImage(selectImage);
                                                             },
                                                             onTapCamera  : () async {
                                                               final selectImage =  await state.getImage('camara');
                                                               this._selectFileImage(selectImage);
                                                             },
                                                             complete     : () => print('se cerro el dialogo')
                                              )                           
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

  _imageUsuario(HomeController  state) {
   if(state.image?.path == null && state.usuario.imagen == '')
    return  CircleAvatar(
                   backgroundColor : Colors.grey[300],
                   radius          : 70,
                   child           : Icon(
                                     Icons.person,
                                     color : Colors.grey[400],
                                     size  : 100
                   )
    );
   
  if(state.image?.path != null)
   return ClipRRect(
         borderRadius: BorderRadius.circular(100),
         child:  FadeInImage(
                 height : 140,
                 width  : 140,
                 fit    : BoxFit.cover,
                 placeholder: AssetImage('assets/imagenes/load_image.gif'), 
                 image: FileImage(state.image)
                 ),
   ); 
   return ClipRRect(
    borderRadius: BorderRadius.circular(300),
    child:  FadeInImage(
            height : 140,
            width  : 140,
            fit    : BoxFit.cover,
            placeholder: AssetImage('assets/imagenes/load_image.gif'), 
            image: NetworkImage('${state.urlImagenes}/usuarios/${state.usuario.imagen}')
            ),
);
}
void _selectFileImage(StateHomeEnum selectImage){
  if(selectImage == StateHomeEnum.imageSelect) Get.back();
  if(selectImage == StateHomeEnum.noImageSelect){
     Get.back();
     Get.snackbar('Error', 'Imagen no selecionada');
  }
  if(selectImage == StateHomeEnum.noInternet){
     Get.back();
     Get.snackbar('Error', 'No hay Conexion a Internet');
  }
}
}
