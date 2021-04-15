import 'package:comproacacias/src/componetes/usuario/controllers/help.controller.dart';
import 'package:comproacacias/src/componetes/usuario/data/usuario.repository.dart';
import 'package:comproacacias/src/componetes/usuario/widgets/radioOption.widget.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatelessWidget {
  final int idUsuario;
  HelpPage({Key key,this.idUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: Scaffold(
                  appBar: AppBar(
                          title: Text('Ayuda'),
                          elevation: 0,
                  ),
                  body: SingleChildScrollView(
                        padding: EdgeInsets.all(30),
                        child: GetBuilder<HelpController>(
                               init: HelpController(repocitorio: UsuarioRepocitorio(),idUsuario: idUsuario),
                               builder: (state){
                                 return Form(
                                        key: state.formKey,
                                        child: Column(
                                               children: [
                                                _titulo('¿Cómo podemos ayudarte?'),
                                                SizedBox(height: 20),
                                                _texto(state),
                                                _opciones(state),
                                                SizedBox(height: 20),
                                                InputForm(
                                                placeholder : 'Mensaje',
                                                controller  : state.mensaje,
                                                requerido   : true,
                                                textarea    : true,  
                                                ),
                                                SizedBox(height: 20),
                                                _titulo('Datos de contactos'),
                                                SizedBox(height: 10),
                                                _telefono(state),
                                                _correo(state)
                                               ],
                                        )
                                        );
                               }
                         )
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                                        label           : Text('Enviar',style:TextStyle(color: Colors.white)),
                                        backgroundColor : Get.theme.primaryColor,
                                        icon            : Icon(Icons.send,color: Colors.white),
                                        onPressed: ()=>Get.find<HelpController>().sendReporte(), 
                                        ),
           ),
           onTap: ()=>FocusScope.of(context).unfocus(),
    );
  }

Widget _texto(HelpController state) {
  return Text('Cuentanos si se te ha presentado algún incoveniente al utilizar aplicación');
}

 Widget _opciones(HelpController state) {
     return Column(
            children: [
             RadioOptionHelp(
             titulo     : 'Funcionamiento',
             value      : 0,
             valueradio : state.valueRadio,
             onChange   : (value)=>state.changeRadio(value) 
             ),
             RadioOptionHelp(
             titulo     : 'Contenido inadecuado',
             value      : 1,
             valueradio : state.valueRadio,
             onChange   : (value)=>state.changeRadio(value) 
             ),
             RadioOptionHelp(
             titulo     : 'Suplantación o empresa repetidas',
             value      : 2,
             valueradio : state.valueRadio,
             onChange   : (value)=>state.changeRadio(value) 
             ),
             RadioOptionHelp(
             titulo     : 'otro (describelo en el mensaje)',
             value      : 3,
             valueradio : state.valueRadio,
             onChange   : (value)=>state.changeRadio(value) 
             )
            ],
     );

 }

  _titulo(String titulo) {
    return Text(titulo,
                 textAlign : TextAlign.center,
                 style     : TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize  : 17
                 ),
                 );
  }

  _telefono(HelpController state) {
    return ListTile(
    leading        : Icon(Icons.phone),
    title          : Text('3214904883'), 
    onTap          : ()=>state.gotoCall('3214904883'), 
    );
  }
  _correo(HelpController state) {
    return ListTile(
    leading        : Icon(Icons.mail),
    title          : Text('empresariostic@acacias.gov.co'), 
    onTap          : ()=>state.gotoMail('empresariostic@acacias.gov.co'), 
    );
  }
}