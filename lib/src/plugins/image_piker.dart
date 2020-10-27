import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageCapture {
  ImagePicker picker = ImagePicker();
  Future<File> getImage(String fuente) async {
    ImageSource source;
    if(fuente == 'archivo'){
      source = ImageSource.gallery;
    }
    if(fuente == 'camara'){
      source = ImageSource.camera;
    }
    final pickedFile = await this.picker.getImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

 
}
