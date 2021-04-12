class Categoria {
  
  final int id;
  final String nombre;

  Categoria({this.id, this.nombre});

  factory Categoria.toJson(Map<String, dynamic> json) => Categoria(
        id: json['id'],
        nombre: json['nombre'],
      );
      
}
