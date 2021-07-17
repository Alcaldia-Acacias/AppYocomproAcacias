import 'package:comproacacias/src/componetes/productos/models/categoriaProducto.model.dart';
import 'package:comproacacias/src/componetes/productos/models/producto.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponseProducto extends ResponseModel {
  final bool delete;
  final bool update;
  final Producto producto;
  final List<Producto> productos;
  final List<CategoriaProducto> categorias;
  ResponseProducto(
      {this.delete, this.update, this.producto,this.productos,this.categorias});
}
