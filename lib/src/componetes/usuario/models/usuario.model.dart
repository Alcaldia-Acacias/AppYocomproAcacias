

class Usuario {
  final int id;
  final String 
      urlImagen,
      nombre,
      biografia,
      sexo,
      fechaNacimiento,
      numero,
      email,
      fechaCreacion;

  Usuario(
      {this.id,
      this.urlImagen,
      this.nombre,
      this.biografia,
      this.sexo,
      this.fechaNacimiento,
      this.numero,
      this.email,
      this.fechaCreacion});

  factory Usuario.toJson(Map<String, dynamic> json) 
    => json == null
       ? Usuario()
       :
       Usuario(
       id              : json['id']                 ?? 0,
       urlImagen       : json['imagen']             ?? '',
       nombre          : json['nombre']             ?? '',
       biografia       : json['biografia']          ?? '',
       sexo            : json['sexo']               ?? '',
       fechaNacimiento : json['nacimiento']         ?? '',
       numero          : json['numero']             ?? '',
       email           : json['correo']             ?? '',
       fechaCreacion   : json['fecha']              ?? ''

    );
}
