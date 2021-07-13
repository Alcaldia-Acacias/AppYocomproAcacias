import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';

class Pedido {
  
final List<Producto> productos;
final int total;
final String observacion;

Pedido({this.total, this.observacion, this.productos});



}