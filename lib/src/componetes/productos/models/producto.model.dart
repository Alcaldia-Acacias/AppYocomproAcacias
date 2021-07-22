import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/productos/models/categoriaProducto.model.dart';

class Producto {

  final String nombre,descripcion,descripcionOferta;
  final int precio,id,cantidad;
  final List<String> imagenes;
  final bool oferta;
  final Empresa empresa;
  final CategoriaProducto categoria;

  Producto({
     this.id,
     this.nombre,  
     this.precio,
     this.descripcion,
     this.descripcionOferta,
     this.imagenes,
     this.oferta,
     this.empresa,
     this.categoria,
     this.cantidad
     });

  factory Producto.toJson(Map<String, dynamic> json) => Producto(
      id                : json['id']                ?? 0,
      nombre            : json['nombre']            ?? '',
      descripcion       : json['descripcion']       ?? '',
      descripcionOferta : json['descripcion_oferta']?? '',
      precio            : json['precio'],
      oferta            : json['oferta']  ?? false,
      empresa           : Empresa.toJson(json['empresa']) ?? Empresa(),
      categoria         : CategoriaProducto.toJson(json['categoria']) ?? CategoriaProducto(),
      imagenes          : json['imagenes'].map<String>((imagen)=>'${imagen['nombre']}').toList() ?? [],
      cantidad          : 0
      );

  Producto copyWith({
    int id,
    String nombre,
    int precio,
    List<String> imagenes,
    bool oferta,
    Empresa empresa,
    CategoriaProducto categoria,
    String descripcionOferta,
    String descripcion,
    int cantidad
  }) =>
      Producto(
          id                : id                 ?? this.id,
          nombre            : nombre             ?? this.nombre,
          precio            : precio             ?? this.precio,
          imagenes          : imagenes           ?? this.imagenes,
          oferta            : oferta             ?? this.oferta,
          empresa           : empresa            ?? this.empresa,
          categoria         : categoria          ?? this.categoria,
          descripcionOferta : descripcionOferta  ?? this.descripcionOferta,
          descripcion       : descripcion        ?? this.descripcion,
          cantidad          : cantidad           ?? this.cantidad
      );

  Map<String,dynamic> toMap([int idEmpresa,int idProducto,int cantidad])=>{
   "id"          : idProducto, 
   "nombre"      : nombre,
   "precio"      : precio,
   "descripcion" : descripcion,
   "descripcion_oferta" : descripcionOferta,
   "id_empresa"  : idEmpresa,
   "id_categoria_producto" : categoria.id,
   "oferta"      : oferta,
   "cantidad"    : cantidad
  };
}
