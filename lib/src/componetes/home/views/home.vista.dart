
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:comproacacias/src/componetes/categorias/views/categorias.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/models/loginEnum.model.dart';
import 'package:comproacacias/src/componetes/home/views/Inicio.view.dart';
import 'package:comproacacias/src/componetes/login/views/login.view.dart';
import 'package:comproacacias/src/componetes/productos/views/productosList.view.dart';
import 'package:comproacacias/src/componetes/publicaciones/views/publicaciones.page.dart';
import 'package:comproacacias/src/componetes/usuario/views/menu.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
           id: 'bottomBar',
           builder: (state) {
                      return Scaffold(
                             body     : IndexedStack(
                                        index    : state.page,
                                        children : <Widget>[
                                                   if(state.anonimo == EnumLogin.anonimo 
                                                      || state.anonimo == EnumLogin.notLogin) 
                                                   LoginPage(),
                                                   InicioPage(),
                                                   if(state.anonimo == EnumLogin.usuario)
                                                   ProductosList(),
                                                   PublicacionesPage(),
                                                   CategoriasPage(),
                                                   if(state.anonimo == EnumLogin.usuario)
                                                   MenuUsuarioPage(),
                                                  ],
                                        ),
                                        bottomNavigationBar: _buttomBarNavigator(state)
          );
        });
  }

  _buttomBarNavigator(HomeController state) {
      return BottomNavyBar(
             backgroundColor : Get.theme.primaryColor,
             selectedIndex   : state.page,
             showElevation   : false,
             onItemSelected  : (index) => state.selectPage(index),
             items           : <BottomNavyBarItem>[
                                 if(state.anonimo == EnumLogin.anonimo || state.anonimo == EnumLogin.notLogin) 
                                 BottomNavyBarItem(
                                 icon        : Icon(Icons.login_rounded),
                                 title       : Text('Ingresar'),
                                 activeColor : Colors.white,
                                 textAlign   : TextAlign.center
                                 ),
                                 BottomNavyBarItem(
                                 icon        : Icon(Icons.home),
                                 title       : Text('Inicio'),
                                 activeColor : Colors.white,
                                 textAlign   : TextAlign.center
                                 ),
                                 if(state.anonimo == EnumLogin.usuario)
                                 BottomNavyBarItem(
                                 icon        : Icon(Icons.shopping_bag_outlined),
                                 title       : Text('Tienda'),
                                 activeColor : Colors.white,
                                 textAlign   : TextAlign.center
                                 ),
                                 BottomNavyBarItem(
                                 icon        : Icon(Icons.message),
                                 title       : Text('Publicaciones',style: TextStyle(fontSize: 11)),
                                 activeColor : Colors.white,
                                 textAlign   : TextAlign.center
                                 ),
                                 BottomNavyBarItem(
                                 icon        : Icon(Icons.list),
                                 title       : Text('Categorias',style: TextStyle(fontSize: 11)),
                                 activeColor : Colors.white,
                                 textAlign   : TextAlign.center
                                 ),
                                 if(state.anonimo == EnumLogin.usuario)
                                 BottomNavyBarItem(
                                 icon        : Icon(Icons.settings),
                                 title       : Text('Opciones'),
                                 activeColor : Colors.white,
                                 textAlign   : TextAlign.center
                                 ),
            ],
    );
  }

}
