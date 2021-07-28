import 'dart:io';

import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/views/calificaciones.view.dart';
import 'package:comproacacias/src/componetes/home/data/home.repositorio.dart';
import 'package:comproacacias/src/componetes/home/models/loginEnum.model.dart';
import 'package:comproacacias/src/componetes/home/models/notificacion.model.dart';
import 'package:comproacacias/src/componetes/home/models/response.model.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/home/models/youtubeVideo.model.dart';
import 'package:comproacacias/src/componetes/home/views/mensaje.view.dart';
import 'package:comproacacias/src/componetes/publicaciones/views/publicacion.wiew.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:comproacacias/src/plugins/compress.image.dart';
import 'package:comproacacias/src/plugins/image_piker.dart';
import 'package:comproacacias/src/plugins/notificationPush.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:comproacacias/src/plugins/google_sing_in.dart';

 

class HomeController extends GetxController {

  final HomeRepocitorio repositorio;
  final String urlImagenes;

  HomeController({this.repositorio, this.urlImagenes, this.anonimo});

  int page = 0;
  int notificacionesNoLeidas = 0;

  List<YouTubeVideo> videos = [];
  List<Notificacion> notifications = [];
  List<Empresa> empresas = [];
  List<Empresa> topEmpresas = [];

  AnimationController controller;
  ImageCaptureAvatar imageCapture = ImageCaptureAvatar();
  TextEditingController searchControllerHome = TextEditingController();
  PushNotification pushNotification = Get.find<PushNotification>();
  EnumLogin anonimo;
  Usuario usuario;
  File image;
 

  @override
  void onInit() async {
    if (anonimo == EnumLogin.notLogin) {
      await this.getTokenAnonimo();
      this.getvideos();
      this.getTopEmpresas();
    }

    if (anonimo == EnumLogin.anonimo) {
      this.getvideos();
      this.getTopEmpresas();
    }

    if (anonimo == EnumLogin.usuario) {
      this.getvideos();
      this.getTopEmpresas();
      if (this.usuario.isNullOrBlank) {
        await this.getUsuario();
        await this.loginInitOption();
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    this.searchControllerHome.dispose();
    this.pushNotification.onMesaje().cancel();
    super.onClose();
  }

  void updateUsuario(Usuario usuario) {
    this.usuario = usuario;
    update();
  }

  void selectPage(int page) {
    this.page = page;
    update(['bottomBar']);
  }

  void logOut() async {
    await GetStorage().erase();
    await googleLogOut();
    await FacebookAuth.instance.logOut();
    this.anonimo = EnumLogin.notLogin;
    this.selectPage(0);
    update();
  }

  void registroActividad() async {
    final response = await repositorio.registroActividad(this.usuario.id);
    if (response is ErrorResponse) print(response.error);
    if (response is HomeResponse) print(response);
  }

  void getvideos() async {
    final response = await repositorio.getVideosYoutbe();
    if (response is ErrorResponse) print(response.error);
    if (response is HomeResponse) {
      this.videos = response.videos;
      update(['videos']);
    }
  }

  void resetInput() => this.searchControllerHome.text = '';

  void getTopEmpresas() async {
    final response = await repositorio.getTop10Empresas();
    if (response is ResponseEmpresa) {
      topEmpresas = response.empresas;
      update(['top']);
    }
  }

  void getNotificaciones() async {
    final response = await repositorio.getNotificaciones(usuario.id);
    if (response is ResponseHome) {
      this.notificacionesNoLeidas =
          _getNumberNotificaciones(response.notificaciones);
      this.notifications = response.notificaciones;
      update();
    }
    if (response is ErrorResponse) {
      print('error');
    }
  }

  void leerNotificaciones(int idNotificacion) async {
    final response = await repositorio.leerNotificacion(idNotificacion);
    if (response is ResponseHome) {
      if (response.notificacionLeida) {
        _updateNotificaciones(idNotificacion);
      }
    }
    if (response is ErrorResponse) print(response.getError);
  }

  Future<void> getTokenAnonimo() async {
    final response = await repositorio.getTokenAnonimo();
    if (response is ResponseHome) {
      final box = GetStorage();
      await box.write('token', response.tokenAnonimo);
      Get.find<Dio>().options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer ${response.tokenAnonimo}'
      };
    }
    if (response is ErrorResponse) print(response.error);
  }

  Future<void> loginInitOption() async {
    await this.getUsuario();
    this._inicialPushNotificacitions();
    this.registroActividad();
    this._verificarTokenPush();
    this.getNotificaciones();
  }
  
  Future<void> getUsuario() async {
    this.anonimo = EnumLogin.usuario;
    this.usuario = await repositorio.getUsuario();
    update();
  }
  // usuario controller
  Future<StateHomeEnum> getImage(String tipo) async {
    final imageCap = await imageCapture.getImage(tipo);
    if (!imageCap.isNullOrBlank) {
      image = await CompressImagePlugin.getImage(
          imageCap, imageCapture.height, imageCapture.width);
      final response = await repositorio.updateImagen(image.path, usuario.id);
      if (response is HomeResponse) {
         imageCap.delete();
         update();
      }
      if (response is ErrorResponse){
          if(response.getError == 'Connection refused')
           return StateHomeEnum.noInternet;
      }
    }
    if (imageCap.isNullOrBlank){
      return StateHomeEnum.noImageSelect;
    }
   return StateHomeEnum.imageSelect;
  }
  
  /* void _errorResponse(String error) {
    if (error == 'Connection refused')
      Get.snackbar('No estas Conectdo', 'Conectate a Internet');
  } */

  void _verificarTokenPush() async {
    final token = await this.pushNotification.getToken();
    final response =
        await this.repositorio.registrarTokenPush(token, usuario.id);
    if (response is ResponseHome) {
      response.registrarToken
          ? print('El token ya esta registrado')
          : print('se registro el token');
    }
    if (response is ErrorResponse) 
        print(response.getError);
  }

  void _inicialPushNotificacitions() async {
    pushNotification.init();

    this.pushNotification.onMesaje().onData((data) {
      this.notificacionesNoLeidas++;
      this.getNotificaciones();
    });

    this.pushNotification.onOpenApp().onData((message) {
      final tipo = Notificacion.getTipo(message.data['tipo']);
      final int idTipo = int.parse(message.data['id_tipo']);
      this._onOpenAppNotification(tipo, idTipo, message.notification.body);
      this.notificacionesNoLeidas++;
      this.getNotificaciones();
    });
    this.pushNotification.onBackground().then((message) {
      if (message?.data != null) {
        final tipo = Notificacion.getTipo(message.data['tipo']);
        final int idTipo = int.parse(message.data['id_tipo']);
        this._onOpenAppNotification(tipo, idTipo, message.notification.body);
      }
    });
  }

  void _updateNotificaciones(int idNotificacion) {
    final index = this
        .notifications
        .indexWhere((notificacion) => notificacion.id == idNotificacion);
    this.notifications[index] = this.notifications[index].copyWith(leida: true);
    if (this.notificacionesNoLeidas > 0) this.notificacionesNoLeidas--;
    update();
  }

  void _onOpenAppNotification(
      NotificacionTipo tipo, int idTipo, String mensaje) {
    switch (tipo) {
      case NotificacionTipo.MEGUSTA:
        Get.to(PublicacionPage(idPublicacion: idTipo, pagina: 1));
        break;
      case NotificacionTipo.COMENTARIO:
        Get.to(PublicacionPage(idPublicacion: idTipo, pagina: 0));
        break;
      case NotificacionTipo.CALIFICACION:
        Get.to(CalificacionesLisTPage(idEmpresa: idTipo));
        break;
      case NotificacionTipo.MENSAJE:
        Get.to(MensajePage(mensaje: mensaje, fecha: 'Ahora'));
        break;
      default:
        break;
    }
  }
 
  int _getNumberNotificaciones(List<Notificacion> notificaciones) {
    if (notificaciones.length > 0)
      return notificaciones
          .map((e) => e.leida == false ? 1 : 0)
          .reduce((value, elemento) => value + elemento);
    return 0;
  }
}

enum  StateHomeEnum {
  noImageSelect,
  imageSelect,
  noInternet
}
