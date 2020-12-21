import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';

class Usuario {
  final int id,imagenVersion;
  final String 
      imagen,
      nombre,
      email,
      cedula,
      fechaCreacion;
  final List<Empresa> empresas;
  final bool administrador;
  Usuario(
      {
      this.id,
      this.imagenVersion,
      this.imagen,
      this.nombre,
      this.cedula,
      this.email,
      this.fechaCreacion,
      this.empresas,
      this.administrador
      });

  factory Usuario.toJson(Map<String, dynamic> json) 
    => json == null
       ?
       Usuario()
       :
       Usuario(
       id              : json['id']                 ?? 0,
       imagen          : json['imagen']             ?? '',
       imagenVersion   : json['imagen_version']     ?? 0,
       nombre          : json['nombre']             ?? '',
       cedula          : json['cedula']             ?? '',
       email           : json['usuario']            ?? '',
       fechaCreacion   : json['fecha']              ?? '',
       administrador   : json['administrador']      ?? false,
       empresas        : json['empresas']?.map<Empresa>((empresa)=>Empresa.toJson(empresa))?.toList()       

    );
Usuario copyWith({
  int     id,
  String  imagen,
  int     imagenVersion,
  String  nombre,
  String  cedula,
  String  biografia,
  String  sexo,
  String  fechaNacimiento,
  String  numero,
  String  email,
  String  fechaCreacion,
  bool administrador,
  List<Empresa> empresas
})
=> Usuario(  
   id              : id               ?? this.id,   
   imagen          : imagen           ?? this.imagen,
   imagenVersion   : imagenVersion    ?? this.imagenVersion,
   nombre          : nombre           ?? this.nombre,
   cedula          : cedula           ?? this.cedula,
   email           : email            ?? this.email,
   fechaCreacion   : fechaCreacion    ?? this.fechaCreacion,
   administrador   : administrador    ?? this.administrador,
   empresas        : empresas         ?? this.empresas,
);
}
