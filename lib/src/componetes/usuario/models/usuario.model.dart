import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';

class Usuario {
  final int id;
  final String 
      imagen,
      nombre,
      email,
      fechaCreacion;
  final List<Empresa> empresas;
  Usuario(
      {this.id,
      this.imagen,
      this.nombre,
      this.email,
      this.fechaCreacion,
      this.empresas
      });

  factory Usuario.toJson(Map<String, dynamic> json) 
    => json == null
       ?
       Usuario()
       :
       Usuario(
       id              : json['id']                 ?? 0,
       imagen          : json['imagen']             ?? '',
       nombre          : json['nombre']             ?? '',
       email           : json['usuario']            ?? '',
       fechaCreacion   : json['fecha']              ?? '',
       empresas        : json['empresas']?.map<Empresa>((empresa)=>Empresa.toJson(empresa))?.toList()       

    );
Usuario copyWith({
  int     id,
  String  imagen,
  String  nombre,
  String  biografia,
  String  sexo,
  String  fechaNacimiento,
  String  numero,
  String  email,
  String  fechaCreacion,
  List<Empresa> empresas
})
=> Usuario(  
   id              : id               ?? this.id,   
   imagen          : imagen           ?? this.imagen,
   nombre          : nombre           ?? this.nombre,
   email           : email            ?? this.email,
   fechaCreacion   : fechaCreacion    ?? this.fechaCreacion,
   empresas        : empresas         ?? this.empresas,
);
}
