import 'dart:io';

class ImageFile {

  final File file;
  final String nombre;

  ImageFile({this.file, this.nombre});
 
  ImageFile copyWith({
   String path,
   String nombre
  }) => ImageFile(
        file   : path   ?? this.file,
        nombre : nombre ?? this.nombre
  );
}