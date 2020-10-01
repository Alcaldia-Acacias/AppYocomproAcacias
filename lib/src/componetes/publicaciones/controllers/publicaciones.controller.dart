import 'package:comproacacias/src/componetes/publicaciones/data/publicaciones.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/publicacion.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class PublicacionesController extends GetxController {
  final PublicacionesRepositorio repositorio;

  PublicacionesController({this.repositorio});

  List<Publicacion> publicaciones = [];
  List<Publicacion> publicacionesByempresa = [];
  ScrollController controller;
  int _pagina = 0;
  TextEditingController comentarioController = TextEditingController();
  bool loading = true;

  @override
  void onInit() async {
    super.onInit();
    controller = controller = ScrollController(initialScrollOffset: 0);
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent)
        this.getPublicaciones();
    });
    this.getPublicaciones();
  }

  void getLikesByPublicacion(int idPublicacion, [bool onlyEmpresa]) async {
    this.loading = true;
    if (onlyEmpresa) {
      final index = getIndexPublicacionByEmpresa(idPublicacion);
      this.publicacionesByempresa[index].usuariosLike =
          await this.repositorio.getUsuarioLike(idPublicacion);
    } else {
      final index = getIndexPublicacion(idPublicacion);
      this.publicaciones[index].usuariosLike =
          await this.repositorio.getUsuarioLike(idPublicacion);
    }
    this.loading = false;
    update(['likes']);
  }

  void getComentarios(int idPublicacion, [bool onlyEmpresa]) async {
    this.loading = true;
    if (onlyEmpresa) {
      final index = this.getIndexPublicacionByEmpresa(idPublicacion);
      this.publicacionesByempresa[index].comentarios =
          await this.repositorio.getComentariosByPublicacion(idPublicacion);
    } else {
      final index = this.getIndexPublicacion(idPublicacion);
      this.publicaciones[index].comentarios =
          await this.repositorio.getComentariosByPublicacion(idPublicacion);
    }
    this.loading = false;
    update(['comentarios']);
  }

  void getPublicaciones() async {
    _pagina++;
    publicaciones.addAll(await repositorio.getPublicaciones(_pagina));
    if (_pagina > 1) this._animationFinalController();
    update(['publicaciones']);
  }

  void getNewPublicaciones() async {
    publicaciones = await repositorio.getPublicaciones(1);
    update(['publicaciones']);
  }

  @override
  Future<void> onClose() {
    controller?.dispose();
    return super.onClose();
  }

  void _animationFinalController() {
    controller.animateTo(controller.position.pixels + 100,
        duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  int getIndexPublicacion(int id) =>
      this.publicaciones.indexWhere((publicacion) => publicacion.id == id);

  int getIndexPublicacionByEmpresa(int id) => this
      .publicacionesByempresa
      .indexWhere((publicacion) => publicacion.id == id);

  void getPublicacionesByempresa(int id) async {
    this.loading = true;
    this.publicacionesByempresa =
        await repositorio.getPublicacionesByEmpresa(id);
    this.loading = false;
    update(['empresa']);
  }
}
