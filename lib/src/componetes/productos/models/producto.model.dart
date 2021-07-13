class Producto {
  final String nombre, imagen,descripcion;
  final int precio,id;
  final List<String> imagenes;
  final bool oferta;

  Producto({
     this.id,
     this.nombre, 
     this.imagen, 
     this.precio,
     this.descripcion,
     this.imagenes,
     this.oferta
     });

  factory Producto.toJson(Map<String, dynamic> json) => Producto(
      id          : json['id']                ?? 0,
      nombre      : json['nombre']            ?? '',
      descripcion : json['descripcion']       ?? '',
      precio      : json['precio'],
      imagen      : json['imagen'] == "" ? '' : '${json['imagen']}',
      oferta      : json['oferta'] ?? false
      );

  Producto copyWith({
    int id,
    String nombre,
    String imagen,
    int precio,
    List<String> imagenes,
    bool oferta
  }) =>
      Producto(
          id    : id     ?? this.id,
          nombre: nombre ?? this.nombre,
          precio: precio ?? this.precio,
          imagen: imagen ?? this.imagen,
          imagenes: imagenes ?? this.imagenes,
          oferta: oferta ?? this.oferta
          );

  Map<String,dynamic> toMap([int idEmpresa])=>{
   "nombre"      : nombre,
   "precio"      : precio,
   "descripcion" : descripcion,
   "imagen"      : imagen,
   "id_empresa"  : idEmpresa
  };
}
