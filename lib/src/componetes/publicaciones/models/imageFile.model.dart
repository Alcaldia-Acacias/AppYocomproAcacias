import 'dart:io';

class ImageFile {

  final File file;
  final String nombre;
  final bool isaFile;

  ImageFile({this.file, this.nombre,this.isaFile = false});
 
  ImageFile copyWith({
   File file,
   String nombre,
   bool isaFile
  }) => ImageFile(
        file   : file   ?? this.file,
        nombre : nombre ?? this.nombre,
        isaFile: isaFile  ?? this.isaFile
  );
}