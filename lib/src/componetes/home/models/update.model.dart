import 'package:comproacacias/src/componetes/empresas/models/empresa.model.dart';
import 'package:comproacacias/src/componetes/home/models/youtubeVideo.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class HomeResponse extends ResponseModel {
  final bool update;
  final bool addIngreso;
  final List<Empresa> empresas;
  final List<YouTubeVideo> videos;
  HomeResponse({this.update, this.empresas, this.addIngreso, this.videos});
}
