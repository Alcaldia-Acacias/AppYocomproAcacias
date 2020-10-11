
class Empresa {
  final int id;
  final String 
      nombre,
      urlLogo,
      urlPortada,
      descripcion,
      direccion,
      telefono,
      whatsapp,
      email,
      web;
  final String latitud, longitud;
  final bool popular;

  Empresa(
     {this.id,
      this.nombre,
      this.urlLogo,
      this.urlPortada,
      this.descripcion,
      this.direccion,
      this.telefono,
      this.whatsapp,
      this.email,
      this.latitud,
      this.longitud,
      this.popular,
      this.web
     });

factory Empresa.toJson(Map<String,dynamic> json)
    => Empresa(
       id         : json['id']          ?? 0,
       nombre     : json['nombre']      ?? '',
       urlLogo    : json['logo']        ?? '',
       urlPortada : json['portada']     ?? '',
       descripcion: json['descripcion'] ?? '',
       direccion  : json['direccion']   ?? '',
       telefono   : json['telefono1']   ?? '',
       whatsapp   : json['whatsapp']    ?? '',
       email      : json['email']       ?? '',
       web        : json['web']         ?? '',
       latitud    : json['lat']         ?? '',
       longitud   : json['lng']         ?? '',
       popular    : json['popular']
    );


}
