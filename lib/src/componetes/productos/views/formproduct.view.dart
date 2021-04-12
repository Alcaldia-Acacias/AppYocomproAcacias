import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:comproacacias/src/componetes/widgets/dialogImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormProducto extends StatelessWidget {

 final bool update;
 final int idEmpresa;
 final Producto producto;

 FormProducto({
    Key key,
    this.update = false,
    this.idEmpresa,
    this.producto}
 ) : super(key: key);


final String urlImagenes = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: Scaffold(
                  appBar: AppBar(
                          title: Text('${update ? 'Actualizar' : 'Agregar '} Producto'),
                          elevation: 0,
                  ),
                  body: GetBuilder<ProductosController>(
                        init: ProductosController(
                              repositorio: ProductosRepositorio(),
                              idEmpresa  : idEmpresa,
                              producto   : producto,
                              actualizar : update
                              ),

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
                                           placeholder       : 'Descripción',
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
                                           onEditingComplete : ()=>state.updateOrAddProducto(update)
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
  Widget _addImagenWidget(ProductosController state) {
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
              child: Text('Seleccionar imagen'),
              onPressed: ()=>DialogImagePicker.openDialog(
                             titulo       : 'Escoge la imagen',
                             onTapArchivo : ()=>state.getImage('archivo'),
                             onTapCamera  : ()=>state.getImage('camara')
              )
              ) 
             ],
      ),
    );
  }

Widget _button(ProductosController state) {
  return MaterialButton(
         padding: EdgeInsets.all(16),
         color: Get.theme.primaryColor,
         textColor: Colors.white,
         child: Text('${update ? 'Actualizar' : 'Agregar'}'),
         minWidth: double.maxFinite,
         onPressed: ()=>state.updateOrAddProducto(update)
         );
}

Widget _imageProducto(ProductosController state)  {
   
  switch (state.selectImage()) {
    case ImageSelect.NO_IMAGE:  return CircleAvatar(
                                       radius: 40,
                                       backgroundImage: AssetImage('assets/imagenes/no_product.png'),
                                 );
                                 break;
    case ImageSelect.PATH_IMAGE: return ClipRRect(
                                        borderRadius: BorderRadius.circular(300),
                                        child:  FadeInImage(
                                              height : 100,
                                              width  : 100,
                                              fit    : BoxFit.cover,
                                              placeholder: AssetImage('assets/imagenes/load_image.gif'), 
                                              image: FileImage(state.image),
                                       )
                                 );
                                 break;
    case ImageSelect.URL:  return ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child:  FadeInImage(
                                          height : 100,
                                          width  : 100,
                                          fit    : BoxFit.cover,
                                          placeholder: AssetImage('assets/imagenes/load_image.gif'), 
                                          image: NetworkImage('$urlImagenes/galeria/${producto.imagen}'),
                                  ),
                           );
                           break;
    default:break;
  }

    
    return Container();

  }
}

   

