class Categoria {
  
  final int id;
  final String nombre;

  Categoria({this.id, this.nombre});

  factory Categoria.toJson(Map<String, dynamic> json) => Categoria(
        id: json['id_categoria'],
        nombre: json['nombre_categoria'],
      );
      
}
