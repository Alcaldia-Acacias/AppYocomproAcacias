import 'package:comproacacias/src/componetes/empresas/controller/formulario.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

class FormEmpresaPage extends StatelessWidget {
   
  final bool update;
  final Empresa empresa;
  FormEmpresaPage({Key key, this.update, this.empresa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return GetBuilder<FormEmpresaController>(
                   init: FormEmpresaController(repositorio:EmpresaRepositorio()),
                   builder: (state)
                   => Scaffold(
                          appBar: AppBar(
                                  title: Text('Agregar Empresa'),
                                  elevation: 0,
                          ),
                          body  :   SingleChildScrollView(
                                    padding: EdgeInsets.all(40),
                                    child: GestureDetector(
                                           child:Form(
                                                 key: state.formKey,
                                                 child: Column(
                                                        children: [
                                                            InputForm(
                                                            placeholder       : "Nombre de la Empresa",
                                                            controller        : state.nombreController,
                                                            foco              : state.nombreFoco,
                                                            leftIcon          : Icons.business,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.descripcionFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Descripcion",
                                                            controller        : state.descripcionController,
                                                            foco              : state.descripcionFoco,
                                                            leftIcon          : Icons.text_fields,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.direccionFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Dirrecion",
                                                            controller        : state.direccionController,
                                                            foco              : state.direccionFoco,
                                                            leftIcon          : Icons.map,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.telefonoFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Telefono",
                                                            controller        : state.telefonoController,
                                                            foco              : state.telefonoFoco,
                                                            leftIcon          : Icons.phone,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.whatsappFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Whatsap",
                                                            controller        : state.whatsappController,
                                                            foco              : state.whatsappFoco,
                                                            leftIcon          : Icons.phone_android,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.emailFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Correo",
                                                            controller        : state.emailController,
                                                            foco              : state.emailFoco,
                                                            leftIcon          : Icons.email,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.webFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Sitio Web",
                                                            controller        : state.webController,
                                                            foco              : state.webFoco,
                                                            leftIcon          : Icons.web,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.latitudFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Latitud",
                                                            controller        : state.latitudController,
                                                            foco              : state.latitudFoco,
                                                            leftIcon          : Icons.gps_fixed,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.longitudFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Longitud",
                                                            controller        : state.longitudController,
                                                            foco              : state.longitudFoco,
                                                            leftIcon          : Icons.gps_fixed,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.nitFoco)
                                                            ),
                                                            InputForm(
                                                            placeholder       : "Nit",
                                                            controller        : state.nitController,
                                                            foco              : state.nitFoco,
                                                            leftIcon          : Icons.card_membership,
                                                            requerido         : true,
                                                            onEditingComplete : ()=>{}
                                                            )
                                                        ]
                                                 )
                                           ),
                                           onTap: ()=>FocusScope.of(context).unfocus(),
                                    ),  
                            ),
                          
                          floatingActionButton: FloatingActionButton.extended(
                                                label: Text('Agregar',style:TextStyle(color: Colors.white)),
                                                icon: Icon(Icons.check,color:Colors.white),
                                                backgroundColor: Get.theme.primaryColor,                            
                                                onPressed: (){},
                                                ),
                   
                   )
    );
  }
}