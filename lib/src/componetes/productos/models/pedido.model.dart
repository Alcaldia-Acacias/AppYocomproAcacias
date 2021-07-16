import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';

class Pedido {
  
final List<Producto> productos;
final String observacion;
final int idEmpresa;

Pedido({this.idEmpresa,this.observacion, this.productos});

factory Pedido.toJson(Map<String,dynamic> json) =>
        Pedido(
        productos   : json['productos'].map<Producto>((producto)=>Producto.toJson(producto)),
        observacion : json['observacion'],
        idEmpresa   : json['id_empresa']
        ); 

int calcularTotal(){
  int total = 0;
  this.productos.forEach((producto) { 
    total = total + producto.precio;
  });
  return total;
}


}