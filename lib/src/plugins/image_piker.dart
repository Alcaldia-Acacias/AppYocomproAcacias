import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageCapture {
  
  ImagePicker picker = ImagePicker();
  Future<File> getImage(String fuente) async {
    ImageSource source;
    if (fuente == 'archivo') {
      source = ImageSource.gallery;
    }
    if (fuente == 'camara') {
      source = ImageSource.camera;
    }
    try {
      final pickedFile = await this.picker.getImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (err) {
      print(err);
    }

    return null;
  }
}

class ImageCaptureAvatar extends ImageCapture {
  final height = 500;
  final width = 500;
}

class ImageCapturePublicacion extends ImageCapture {
  final height = 900;
  final width = 900;
}
