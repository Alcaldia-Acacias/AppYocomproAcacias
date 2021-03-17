import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SearchEmpresasController extends GetxController {

final EmpresaRepositorio repositorio;
final String initSearch;
SearchEmpresasController(this.repositorio, this.initSearch);
List<Empresa> empresas;
TextEditingController searchController = TextEditingController();



@override
  void onInit() {
    searchController.text = this.initSearch;
    searchController.selection = TextSelection(baseOffset: 0,extentOffset: this.initSearch.length);
    this.searchEmpresa();
    this.empresas = [];
    super.onInit();
  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }


void searchEmpresa() async {
   if(searchController.text.length > 3){
     final response = await repositorio.searchEmpresa(searchController.text);
     if(response is ResponseEmpresa){
       this.empresas = response.empresas;
       update(['search']);
     }
     if(response is ErrorResponse)this.errorResponse(response.getError);
   }
   else {
     this.empresas = [];
     update(['search']);
   }
}
  void errorResponse(String error) {
    print(error);
  }


}