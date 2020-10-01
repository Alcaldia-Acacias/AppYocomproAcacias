import 'package:comproacacias/src/componetes/home/views/home.vista.dart';
import 'package:comproacacias/src/componetes/inyection.dependeci.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//import 'package:intl/locale.dart';

void main() {
  Intl.defaultLocale = 'es_ES';

  Dependecias.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  PublicacionesRepositorio repoPublicaciones = PublicacionesRepositorio();
  @override
  Widget build(BuildContext context) {
   
 
      
   
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
    
      home: HomePage()
    );
  }
}
