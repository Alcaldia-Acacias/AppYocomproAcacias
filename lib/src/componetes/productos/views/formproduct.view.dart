import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/formProducto.controller.dart';
import 'package:comproacacias/src/componetes/productos/data/productos.repositorio.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:comproacacias/src/componetes/widgets/dialogImage.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FormProducto extends StatelessWidget {

 final bool update;
 final Producto producto;

 FormProducto({
    Key key,
    this.update = false,
    this.producto}
 ) : super(key: key);


final String urlImagenes = Get.find<HomeController>().urlImagenes;
 final Uuid uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           child: Scaffold(
                  appBar: AppBar(
                          title: Text('${update ? 'Actualizar' : 'Agregar '} Producto'),
                          elevation: 0,
                  ),
                  body: GetBuilder<FormProductoController>(
                        id: 'formulario_producto',
                        init: FormProductoController(updateProducto: update,repositorio: ProductosRepositorio(),productoUpdate: producto),
                        builder: (state){
                        return SingleChildScrollView(
                            padding: EdgeInsets.all(25),
                            child: Form(
                                   key:  state.formKey,
                                   child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                           Text('Agrega hasta 5 imagenes'),
                                           SizedBox(height: 30),
                                           _imagenes(state),
                                           SizedBox(height: 15),
                                           _empresas(state),
                                           SizedBox(height: 15),
                                           _categorias(state),
                                           SizedBox(height: 15),
                                           InputForm(
                                           placeholder: 'Nombre',
                                           controller        : state.nombreController,
                                           foco              : state.nombreFoco,
                                           leftIcon          : Icons.text_snippet,
                                           requerido         : true,
                                           onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.descripcionFoco)
                                           ),
                                           InputForm(
                                           placeholder       : 'Descripción',
                                           controller        : state.descripcionController,
                                           foco              : state.descripcionFoco,
                                           leftIcon          : Icons.description,
                                           textarea          : true,
                                           requerido         : true,
                                           onEditingComplete : ()=>FocusScope.of(context).requestFocus(state.precioFoco)
                                           ),
                                           InputForm(
                                           placeholder       : 'Precio',
                                           controller        : state.precioController,
                                           foco              : state.precioFoco,
                                           leftIcon          : Icons.monetization_on_outlined,
                                           requerido         : true,
                                           ),
                                           _oferta(state),
                                           InputForm(
                                           placeholder       : 'Detalle de oferta',
                                           enabled           : state.oferta,
                                           controller        : state.descripcionOfertaController,
                                           foco              : state.descripcionOfertaFoco,
                                           leftIcon          : Icons.star_rate_outlined,
                                           lastInput         : true,
                                           onEditingComplete : (){}//()=>state.updateOrAddProducto(update)
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

Widget _button(FormProductoController state) {
  return MaterialButton(
         padding: EdgeInsets.all(16),
         color: Get.theme.primaryColor,
         textColor: Colors.white,
         child: Text('${update ? 'Actualizar' : 'Agregar'}'),
         minWidth: double.maxFinite,
         onPressed: (){
           if(update)
            state.updateProductos(producto.id);
           else state.addProducto();
         }
         );
}

  Widget _imagenes(FormProductoController state) {
  return Wrap(
         spacing: 2,
         runSpacing: 2,
         children: [
             if(state.imagenes.length < 5 && state.imagenesUpdate.length < 5)
               GestureDetector(
               child: Container(
                      height : 100,
                      width  : Get.width *0.25,
                      color  : Colors.grey[350],
                      child  : Center(child:Icon(Icons.add,color: Colors.white)),
               ),
               onTap: ()=>DialogImagePicker.openDialog(
                          titulo       : 'Selecione una Imagen',
                          onTapArchivo : ()=>state.getImage('archivo'),
                          onTapCamera  : ()=>state.getImage('camara'),
                          complete     : (){
                                          if(state.status == ProductoState.notImage)
                                          Get.snackbar('Error', 'No seleciono una imagen');  
                          }
               ),
               ),
              if(!update)
              ...state.imagenes.asMap()
                               .entries
                               .map((imagen) => GestureDetector(
                                                child: FadeInImage(
                                                       height : 100,
                                                       width  : Get.width *0.25,
                                                       fit    : BoxFit.cover,
                                                       placeholder: AssetImage('assets/imagenes/load_image.gif'), 
                                                       image: FileImage(imagen.value.file),
                                                ),
                                                onTap: ()=>DialogImagePicker.openDialog(
                                                           titulo       : 'Cambia la Imagen',
                                                           onTapArchivo : ()=>state.getImage('archivo',true,imagen.key),
                                                           onTapCamera  : ()=>state.getImage('camara',true,imagen.key),
                                                           complete     : (){
                                                                          if(state.status == ProductoState.notImage)
                                                                          Get.snackbar('Error', 'No seleciono una imagen');  
                                                           }
                                                ),
                               )
               
              ),
              if(update)
              ...state.imagenesUpdate.asMap()
                                     .entries
                                     .map((imagen) => GestureDetector(
                                                      child: FadeInImage(
                                                             height      : 100,
                                                             width       : Get.width *0.25,
                                                             fit         : BoxFit.cover,
                                                             placeholder : AssetImage('assets/imagenes/load_image.gif'), 
                                                             image       : imagen.value.isaFile
                                                                           ? FileImage(imagen.value.file)
                                                                           : CachedNetworkImageProvider('$urlImagenes/galeria/${imagen.value.nombre}')
                                                      ),
                                                      onTap: ()=>DialogImagePicker.openDialog(
                                                                 titulo       : 'Cambia la Imagen',
                                                                 onTapArchivo : ()=>state.getImage('archivo',true,imagen.key),
                                                                 onTapCamera  : ()=>state.getImage('camara',true,imagen.key),
                                                                 complete     : (){
                                                                                if(state.status == ProductoState.notImage)
                                                                                Get.snackbar('Error', 'No seleciono una imagen');  
                                                                 }
                                                      ),
                                      )
                                     
                                     )
         ]
  );
}

_oferta(FormProductoController state) {
    return Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
             Text('¿ es una Oferta ?'),
           Checkbox(
           value: state.oferta, 
           onChanged: (value) => state.selectOferta(value)
           )
         ],
       );
}
 _empresas(FormProductoController state) {
    return GestureDetector(
           child : Container(
                   height : 50,
                   color  : Colors.grey.shade200,
                   child  : state.empresaSelecionada.isNullOrBlank ?
                            Center(child: Text('Toca Para Escoger una empresa'))
                            : ListTile(
                              title   : Text(state.empresaSelecionada.nombre),
                              leading : CircleAvatar(
                                        backgroundImage: NetworkImage('$urlImagenes/logo/${state.empresaSelecionada.urlLogo}'),
                              ),
                            )
           ),
           onTap : ()=> _dialogoEmpresas(state),
    );
    }
    
_dialogoEmpresas(FormProductoController state) {
       Get.bottomSheet(
       Container(
       color  : Colors.white,  
       height : Get.height * 0.5,
       child  : Column(
                children: [
                  Container(
                  height : 50,
                  child  : Center(child : Text('Escoge una Empresa')),  
                  ),
                  Expanded(
                  child: ListView.builder(
                         padding     : EdgeInsets.all(8),
                         itemCount   : state.empresas.length,
                         itemBuilder : (_,i){
                           return ListTile(
                                  leading: CircleAvatar(
                                           backgroundImage: CachedNetworkImageProvider('$urlImagenes/logo/${state.empresas[i].urlLogo}'),
                                  ),
                                  title  : Text('${state.empresas[i].nombre}'),
                                  onTap  : (){
                                      state.selectEmpresa(state.empresas[i]);
                                      Get.back();
                                  },
                           );
                }
       ),
                  )
                ],
       )   
       ) 
    );
}
_dialogoCategorias(FormProductoController state) {
       Get.bottomSheet(
       Container(
       color  : Colors.white,  
       height : Get.height * 0.5,
       child  : Column(
                children: [
                  Container(
                  height : 50,
                  child  : Center(child : Text('Escoge una Categoria')),  
                  ),
                  Expanded(
                  child: ListView.builder(
                         padding     : EdgeInsets.all(8),
                         itemCount   : state.categorias.length,
                         itemBuilder : (_,i){
                           return ListTile(
                                  leading: CircleAvatar(
                                           backgroundColor: Get.theme.primaryColor,
                                           child : Text('${i+1}'),
                                  ),
                                  title  : Text('${state.categorias[i].nombre}'),
                                  onTap  : (){
                                      state.selectCategoria(state.categorias[i]);
                                      Get.back();
                                  },
                           );
                }
       ),
                  )
                ],
       )   
       ) 
    );
}

_categorias(FormProductoController state) {
    return GestureDetector(
           child : Container(
                   height : 50,
                   color  : Colors.grey.shade200,
                   child  : state.categoriaSelecionada.isNullOrBlank ?
                            Center(child: Text('Toca Para Escoger una Categoria'))
                            : ListTile(
                              title   : Text(state.categoriaSelecionada.nombre),
                              leading : CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Get.theme.primaryColor,
                                        child: Icon(Icons.check),
                              ),
                            )
           ),
           onTap : () => _dialogoCategorias(state)
    );
  } 
}

   

