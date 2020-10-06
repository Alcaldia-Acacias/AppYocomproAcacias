class  Producto {

final String nombre,imagen;
final int precio;

Producto({this.nombre, this.imagen, this.precio}); 

factory Producto.toJson(Map<String,dynamic> json)
        => Producto(
           nombre: json['nombre'] ?? '',
           precio: json['precio'],
           imagen: json['imagen'] == "" ? '' : '${json['imagen']}.jpg' 
        );

}