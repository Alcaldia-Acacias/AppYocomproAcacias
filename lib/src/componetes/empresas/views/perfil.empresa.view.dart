import 'package:cached_network_image/cached_network_image.dart';
import 'package:comproacacias/src/componetes/empresas/controller/empresas.controller.dart';
import 'package:comproacacias/src/componetes/empresas/data/empresa.repositorio.dart';
import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/models/loginEnum.model.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/calificacion.widget.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/calificar.widget.dart';
import 'package:comproacacias/src/componetes/empresas/widgets/datosCard.widget.dart';
import 'package:comproacacias/src/componetes/home/controllers/home.controller.dart';
import 'package:comproacacias/src/componetes/productos/controllers/productos.controller.dart';
import 'package:comproacacias/src/componetes/productos/views/producto.view.dart';
import 'package:comproacacias/src/componetes/productos/widgets/productoCardSmall.widget.dart';
import 'package:comproacacias/src/componetes/publicaciones/controllers/publicaciones.controller.dart';
import 'package:comproacacias/src/componetes/publicaciones/widgets/publicacion.widget.dart';
import 'package:comproacacias/src/componetes/widgets/InputForm.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';



class PerfilEmpresaPage extends StatelessWidget {

  final Empresa empresa;
  final bool propia;
  PerfilEmpresaPage({Key key,this.empresa,this.propia = false}) : super(key: key);
  final String urlImagenLogo = Get.find<HomeController>().urlImagenes;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmpresasController>(
           id: 'empresa',
           init: EmpresasController(repositorio: EmpresaRepositorio(),empresa: this.empresa),
           builder: (state){
             
             return AnnotatedRegion<SystemUiOverlayStyle>(
                           value: SystemUiOverlayStyle(
                                  statusBarIconBrightness: Brightness.light,
                                  statusBarBrightness: Brightness.dark,
                            ),
                            child: Scaffold(
                                   backgroundColor: Colors.grey[300],
                                   body : Column(
                                          children: <Widget>[
                                                    _header(state),
                                                    SizedBox(height:30),
                                                    _titulo(state.titulo,state.pagina),
                                                    Expanded(
                                                    child: PageView(
                                                           controller: state.pageViewController,
                                                           children: <Widget>[
                                                              _datos(),
                                                              _publicaciones(),
                                                              _calificaciones(),
                                                              _productos(state)
                                                           ],
                                                           onPageChanged: (page)=>state.getTitulo(page)
                                                          ,
                                                    ),
                                                    )
                                          ],
                                   ), 
                            ),
            );
           }
    ); 
  

  }

 Widget _header(EmpresasController state) {
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
                                if(!propia && state.homeController.anonimo == EnumLogin.usuario)
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
     padding: const EdgeInsets.symmetric(horizontal: 15),
     child: Container(
       height: 50,
       decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10)
       ),
       child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               _tabItem(pagina,'Datos',0),
               _tabItem(pagina,'Publicaciones',1),
               _tabItem(pagina,'Calificaciones',2),
               _tabItem(pagina,'Productos',3)
              
              ],
       )
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

Widget  _productos(EmpresasController state) {
  if(state.loading)
  return Center(
         child: CircularProgressIndicator(),
  );
  if(state.productos.length == 0)
  return Center(
         child: Text('No hay Productos'),
  );
  return GridView.builder(
         padding      : EdgeInsets.symmetric(horizontal: 15,vertical: 30),
         itemCount    : state.productos.length,
         gridDelegate : SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10),
         itemBuilder  : (_, index){
           return  GestureDetector(
            child : ProductoCardSmall(producto: state.productos[index]),
            onTap : () {
              Get.to(ProductoPage());
              state.getProductosByEmpresa(state.productos[index].empresa.id);
              Get.find<ProductosController>().selectProducto(state.productos[index]);
            }
           );
         },
         
 );
}

  _tabItem(int pagina, String titulo, int index) {
    return  Container(
            height: 50,
            decoration: pagina == index
                        ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                                  color: Get.theme.primaryColor,
                                  width: 3
                          )
                        )
                        )
                        : null,
            child: GestureDetector(
                   child: Center(
                          child: Text(titulo,textAlign: TextAlign.center)
                   ),
                   onTap: ()=> Get.find<EmpresasController>().changePage(index),
            )
            );
  }

}

