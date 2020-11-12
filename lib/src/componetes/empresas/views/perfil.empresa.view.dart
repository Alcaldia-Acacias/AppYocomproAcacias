import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/productos/views/formproduct.view.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/calificacion.widget.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/calificar.widget.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/datosCard.widget.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/widgets/imagenes.widget.dart';
import 'package:comproacacias/src/componetes/publicaciones/widgets/publicacion.widget.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';



class PerfilEmpresaPage extends StatelessWidget {

  final Empresa empresa;
  final bool propia;
  PerfilEmpresaPage({Key key,this.empresa,this.propia = false}) : super(key: key);
  final String urlImagenLogo = Get.find<HomeController>().urlImegenes;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmpresasController>(
           id: 'empresa',
           init: EmpresasController(repositorio: EmpresaRepositorio()),
           builder: (state){
             state.empresa = empresa;
             return AnnotatedRegion<SystemUiOverlayStyle>(
                           value: SystemUiOverlayStyle(
                                  statusBarIconBrightness: Brightness.light,
                                  statusBarBrightness: Brightness.dark,
                            ),
                            child: Scaffold(
                                   backgroundColor: Colors.grey[300],
                                   body : Column(
                                          children: <Widget>[
                                                    _header(),
                                                    SizedBox(height:30),
                                                    _titulo(state.titulo,state.pagina),
                                                    Expanded(
                                                    child: PageView(
                                                           controller: state.pageViewController,
                                                           children: <Widget>[
                                                              _datos(),
                                                              _publicaciones(),
                                                              _calificaciones(),
                                                              _productos()
                                                           ],
                                                           onPageChanged: (page)=>state.getTitulo(page)
                                                          ,
                                                    ),
                                                    )
                                          ],
                                   ), 
                                   floatingActionButton: propia && state.pagina == 3
                                                         ? FloatingActionButton.extended(
                                                           backgroundColor : Get.theme.primaryColor,
                                                           label           : Text('Agregar',style: TextStyle(color:Colors.white)),
                                                           icon            : Icon(Icons.add,color: Colors.white),
                                                           onPressed       : ()=>Get.to(FormProducto(idEmpresa:empresa.id)) 
                                                           )
                                                          : null
                            ),
            );
           }
    ); 
  

  }

 Widget _header() {
     return  SizedBox(
             height : 260,
             width  : Get.width,
             child  : Stack(
                      overflow : Overflow.visible,
                      children : <Widget>[
                                 Positioned.fill(
                                 child :  empresa.urlLogo == ''
                                          ?
                                          Container()
                                          :
                                          CachedNetworkImage(
                                          imageUrl    : '$urlImagenLogo/logo/${empresa.urlLogo}',
                                          fit         : BoxFit.cover,
                                 ),
                                 ),
                                 Positioned.fill(
                                 child: Opacity(
                                        opacity: 0.6,
                                        child: Container(color: Colors.black),
                                 )
                                 ),
                                Positioned(
                                top   : 40,
                                left  : 10,
                                child : IconButton(
                                        icon     : BackButtonIcon(), 
                                        color    : Colors.white,
                                        onPressed: () => Get.back()
                                ),
                                ),
                                Align(
                                alignment: Alignment(0.0,-0.2),
                                child: Text(empresa.nombre,
                                            style : TextStyle(
                                                    color      : Colors.white,
                                                    fontSize   : 20,
                                                    fontWeight : FontWeight.bold
                                                    )
                                           ),
                                ),
                                /* Align(
                                alignment: Alignment(0.0,0.05),
                                child: CalificacionWidget()
                                ),*/
                                if(!propia)
                                Align(
                                alignment: Alignment(0.92,1),
                                child: RawChip(
                                       backgroundColor: Colors.transparent,
                                       visualDensity: VisualDensity.compact,
                                       label: Text('Calificar'),
                                       labelStyle: TextStyle(
                                                   color: Colors.blue
                                       ),
                                       onPressed: ()=> _calificar(),
                                       )
                                ),
                                Align(
                                alignment : Alignment(0.0, 1.5),
                                child     : CircleAvatar(
                                            radius          : 75,
                                            backgroundImage : empresa.urlLogo == ''
                                                              ?
                                                              AssetImage('assets/imagenes/logo_no_img.png')
                                                              :
                                                              CachedNetworkImageProvider('$urlImagenLogo/logo/${empresa.urlLogo}'),
                                )
                                )
                      ]
             ),
     );
  }

 Widget _datos() {
    return  SingleChildScrollView(
           child: Column(
             children: <Widget>[
                      DatosCard(
                      titulo  : empresa.descripcion,
                      tipo    : "Descripción",
                      icon    : Icons.info_outline,
                      ),
                      DatosCard(
                      titulo  : empresa.direccion,
                      vinculo : "Como Llegar",
                      tipo    : "Dirección",
                      icon    : Icons.map,
                      onPressed: (titulo) async {
                         Get.find<EmpresasController>()
                            .gotoMap(empresa.latitud, empresa.longitud);
                      },
                      ),
                      DatosCard(
                      titulo  : empresa.telefono,
                      vinculo : "Llamar",
                      tipo    : "Telefono",
                      icon    : Icons.phone_android,
                      onPressed: (titulo){
                        Get.find<EmpresasController>()
                           .gotoCall(empresa.telefono);
                      },
                      ),
                      DatosCard(
                      titulo  : empresa.whatsapp,
                      vinculo : "Enviar Mensaje",
                      tipo    : "Whatsapp",
                      icon    : Icons.message,
                      onPressed: (titulo){
                        Get.find<EmpresasController>()
                            .goToWhatsapp(titulo);
                      },
                      ),
                      DatosCard(
                      titulo  : empresa.email,
                      vinculo : "Enviar",
                      tipo    : "Correo",
                      icon    : Icons.mail,
                      onPressed: (titulo){
                         Get.find<EmpresasController>()
                            .gotoMail(titulo);
                      },
                      ),
                      DatosCard(
                      titulo  : empresa.web,
                      tipo    : "Web",
                      icon    : Icons.web_asset,
                      onPressed: (titulo){
                          Get.find<EmpresasController>()
                            .gotoWeb(titulo);
                      },
                      ),
             ],
           ),
    );
  }

 Widget _titulo(String titulo, int pagina) {
   return Padding(
     padding: const EdgeInsets.all(9.0),
     child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              pagina == 0
              ?
              Container()
              :
              GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: ()=>Get.find<EmpresasController>().changePage('atras'),
              ),
              Text(titulo,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              GestureDetector(
              child: Icon(Icons.arrow_forward_ios),
              onTap: ()=>Get.find<EmpresasController>().changePage('adelante'),
              ),
            ],
     ),
   );
 }

Widget _publicaciones() {
  return GetBuilder<PublicacionesController>(
         id: 'empresa',
         builder: (state){
         if(state.loading)
            return Center(child: CircularProgressIndicator()); 
          if(state.publicacionesByempresa.length == 0)
            return Center(child: Text('No hay publicaciones'));
          return ListView.builder(
                 padding: EdgeInsets.all(10),
                 itemCount: state.publicacionesByempresa.length,
                 itemBuilder: (contex,i){
                  return PublicacionCard(
                         publicacion: state.publicacionesByempresa[i],
                         index: i,
                         onlyEmpresa: true,
                  );

                 }
                 );

         },
  );
}

Widget _productos() {
  return GetBuilder<EmpresasController>(
         builder: (state){
           if(state.loading)
              return Center(child: CircularProgressIndicator()); 
           if(state.productos.length == 0)
              return Center(child: Text('No hay Productos'));
           return  ListView.builder(
                   itemExtent   : 120,
                   padding      : EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 70),
                   itemCount    : state.productos.length,
                   itemBuilder  : (_, i) {
                     if(propia)
                       return Slidable(
                              secondaryActions: <Widget>[
                                                IconSlideAction(
                                                caption : 'Editar',
                                                color   : Colors.green,
                                                icon    : Icons.edit,
                                                onTap:  () => Get.to(FormProducto(update: true,producto:state.productos[i],idEmpresa:empresa.id))
                                                ),
                                                IconSlideAction(
                                                caption : 'Eliminar',
                                                color   : Colors.red,
                                                icon    : Icons.delete,
                                                onTap:  ()=>_dialogDeleteProducto(state.productos[i],i)
                                                ),
                                                ],
                               actionPane: SlidableDrawerActionPane(),
                               child: _cardProducto(state.productos, i)
                       );
                     return _cardProducto(state.productos, i);
                   }
           );


         }
  );


}

void _calificar() {
   Get.defaultDialog(
   title: "Califica este Negocio",
   content:  Container(
             color: Colors.white,
             height: Get.height * 0.25,
             child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CalificarWidget(),
                      InputForm(
                      controller  : Get.find<EmpresasController>().calificarController,
                      placeholder : "Escribe un Comentario",
                      autofocus   : true, 
                      textcenter  : true, 
                      )
                    ],
             )
             ),
   confirm: FlatButton(
            onPressed: ()=>Get.back(),
            child: Text('Cancelar'),
            ),
   cancel: FlatButton(
            color: Get.theme.primaryColor,
            onPressed: ()=>Get.find<EmpresasController>().addCalificacionEmpresa(),
            child: Text('Calificar',style:TextStyle(color: Colors.white)),
            ),
   );
  }

Widget  _imagen(String imagen,int i) {
  return  GestureDetector(
          child: ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: Hero(
                        tag: i,
                        child: CachedNetworkImage(
                          imageUrl    : '$urlImagenLogo/galeria/$imagen',
                          errorWidget : (_,url,error) => Icon(Icons.error),
                          width:  80,
                          height: 80,
                          fit: BoxFit.cover
                          ),
                 ),
        ),
        onTap: (){
          Get.to(ImagenesWidgetPage(imagenes: [imagen],id:i),
           transition: Transition.noTransition
          );
        },
        );
}

Widget _nombre(String nombre) {
  return  Text('$nombre',
          overflow  : TextOverflow.ellipsis,
          maxLines  : 2,
          textAlign : TextAlign.end,
           style: TextStyle(
                  fontWeight : FontWeight.bold,
                  fontSize   : 16
          ),
          );
}

Widget _precio(int precio) {
  return  ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
                 padding   : EdgeInsets.all(10),
                 alignment : Alignment.center,
                 width     : 100,
                 color     : Get.theme.primaryColor,
                 child     : Text('\u0024 $precio',
                             style      : TextStyle(
                             color      : Colors.white,
                             fontWeight : FontWeight.bold
                         ),
                  )
                  )
           );
}

Widget _calificaciones() {
  return GetBuilder<EmpresasController>(
          builder: (state){
           final calificaciones = state.calificaciones;
           if(state.loading)
              return Center(child: CircularProgressIndicator()); 
           if(calificaciones.length == 0)
              return Center(child: Text('No hay Calificaciones'));
          return ListView.builder(
                 padding  : EdgeInsets.all(10),
                 itemCount: calificaciones.length,
                 itemBuilder: (_,i){
                   return Card(
                          elevation: 0,
                          color    : Colors.white,
                          shape    : RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                          ),
                          child    : Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                            child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         ListTile(
                                         leading: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: calificaciones[i].usuario.imagen == ''
                                                                   ? AssetImage('assets/imagenes/logo_no_img.png')
                                                                   : CachedNetworkImageProvider('$urlImagenLogo/usuarios/${calificaciones[i].usuario.imagen}'),
                                         ),
                                         title    : Text(calificaciones[i].usuario.nombre),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(left: 25),
                                           child: CalificacionWidget(
                                           extrellas:calificaciones[i].extrellas,
                                           centrado: false,
                                           size: 20
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 30),
                                           child: Text(calificaciones[i].comentario),
                                         )
                                       ],
                             ),
                          )
                   );
                 }
                 );
          }
          );

}

Widget _cardProducto(List<Producto> productos,int i){
  return Card(
         child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       mainAxisSize: MainAxisSize.max,
                       children: <Widget>[
                                productos[i].imagen.isEmpty
                                         ?
                                         Image.asset('assets/imagenes/no_product.png')
                                         :
                                         _imagen(productos[i].imagen,i),
                               Expanded(
                               child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.end,
                               children: <Widget>[
                                   _nombre(productos[i].nombre),
                                   _precio(productos[i].precio)
                                 ],
                                 ),
                    
                               )
                       ],
                ),
              )
              );
}

void _dialogDeleteProducto(Producto producto, int index) {
   Get.defaultDialog(
   title: 'Desea borrar el producto',
   content: Container(),
   actions: [
       RaisedButton(
       textColor: Colors.white,
       color: Get.theme.primaryColor,
       child: Text('Eliminar'),
       onPressed: ()=>Get.find<EmpresasController>().deleteProducto(producto.id,index)
      ),
       RaisedButton(
       color: Colors.transparent,
       child: Text('Cancelar'),
       onPressed: ()=>Get.back()
      )
   ]
   );

  }

}

