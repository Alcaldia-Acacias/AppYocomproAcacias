

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
    => Usuario(
       id              : json['id_usuario']               ?? 0,
       urlImagen       : json['imagen_usuario']           ?? '',
       nombre          : json['nombre_usuario']           ?? '',
       biografia       : json['biografia_usuario']        ?? '',
       sexo            : json['sexo_usuario']             ?? '',
       fechaNacimiento : json['fecha_nacimiento_usuario'] ?? '',
       numero          : json['numero']                   ?? '',
       email           : json['email_usuario']            ?? '',
       fechaCreacion   : json['creation_fecha_usuario']   ?? ''

    );
}
