class Reporte {
  final String detalle;
  final int idUsuario;
  final int motivo;

  Reporte({this.detalle, this.idUsuario, this.motivo});

  Map<String, dynamic> toMap() =>
      {"id_usuario": idUsuario, "motivo": motivo, "detalles": detalle};
}
