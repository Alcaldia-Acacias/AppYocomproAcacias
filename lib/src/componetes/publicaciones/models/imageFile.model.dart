class ImageFile {

  final String path;
  final String nombre;

  ImageFile({this.path, this.nombre});
 
  ImageFile copyWith({
   String path,
   String nombre
  }) => ImageFile(
        path   : path   ?? this.path,
        nombre : nombre ?? this.nombre
  );
}