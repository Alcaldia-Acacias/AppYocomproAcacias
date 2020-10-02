import 'package:comproacacias/src/componetes/categorias/controllers/categorias.controllers.dart';
import 'package:comproacacias/src/componetes/categorias/views/listEmpresas.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListCategoriasPage extends StatelessWidget {
  const ListCategoriasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriasController>(
           builder: (state){
            return Scaffold(
                   body: CustomScrollView(
                         slivers: [
                            _appBar(),
                            _listCategorias(state.categorias)
                         ],
                   ),
            );
           }
           );
  }

 Widget _appBar() {
   return SliverAppBar(
          title: Text('Categorias'),
          floating: true,
   ); 
 }

  _listCategorias(List<String> categorias) {
      return  SliverPadding(
           padding: EdgeInsets.all(4),
           sliver : SliverList(
                    delegate: SliverChildBuilderDelegate(
                              (context,i){
                                 if(i == categorias.length ){
                                      return Center(
                                             child: Container(
                                                    padding : EdgeInsets.all(10),
                                                    child   : CircularProgressIndicator(),
                                                    )
                                        );
                                 }
                                 return ListTile(
                                        title: Text(categorias[i]),
                                        leading: CircleAvatar(
                                                 child: Text('${i +1}',style:TextStyle(color: Colors.white)),
                                                 backgroundColor: Get.theme.primaryColor,

                                        ),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: (){
                                           Get.find<CategoriasController>().getEmpresasByCategoriaInitial(categorias[i]);
                                           Get.to(ListEmpresasByCategoria());
                                        },
                                 );
                              },
                              childCount: categorias.length + 1, 
                    )
           ),
   );
  }
}