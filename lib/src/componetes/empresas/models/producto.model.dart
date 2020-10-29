class Producto {
  final String nombre, imagen,descripcion;
  final int precio,id;

  Producto({this.id,this.nombre, this.imagen, this.precio,this.descripcion});

  factory Producto.toJson(Map<String, dynamic> json) => Producto(
      id          : json['id']                ?? 0,
      nombre      : json['nombre']            ?? '',
      descripcion : json['descripcion']       ?? '',
      precio      : json['precio'],
      imagen      : json['imagen'] == "" ? '' : '${json['imagen']}');

  Producto copyWith({
    int id,
    String nombre,
    String imagen,
    int precio,
  }) =>
      Producto(
          id    : id     ?? this.id,
          nombre: nombre ?? this.nombre,
          precio: precio ?? this.precio,
          imagen: imagen ?? this.imagen);

  Map<String,dynamic> toMap(int idEmpresa)=>{
   "nombre"      : nombre,
   "precio"      : precio,
   "descripcion" : descripcion,
   "imagen"      : imagen,
   "id_empresa"  : idEmpresa
  };
}
