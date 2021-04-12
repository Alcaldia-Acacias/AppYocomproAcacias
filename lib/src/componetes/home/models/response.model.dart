import 'package:comproacacias/src/componetes/home/models/youtubeVideo.model.dart';
import 'package:comproacacias/src/componetes/response/models/response.model.dart';

class ResponseHome extends ResponseModel {
  
  final List<YouTubeVideo> videos;
  final bool registrarToken;
  ResponseHome({this.videos,this.registrarToken});
  

}