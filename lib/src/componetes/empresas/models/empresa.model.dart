
class Empresa {
  final int id,idCategoria,idUsuario;
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
  final bool estado;
  Empresa(
     {this.id,
      this.idCategoria,
      this.idUsuario,
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
      this.estado,
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
       estado     : json['estado']      ?? false,
       idCategoria: json['id_categoria'],
       idUsuario  : json['id_usuario']
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
   int popular,
   bool estado
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
      estado     : estado      ?? this.estado
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
      'estado'       : estado, 
      'id_usuario'   : idUsuario,
      'id_categoria' : idCategoria,
};

}
