import 'package:comproacacias/src/componetes/categorias/views/categorias.view.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/models/loginEnum.model.dart';
import 'package:comproacacias/src/componetes/home/views/Inicio.view.dart';
import 'package:comproacacias/src/componetes/login/views/login.view.dart';
import 'package:comproacacias/src/componetes/publicaciones/views/publicaciones.page.dart';
import 'package:comproacacias/src/componetes/usuario/views/menu.view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
            body: IndexedStack(
              index: state.page,
              children: <Widget>[
                if(state.anonimo == EnumLogin.anonimo || state.anonimo == EnumLogin.notLogin) 
                LoginPage(),
                InicioPage(),
                PublicacionesPage(),
                CategoriasPage(),
                if(state.anonimo == EnumLogin.usuario)
                MenuUsuarioPage(),
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index  : state.page,
              height : 65.0,
              items  : <Widget>[
                if(state.anonimo == EnumLogin.anonimo || state.anonimo == EnumLogin.notLogin) 
                Icon(Icons.login_outlined, size: 30, color: Colors.white),
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.message, size: 30, color: Colors.white),
                Icon(Icons.list, size: 30, color: Colors.white),
                if(state.anonimo == EnumLogin.usuario)
                Icon(Icons.more_vert, size: 30, color: Colors.white),
                
              ],
              color: Theme.of(context).primaryColor,
              buttonBackgroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.transparent,
              onTap: (index) {
                 state.selectPage(index);
              }
            ),
          );
        });
  }

}
