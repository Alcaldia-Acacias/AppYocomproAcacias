
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
  final int popular;

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
    =>Empresa(
      id         : json['id_empresa'],
      nombre     : json['nombre_empresa']      ?? '',
      urlLogo    : json['logo_empresa']        ?? '',
      urlPortada : json['portada_empresa']     ?? '',
      descripcion: json['descripcion_empresa'] ?? '',
      direccion  : json['direccion_empresa']   ?? '',
      telefono   : json['telefono_empresa']    ?? '',
      whatsapp   : json['whatsapp_empresa']    ?? '',
      email      : json['email_empresa']       ?? '',
      web        : json['web_empresa']         ?? '',
      latitud    : json['latidud_empresa']     ?? '',
      longitud   : json['longitud_empresa']    ?? '',
      popular    : json['popular']
    );


}
