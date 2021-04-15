import 'dart:io';

import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/data/categorias.repositorio.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/home/models/loginEnum.model.dart';
import 'package:comproacacias/src/componetes/home/views/home.vista.dart';
import 'package:comproacacias/src/componetes/login/views/offline.page.dart';
import 'package:comproacacias/src/plugins/inyection.dependeci.dart';
import 'package:comproacacias/src/componetes/login/controller/login.controller.dart';
import 'package:comproacacias/src/componetes/login/data/login.repositorio.dart';
import 'package:comproacacias/src/componetes/login/views/login.view.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

//import 'package:intl/locale.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Intl.defaultLocale = 'es_ES';
  await GetStorage.init();
  await FacebookAuth.instance.logOut();
  //await GetStorage().erase();
  Dependecias.init('http://192.168.2.101:8000');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final  internetCheck = await verificationInternet();
  runApp(MyApp(internetCheck:internetCheck));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final internetCheck;
  final box  = GetStorage();
  MyApp({Key key, this.internetCheck}) : super(key: key);
  @override
  Widget build(BuildContext context)  {
  
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
                                // ignore: deprecated_member_use
                                title: TextStyle(color:Colors.black,fontSize: 20)
                     ),
                     iconTheme:  IconThemeData(
                                 color: Colors.black
                     )
        )
      ),
     
      initialRoute: _inititialRoute(),
      getPages: [
        GetPage(
        name: '/home', 
        page: ()=>HomePage(),
        bindings: [
          BindingsBuilder.put( () => HomeController(
                                     anonimo     :  _getEnumLogin(),
                                     repositorio :  HomeRepocitorio(),
                                     urlImagenes : 'http://192.168.2.101:8000/imagenes'
                                     )
          ),
          BindingsBuilder.put(() => PublicacionesController(repositorio: PublicacionesRepositorio())),
          BindingsBuilder.put(() => CategoriasController(repositorio:CategoriaRepositorio())),
        ]
        ),
        GetPage(
        name: '/', 
        page: ()=>LoginPage(),
        binding : BindingsBuilder.put(() => LoginController(repositorio:LoginRepositorio())),
        ),
        GetPage(
        name: '/offline', 
        page: ()=>OfflinePage(),
        binding : BindingsBuilder.put(() => LoginController(repositorio:LoginRepositorio())),
        ),
      ],
    );
  }

  String _inititialRoute()  {
    if(box.hasData('token') && internetCheck)
       return '/home';
    if(box.hasData('token') && !internetCheck)
       return '/offline';
    if(!box.hasData('token') && !internetCheck)
       return '/offline';   
    if(!box.hasData('token') && internetCheck)
       return '/home';
    return '/';
  }
  
  EnumLogin _getEnumLogin(){
  if(box.hasData('token') &&  box.hasData('id'))
   return EnumLogin.usuario;
  if(!box.hasData('token') && !box.hasData('id'))
   return EnumLogin.notLogin;
  if(box.hasData('token') &&  !box.hasData('id'))
   return EnumLogin.anonimo;
  return EnumLogin.notLogin;
  }
  

}


 Future<bool> verificationInternet() async {
     try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}
