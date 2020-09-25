import 'package:comproacacias/src/componetes/categorias/data/categorias.repositorio.dart';
import 'package:comproacacias/src/componetes/publicaciones/models/empresa.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriasController extends GetxController {
  
  final CategoriaRepositorio repositorio;
  final String categoria;
  CategoriasController({this.repositorio,this.categoria});

  List<Empresa> empresas = [];
  ScrollController controllerListEmpresas;
  int _pagina = 0;


  @override
  void onReady() {
    super.onReady();
    this.controllerListEmpresas = ScrollController(initialScrollOffset: 0);
    this.controllerListEmpresas.addListener(() {
      if (controllerListEmpresas.position.pixels ==
          controllerListEmpresas.position.maxScrollExtent)
        this.getEmpresasByCategoria();
    });
     this.getEmpresasByCategoria();
  }

  void _animationFinalController() {
    controllerListEmpresas.animateTo(
        controllerListEmpresas.position.pixels + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void getEmpresasByCategoria() async {
    _pagina++;
    final empresasList =   await repositorio.getEmpresasByCategoria(this.categoria, _pagina);
    if(empresasList.length > 0) {
        empresas.addAll(empresasList);
        if (_pagina > 1) this._animationFinalController();
        update();
    }
  }
}
