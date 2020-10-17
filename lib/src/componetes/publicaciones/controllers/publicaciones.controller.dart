import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/like.model.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class PublicacionesController extends GetxController {
  final PublicacionesRepositorio repositorio;

  PublicacionesController({this.repositorio});

  List<Publicacion> publicaciones = [];
  List<Publicacion> publicacionesByempresa = [];
  ScrollController controller;
  int _pagina = 0;
  TextEditingController comentarioController = TextEditingController();
  bool loading = false;
  final box = GetStorage();
  int idUsuario;
  @override
  void onInit() async {
    super.onInit();
    idUsuario = box.read('id');
    controller = controller = ScrollController(initialScrollOffset: 0);
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent)
        this.getPublicaciones();
    });
    this.getPublicaciones();
  }

  void getPublicaciones() async {
    publicaciones
        .addAll(await repositorio.getPublicaciones(_pagina, idUsuario));
    if (_pagina > 1) this._animationFinalController();
    _pagina++;
    update(['publicaciones']);
  }

  void getNewPublicaciones() async {
    publicaciones = await repositorio.getPublicaciones(1, idUsuario);
    update(['publicaciones']);
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void _animationFinalController() {
    controller.animateTo(controller.position.pixels + 100,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  void getPublicacionesByempresa(int id) async {
    this.loading = true;
    this.publicacionesByempresa =
        await repositorio.getPublicacionesByEmpresa(id, idUsuario);
    this.loading = false;
    update(['empresa']);
  }

  void megustaAction(int idPublicacion, int index) async {
    final usuario = Get.find<HomeController>().usuario;
    final response =
        await repositorio.meGustaPublicacion(idPublicacion, idUsuario);
    final likes = publicaciones[index].likes;
    publicaciones[index] =
        publicaciones[index].copyWith(megusta: true, likes: (likes + 1));
    publicaciones[index].usuariosLike.add(this._addusuarioLike(usuario));
    print(response);
    update(['publicaciones']);
  }

  void noMegustaAction(int idPublicacion, int index) async {
    final response =
        await repositorio.noMeGustaPublicacion(idPublicacion, idUsuario);
    final likes = publicaciones[index].likes;
    publicaciones[index] =
        publicaciones[index].copyWith(megusta: false, likes: (likes - 1));
    publicaciones[index].usuariosLike.removeAt(
        this._removeUsuarioLike(publicaciones[index].usuariosLike, idUsuario));
    update(['publicaciones']);
  }
  void comentarPublicacion(){
  

  }
  LikePublicacion _addusuarioLike(Usuario usuario) {
    return LikePublicacion(
        fecha: DateTime.now().toString(),
        usuario: Usuario(
            id: usuario.id, imagen: usuario.imagen, nombre: usuario.nombre));
  }

  int _removeUsuarioLike(List<LikePublicacion> likes, int idUsuario) {
    return likes.indexWhere((like) => like.usuario.id == idUsuario);
  }


}
