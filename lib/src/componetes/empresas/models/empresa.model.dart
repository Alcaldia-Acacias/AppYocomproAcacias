
class Empresa {
  final int id,idCategoria;
  final String 
      nombre,
      urlLogo,
      urlPortada,
      descripcion,
      direccion,
      telefono,
      whatsapp,
      email,
      nit,
      web;
  final String latitud, longitud;
  final int popular;

  Empresa(
     {this.id,
      this.idCategoria,
      this.nombre,
      this.nit,
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
       nit        : json['NIT']         ?? '',
       urlLogo    : json['logo']        ?? '',
       urlPortada : json['portada']     ?? '',
       descripcion: json['descripcion'] ?? '',
       direccion  : json['direccion']   ?? '',
       telefono   : json['telefono']    ?? '',
       whatsapp   : json['whatsapp']    ?? '',
       email      : json['email']       ?? '',
       web        : json['web']         ?? '',
       latitud    : json['latitud']     ?? '',
       longitud   : json['longitud']    ?? '',
       popular    : json['popular']     ?? 0,
       idCategoria: json['id_categoria']
    );
Empresa copyWith({
   int id,
   int idCategoria,
   String nombre,
   String urlLogo,
   String urlPortada,
   String descripcion,
   String direccion,
   String telefono,
   String whatsapp,
   String email,
   String web,
   String latitud, 
   String longitud,
   bool popular
}) => Empresa(
      id         : id          ?? this.id,
      idCategoria: idCategoria ?? this.idCategoria,
      nombre     : nombre      ?? this.nombre,
      urlLogo    : urlLogo     ?? this.urlLogo,
      urlPortada : urlPortada  ?? this.urlPortada,
      descripcion: descripcion ?? this.descripcion,
      direccion  : direccion   ?? this.direccion,
      telefono   : telefono    ?? this.telefono,
      whatsapp   : whatsapp    ?? this.whatsapp,
      email      : email       ?? this.email,
      web        : web         ?? this.web,
      latitud    : latitud     ?? this.latitud,
      longitud   : longitud    ?? this.longitud,
      popular    : popular     ?? this.popular,
);

Map<String,dynamic> toMap(int idUsuario)=>{
      'id'           : id ?? null,
      'nombre'       : nombre,
      'NIT'          : nit,   
      'logo'         : urlLogo,   
      'portada'      : urlPortada, 
      'descripcion'  : descripcion,
      'direccion'    : direccion,   
      'telefono'     : telefono,   
      'whatsapp'     : whatsapp,   
      'email'        : email,       
      'web'          : web,      
      'latitud'      : latitud,    
      'longitud'     : longitud,   
      'popular'      : popular, 
      'id_usuario'   : idUsuario,
      'id_categoria' : idCategoria,
};

}
