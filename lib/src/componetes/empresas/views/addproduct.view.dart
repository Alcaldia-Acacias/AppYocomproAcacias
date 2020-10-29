import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:comproacacias/src/componetes/widgets/dialogImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProducto extends StatelessWidget {
  const AddProducto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: Scaffold(
                  appBar: AppBar(
                          title: Text('Agregar un producto'),
                          elevation: 0,
                  ),
                  body: GetBuilder<EmpresasController>(
                        builder: (state){
                        return SingleChildScrollView(
                            padding: EdgeInsets.all(40),
                            child: Form(
                                   key:  state.formKey,
                                   child: Column(
                                          children: [
                                           _addImagenWidget(state),
                                           InputForm(
                                           placeholder: 'Nombre',
                                           controller        : state.nombreProductoController,
                                           foco              : state.nombreProductoFoco,
                                           leftIcon          : Icons.text_snippet,
                                           requerido         : true,
                                           onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.descripcionProductoFoco)
                                           ),
                                           InputForm(
                                           placeholder       : 'Descripcion',
                                           controller        : state.descripcionProductoController,
                                           foco              : state.descripcionProductoFoco,
                                           leftIcon          : Icons.description,
                                           textarea          : true,
                                           requerido         : true,
                                           onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.precioProductoFoco)
                                           ),
                                           InputForm(
                                           placeholder       : 'Precio',
                                           controller        : state.precioProductoController,
                                           foco              : state.precioProductoFoco,
                                           leftIcon          : Icons.monetization_on_outlined,
                                           requerido         : true,
                                           lastInput         : true,
                                           onEditingComplete : ()=>state.addProducto()
                                           ),
                                           _button(state)
                                          ],
                                   )
                            ),
                     );
                   }
                   ),
      ),
      onTap : ()=>FocusScope.of(context).unfocus(),
    );
  }
  Widget _addImagenWidget(EmpresasController state) {
    return Container(
           margin: EdgeInsets.only(bottom: 20),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
              _imageProducto(state),
              RaisedButton(
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20)
              ),
              child: Text('Selecionar imagen'),
              onPressed: ()=>DialogImagePicker.openDialog(
                             titulo       : 'Escoje la imagen',
                             onTapArchivo : ()=>state.getImage('archivo'),
                             onTapCamera  : ()=>state.getImage('camara')
              )
              ) 
             ],
      ),
    );
  }

Widget _button(EmpresasController state) {
  return MaterialButton(
         padding: EdgeInsets.all(16),
         color: Get.theme.primaryColor,
         textColor: Colors.white,
         child: Text('Agregar'),
         minWidth: double.maxFinite,
         onPressed: ()=>state.addProducto()
         );
}

Widget _imageProducto(EmpresasController state)  {
    if(state.image?.path == null ||  !state.image.existsSync())
       return CircleAvatar(
       radius: 40,
       backgroundImage: AssetImage('assets/imagenes/no_product.png'),
       );
    if(state.image?.path != null)
       return CircleAvatar(
       radius: 40,
       backgroundImage: AssetImage(state.image.path),
       );
    return Container();

  }
}

  