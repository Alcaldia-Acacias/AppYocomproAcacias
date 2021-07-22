import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/usuario/models/usuario.model.dart';


class Pedido {
  
final List<Producto> productos;
final String observacion,id;
final Empresa empresa;
final Usuario usuario;


Pedido({this.id,this.empresa,this.usuario,this.observacion, this.productos});

factory Pedido.toJson(Map<String,dynamic> json) =>
        Pedido(
        id          : json['id'],
        productos   : json['productos'].map<Producto>((producto)=>Producto.toJson(producto)),
        observacion : json['observacion'],
        empresa     : Empresa.toJson(json['empresa']),
        usuario     : Usuario.toJson(json['usuario'])
        ); 


Map<String,dynamic> toMap(int idEmpresa,int idUsuario) =>{
  "id"          : id,
  "productos"   : productos,
  "id_empresa"  : idEmpresa,
  "id_usuario"  : idUsuario,
  "observacion" : observacion
};

Pedido copyWith({
  String id,
  List<Producto> productos,
  String observacion,
  Empresa empresa,
  Usuario usuario
}) => Pedido(
      id          : id          ?? this.id,
      productos   : productos   ?? this.productos,
      empresa     : empresa     ?? this.empresa,
      usuario     : usuario     ?? this.usuario,
      observacion : observacion ?? this.observacion
);


int calcularTotal(){
  int total = 0;
  this.productos.forEach((producto) { 
    total = total + (producto.precio * producto.cantidad);
  });
  return total;
}


}