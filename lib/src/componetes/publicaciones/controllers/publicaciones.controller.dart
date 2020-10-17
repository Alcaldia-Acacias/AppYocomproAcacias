import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/cometario.model.dart';
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
    await repositorio.meGustaPublicacion(idPublicacion, idUsuario);
    this._addusuarioLike(usuario, index);
    update(['publicaciones']);
  }

  void noMegustaAction(int idPublicacion, int index) async {
   await repositorio.noMeGustaPublicacion(idPublicacion, idUsuario);
    this._removeUsuarioLike(index);
    update(['publicaciones']);
  }

  void comentarPublicacion(int idPublicacion, int index) async {
    final usuario = Get.find<HomeController>().usuario;
    if (comentarioController.text.isNotEmpty) {
       await repositorio.comentarPublicacion(
          comentarioController.text, idPublicacion, idUsuario);
      this._addComentario(usuario, index);
      comentarioController?.clear();
      update(['comentarios','publicaciones']);
    }
  }

  void _addComentario(Usuario usuario, int index) {
    final comentarios = publicaciones[index].numeroComentarios;
    final comentario = Comentario(
                       comentario : comentarioController.text,
                       fecha      : DateTime.now().toString(),
                       usuario    : Usuario(
                                    nombre : usuario.nombre,
                                    imagen : usuario.imagen,
                                    id     : usuario.id
                       )
    );
    publicaciones[index].comentarios.insert(0,comentario);
    publicaciones[index] = publicaciones[index].copyWith(numeroComentarios: (comentarios+1));
  }

  void _addusuarioLike(Usuario usuario, int index) {
    final likes = publicaciones[index].likes;
    publicaciones[index] =
        publicaciones[index].copyWith(megusta: true, likes: (likes + 1));
    publicaciones[index].usuariosLike.add(LikePublicacion(
        fecha: DateTime.now().toString(),
        usuario: Usuario(
            id: usuario.id, imagen: usuario.imagen, nombre: usuario.nombre)));
  }

  void _removeUsuarioLike(int index) {
    final likes = publicaciones[index].likes;
    publicaciones[index] =
        publicaciones[index].copyWith(megusta: false, likes: (likes - 1));
    publicaciones[index].usuariosLike.removeAt(publicaciones[index]
        .usuariosLike
        .indexWhere((like) => like.usuario.id == idUsuario));
  }
}
