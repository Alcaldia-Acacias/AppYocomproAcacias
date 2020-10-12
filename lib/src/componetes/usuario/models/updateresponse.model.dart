import 'package:comproacacias/src/componetes/usuario/models/update.model.dart';

class UpdateResponse extends UpdateModel {
 final bool update;
 UpdateResponse({this.update});
 factory UpdateResponse.toJson(Map<String, dynamic> json) 
  =>UpdateResponse(
    update :json['update']
  );
}