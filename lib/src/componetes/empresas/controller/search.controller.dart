import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/empresas/models/reponseEmpresa.model.dart';
import 'package:comproacacias/src/componetes/home/models/update.model.dart';
import 'package:comproacacias/src/componetes/response/models/error.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SearchEmpresasController extends GetxController {

final EmpresaRepositorio repositorio;

SearchEmpresasController(this.repositorio);
List<Empresa> empresas;
TextEditingController searchController = TextEditingController();

@override
  void onInit() {
    this.empresas = [];
    super.onInit();
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