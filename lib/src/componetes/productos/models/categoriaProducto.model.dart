import 'package:comproacacias/src/componetes/categorias/models/categoria.model.dart';

class CategoriaProducto {
  final int id;
  final String nombre;

  CategoriaProducto({this.id, this.nombre});

  factory CategoriaProducto.toJson(Map<String,dynamic> json) => CategoriaProducto(
      id     : json['id'] ?? 0,
      nombre : json['nombre'] ?? '' 
  );
  
}