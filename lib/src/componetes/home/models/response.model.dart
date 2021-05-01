import 'package:comproacacias/src/componetes/home/models/notificacion.model.dart';
import 'package:comproacacias/src/componetes/home/models/youtubeVideo.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponseHome extends ResponseModel {
  final List<YouTubeVideo> videos;
  final bool registrarToken, notificacionLeida;
  final String tokenAnonimo;
  final List<Notificacion> notificaciones;
  ResponseHome(
      {this.videos,
      this.registrarToken,
      this.tokenAnonimo,
      this.notificaciones,
      this.notificacionLeida});
}
