import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/data/categorias.repositorio.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/home/views/home.vista.dart';
import 'package:comproacacias/src/componetes/inyection.dependeci.dart';
import 'package:comproacacias/src/componetes/login/views/login.view.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

//import 'package:intl/locale.dart';

 main() async {
  Intl.defaultLocale = 'es_ES';
  await GetStorage.init();
  // await GetStorage().erase();
  Dependecias.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  PublicacionesRepositorio repoPublicaciones = PublicacionesRepositorio();
  @override
  Widget build(BuildContext context) {
    final box  = GetStorage();
    return GetMaterialApp(
      localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
       DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [  const Locale('es'),],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255,57,163, 1),
        accentColor : Color.fromRGBO(0, 201, 211, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,

        appBarTheme: AppBarTheme(
                     brightness: Brightness.light,
                     color: Colors.white,
                     textTheme: TextTheme(
                                title: TextStyle(color:Colors.black,fontSize: 28)
                     ),
                     iconTheme:  IconThemeData(
                                 color: Colors.black
                     )
        )
      ),
     
      initialRoute: box.hasData('token') ? '/home' : '/',
      getPages: [
        GetPage(
        name: '/home', 
        page: ()=>HomePage(),
        bindings: [
          BindingsBuilder.put( () => HomeController(repositorio:HomeRepocitorio())),
          BindingsBuilder.put( () => PublicacionesController(repositorio:PublicacionesRepositorio())),
          BindingsBuilder.put( () => CategoriasController(repositorio:CategoriaRepositorio()))
        ]
        ),
        GetPage(
        name: '/', 
        page: ()=>LoginPage(),
        ),
      ],
    );
  }
}
