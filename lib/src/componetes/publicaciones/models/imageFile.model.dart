import 'dart:io';

class ImageFile {

  final File file;
  final String nombre;

  ImageFile({this.file, this.nombre});
 
  ImageFile copyWith({
   File file,
   String nombre
  }) => ImageFile(
        file   : file   ?? this.file,
        nombre : nombre ?? this.nombre
  );
}